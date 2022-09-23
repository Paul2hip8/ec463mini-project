# app.py
from flask import Flask, request, jsonify
import botometer
from google.cloud import language_v1
import six
import tweepy
import json

app = Flask(__name__)

consumer_key = "c5uB923Kxhmm4CbTN2H9xbd5w"
consumer_secret = "ubA7OYSwgvsxjHsv9DRWHgY7Z466BWLS1fbEcuKSAd4JtAVKo2"
access_token = "1568054324311343106-q5JIqaAInwtOAvfWDBrEb7xKgOE3s9"
access_token_secret = "lUAZ0ua2ck8XiINxmkGjTbGtAFhWNhnW13lRjEU8ufPeJ"

rapidapi_key = "84024ab43bmsha3a872b3d68e5bdp1584e6jsn8d08ba92e9bf"
twitter_app_auth = {
    'consumer_key': consumer_key,
    'consumer_secret': consumer_secret,
    'access_token': access_token,
    'access_token_secret': access_token_secret,
  }
bom = botometer.Botometer(wait_on_ratelimit=True,
                          rapidapi_key=rapidapi_key,
                          **twitter_app_auth)


@app.route('/')
def home_page():
    return '<h1>Welcome to my site!</h1>'

@app.route('/users/<user_id>', methods = ['GET'])
def user(user_id):
    if request.method == 'GET':
        result = bom.check_account(user_id);
        return result, 200
    else:
        return {"error": "Request must be JSON"}, 415

@app.route('/sent/<screen_name>', methods = ['GET'])
def sample_analyze_sentiment(screen_name):

    # authorization of consumer key and consumer secret
    auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
    
    # set access to user's access key and access secret 
    auth.set_access_token(access_token, access_token_secret)
    
    # calling the api 
    api = tweepy.API(auth)
    
    # screen name of the account to be fetched
    
    # fetching the statuses
    statuses = api.user_timeline(screen_name = screen_name, count = 5, include_rts = False)
    
    client = language_v1.LanguageServiceClient()

    if len(statuses) <= 0:
        return "no tweets found", 404
    else:
        return_json = {
            
        }
        content = statuses[0].text
        if isinstance(content, six.binary_type):
            content = content.decode("utf-8")

        type_ = language_v1.Document.Type.PLAIN_TEXT
        document = {"type_": type_, "content": content}

        response = client.analyze_sentiment(request={"document": document})
        sentiment = response.document_sentiment
        
        return_json["score"] = sentiment.score
        return_json["text"] =content
    
    return json.dumps(return_json), 200

    
if __name__ == '__main__':
    app.run(host='127.0.0.1', port=20050, debug=True)