# Flask web application

A python flask project that implements a website for user to check if a twitter user is a bot. It also analyze the sentiment of the most recent tweet of the user. 

## Development decision

At the beginning, we had the idea of using Flutter and Firebase to develop the project. After a week of learning Flutter, I found that it was to hard to learn and hard to debug. After trying some Flutter tutorials, learning multiple guides, and trying the codes tens of times, I decides to use Flask and Python instead. It turns out that Flask is much easier to use and gives me exactly what I want. The development goes on smoothly and I was able to develop the front and back end using Flask and using APIs as expected.

## Files
All the files related to flask project is inside the folder **flask_project**. The legacy folder contains only the files related to flutter. 

**Inside flask_project:**

​	app.py file contains the flask app for the front end. It renders the HTML files and gets the user input. 
​	back.py file contains the back end that should run on the cloud. It processes the requests run sent by front end and access the 	related APIs as requested. The result is then sent back to the front end.
​	template/first_time.html is the main page's html. It provides a page for user to input username of the Twitter user.
​	template/index.html is the result page, it displays the results of the user inquiry.

## Using the web
To simulate the usage of the web, first start the back end with 
```console
python back.app
```
The back end should be running at 127.0.0.1:20050
Then start the front end with 
```console
python app.py
```
The the front end can be accessed at 127.0.0.1:5000
The page is displayed like this:
![image](https://user-images.githubusercontent.com/60164575/192021809-dc2d0f55-c48f-41d6-9dea-602881d82d80.png)

Search "TwitterDev" gives an result page like this:
![image](https://user-images.githubusercontent.com/60164575/192021727-5371e86e-1f17-4ebc-ac97-80f2aae4b567.png)

Search a user that does not exist will give results like this

![image-20220925154724874](C:\Users\XTYAO\AppData\Roaming\Typora\typora-user-images\image-20220925154724874.png)

## References

https://github.com/johnschimmel/Python-Twitter-Flask-Example/blob/master/app.py

https://www.digitalocean.com/community/tutorials/how-to-handle-errors-in-a-flask-application

https://stackoverflow.com/questions/12277933/send-data-from-a-textbox-into-flask

https://stackoverflow.com/questions/51669102/how-to-pass-data-to-html-page-using-flask

https://github.com/IUNetSci/botometer-python

https://pub.dev/packages/twitter_api_v2

https://stackoverflow.com/questions/49797558/how-to-make-http-post-request-with-url-encoded-body-in-flutter

https://pub.dev/packages/http

https://stackoverflow.com/questions/65630743/how-to-solve-flutter-web-api-cors-error-only-with-dart-code

https://stackoverflow.com/questions/52824388/how-do-you-add-query-parameters-to-a-dart-http-request

https://pusher.com/tutorials/flutter-user-input/

https://petercoding.com/flutter/2021/07/18/using-github-actions-with-flutter/

https://www.youtube.com/watch?v=6ERQ__yqbk0
