# Flask web application

A python flask project that implements a website for user to check if a twitter user is a bot. It also analzye the sentiment of the most recent tweet of the user. 

## Files
app.py file contains the flask app for the front end. It renders the HTML files and gets the user input. 
back.py file contains the back end that should run on the cloud. It processes the requests run sent by front end and access the related APIs as requested. The result is then sent back to the front end.
template/first_time.html is the main page's html. It proivides a page for user to input username of the Twitter user.
template/index.html is the result page, it displays the results of the user inquery.

## Using the web
To simulate the useage of the web, first start the back end with 
```console
python back.app
```
The back end should be running at 127.0.0.1:20050
Then start the front end with 
```console
python app.py
```
The the front end can be accessed at 127.0.0.1:5000
The page is diplayed like this:
![image](https://user-images.githubusercontent.com/60164575/192021809-dc2d0f55-c48f-41d6-9dea-602881d82d80.png)

Searh "TwitterDev" gives an result page like this:
![image](https://user-images.githubusercontent.com/60164575/192021727-5371e86e-1f17-4ebc-ac97-80f2aae4b567.png)
