# app.py
from flask import Flask, request, jsonify
from google.cloud import language_v1
import botometer
import google.cloud

app = Flask(__name__)

rapidapi_key = "84024ab43bmsha3a872b3d68e5bdp1584e6jsn8d08ba92e9bf"
twitter_app_auth = {
    'consumer_key': 'c5uB923Kxhmm4CbTN2H9xbd5w',
    'consumer_secret': 'ubA7OYSwgvsxjHsv9DRWHgY7Z466BWLS1fbEcuKSAd4JtAVKo2',
    'access_token': '1568054324311343106-q5JIqaAInwtOAvfWDBrEb7xKgOE3s9',
    'access_token_secret': 'lUAZ0ua2ck8XiINxmkGjTbGtAFhWNhnW13lRjEU8ufPeJ',
  }
bom = botometer.Botometer(wait_on_ratelimit=True,
                          rapidapi_key=rapidapi_key,
                          **twitter_app_auth)

def sample_analyze_entity_sentiment(text_content):
    client = language_v1.LanguageServiceClient()
    # text_content = 'Grapes are good. Bananas are bad.'
    type_ = language_v1.types.Document.Type.PLAIN_TEXT
    encoding_type = language_v1.EncodingType.UTF8

    response = client.analyze_entity_sentiment(request = {'document': document, 'encoding_type': encoding_type})
    # Loop through entitites returned from the API
    for entity in response.entities:
        print(u"Representative name for the entity: {}".format(entity.name))
        # Get entity type, e.g. PERSON, LOCATION, ADDRESS, NUMBER, et al
        print(u"Entity type: {}".format(language_v1.Entity.Type(entity.type_).name))
        # Get the salience score associated with the entity in the [0, 1.0] range
        print(u"Salience score: {}".format(entity.salience))
        # Get the aggregate sentiment expressed for this entity in the provided document.
        sentiment = entity.sentiment
        print(u"Entity sentiment score: {}".format(sentiment.score))
        print(u"Entity sentiment magnitude: {}".format(sentiment.magnitude))

    print(u"Language of the text: {}".format(response.language))

def _find_next_id():
    return max(country["id"] for country in countries) + 1

@app.get("/countries")
def get_countries(id):
    if len(id) == 0:
        return {"error": "empty request"}, 415
    else:
        result = bom.check_account(id)
        return jsonify(result)
