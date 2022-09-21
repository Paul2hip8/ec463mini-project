# app.py
from flask import Flask, request, jsonify
import botometer

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



def _find_next_id():
    return max(country["id"] for country in countries) + 1

@app.get("/countries")
def get_countries(id):
    if len(id) == 0:
        return {"error": "empty request"}, 415
    else:
        result = bom.check_account(id)
        return jsonify(result)
