from zipapp import create_archive
from flask import Flask, render_template, request, redirect, url_for
from flask_wtf import FlaskForm
from wtforms import StringField
from wtforms.validators import DataRequired
from wtforms import SubmitField

import json

import os
    
import requests
import botometer

# app = Flask(__name__)

# rapidapi_key = "84024ab43bmsha3a872b3d68e5bdp1584e6jsn8d08ba92e9bf"
# twitter_app_auth = {
#     'consumer_key': 'c5uB923Kxhmm4CbTN2H9xbd5w',
#     'consumer_secret': 'ubA7OYSwgvsxjHsv9DRWHgY7Z466BWLS1fbEcuKSAd4JtAVKo2',
#     'access_token': '1568054324311343106-q5JIqaAInwtOAvfWDBrEb7xKgOE3s9',
#     'access_token_secret': 'lUAZ0ua2ck8XiINxmkGjTbGtAFhWNhnW13lRjEU8ufPeJ',
#   }
# bom = botometer.Botometer(wait_on_ratelimit=True,
#                           rapidapi_key=rapidapi_key,
#                           **twitter_app_auth)

app = Flask(__name__) # create our flask app

SECRET_KEY = os.urandom(42)
app.config['SECRET_KEY'] = SECRET_KEY

class BasicForm(FlaskForm):
    ids = StringField("ID",validators=[DataRequired()])
    submit = SubmitField("Submit")
    
@app.route('/')
def my_form():
    return render_template('first_time.html')

@app.route('/', methods=['POST'])
def my_form_post():
    id = request.form['text']
    
    error_message =""
    # Check a single account by screen name
    try:
        result = requests.get('http://127.0.0.1:20050/users/'+id)
        
        result = result.json()
        dataEn= result.get('display_scores').get('english')
        # print(dataEn)
        dataUn = result.get('display_scores').get('universal')
        
    except:
        error_message = "can't score the user"
        return render_template('first_time.html',error_message = error_message)
    
    try:
        res = requests.get('http://127.0.0.1:20050/sent/'+id)
        
        res = res.json()
        tweet_text = res.get('text')
        print(tweet_text)
        tweet_score = res.get('score')
        message2 = "the user's most recent tweet is: \n" + tweet_text 
        message3 = "and the sentiment score is: " + str(tweet_score)+ " from -1.0 to +1.0, the higher the score, the more positive the tweet is"
    except:
        message2 = "user does not have tweets"
    
    return render_template('index.html',id = id, dataEn = dataEn, dataUn = dataUn, message2 = message2, message3 = message3)

if __name__ == "__main__":
    app.run(debug=True)



