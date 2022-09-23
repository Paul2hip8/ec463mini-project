# Flask web application

A python flask project that implements a wesite for user to check if a twitter user is a bot. It also analzye the sentiment of the most rrecent tweet of the user. 

## Files
app.py file contains the flask app for the front end. It renders the HTML files and gets the user input. 
back.py file contains the back end that should run on the cloud. It processes the requests run sent by front end and access the relarted APIs ased on request. The result is then sent ack to the front end.
template/first_time.html is the main page's html. It proivides a page for user to input.
template/index.html is the result page, it displays the results of the user inquery.

## Using the web
To simulate the useage of the web, first start the back end with 
```console
python back.app
```
The back end should be running at 127.0.0.1:20050
Then start the fron end with 
```console
python app.py
```
The the front end can be accessed at 127.0.0.1:5000
