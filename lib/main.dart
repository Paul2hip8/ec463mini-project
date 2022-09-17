import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:twitter_api_v2/twitter_api_v2.dart' as v2;
import 'package:twitter_api_v2/twitter_api_v2.dart';

import 'package:twitter_oauth2_pkce/twitter_oauth2_pkce.dart';

import 'dart:developer';
import 'dart:async';
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter app1',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter app1'),
        ),
        body: MyWidget(),
      ),
    );
  }
}

// widget class
class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  TextEditingController textController = TextEditingController();

  String _textString = 'Search the Twitter User!';
  String displayText = "";
  String ReturnedText = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          _textString,
          style: TextStyle(fontSize: 30),
        ),
        TextField(
          decoration: InputDecoration(
              hintStyle: TextStyle(color: Colors.blue),
              hintText: "Enter account name, no@"),
          controller: textController,
        ),
        ElevatedButton(
          //                         <--- Button
          child: const Text('Search the account'),
          onPressed: () async {
            ReturnedText = "place_holder";
            ReturnedText = await something(textController.text);
            List results = await do_stuff("TwitterDev");
            await botometer(results);

            setState(() {
              displayText = ReturnedText;
            });
          },
        ),
        Text(
          ReturnedText,
          style: TextStyle(fontSize: 30),
        ),
      ],
    );
  }
}

Future<String> something(String username) async {
  String token =
      "AAAAAAAAAAAAAAAAAAAAAPSZgwEAAAAAbRTtPV6SA0splpK4DMbG%2BOz2aso%3DKsHqLjCKHx6C4RD8EsInMwYhEIXxUkbMlcPx0RkFUONZq92g0s";

  var uri = Uri.parse('https://api.twitter.com/2/users/by?usernames=$username');
  // Uri.parse('https://jsonplaceholder.typicode.com/albums/1');

  var response = await http.get(uri, headers: {
    "Authorization": 'Bearer $token',
  });
  log('Response status: ${response.statusCode}');
  log('Response body: ${response.body}');

  return response.body;
  // return "some_future_text";
}

Future<List> do_stuff(String usrName) async {
  //! You need to get keys and tokens at https://developer.twitter.com
  final twitter = v2.TwitterApi(
    //! Authentication with OAuth2.0 is the default.
    //!
    //! Note that to use endpoints that require certain user permissions,
    //! such as Tweets and Likes, you need a token issued by OAuth2.0 PKCE.
    //!
    //! The easiest way to achieve authentication with OAuth 2.0 PKCE is
    //! to use [twitter_oauth2_pkce](https://pub.dev/packages/twitter_oauth2_pkce)!
    bearerToken:
        'AAAAAAAAAAAAAAAAAAAAAPSZgwEAAAAAbRTtPV6SA0splpK4DMbG%2BOz2aso%3DKsHqLjCKHx6C4RD8EsInMwYhEIXxUkbMlcPx0RkFUONZq92g0s',

    //! Or perhaps you would prefer to use the good old OAuth1.0a method
    //! over the OAuth2.0 PKCE method. Then you can use the following code
    //! to set the OAuth1.0a tokens.
    //!
    //! However, note that some endpoints cannot be used for OAuth 1.0a method
    //! authentication.
    oauthTokens: v2.OAuthTokens(
      consumerKey: 'c5uB923Kxhmm4CbTN2H9xbd5w',
      consumerSecret: 'ubA7OYSwgvsxjHsv9DRWHgY7Z466BWLS1fbEcuKSAd4JtAVKo2',
      accessToken: '1568054324311343106-q5JIqaAInwtOAvfWDBrEb7xKgOE3s9',
      accessTokenSecret: 'lUAZ0ua2ck8XiINxmkGjTbGtAFhWNhnW13lRjEU8ufPeJ',
    ),

    //! Automatic retry is available when a TimeoutException occurs when
    //! communicating with the API.
    retryConfig: v2.RetryConfig.ofRegularIntervals(
      maxAttempts: 5,
      intervalInSeconds: 3,
    ),

    //! The default timeout is 10 seconds.
    timeout: Duration(seconds: 20),
  );

  try {
    // Get the authenticated user's profile.
    final targetUser = await twitter.usersService.lookupByName(
      username: usrName,
    );

    String userId = targetUser.data.id;
    // log(userId);
    // Get the tweets associated with the search query.
    final timeline = await twitter.tweetsService.lookupTweets(
      userId: userId,
      maxResults: 100,
    );

    final mentions = await twitter.tweetsService.lookupMentions(
      userId: userId,
      maxResults: 100,
    );

    return [targetUser, timeline, mentions];
  } on TimeoutException catch (e) {
    print(e);
  } on v2.UnauthorizedException catch (e) {
    print(e);
  } on v2.RateLimitExceededException catch (e) {
    print(e);
  } on v2.TwitterException catch (e) {
    print(e.response.headers);
    print(e.body);
    print(e);
  }
  return ["something is wrong"];
}

Future<String> botometer(List results) async {
  var uri = Uri.parse('https://botometer-pro.p.rapidapi.com/4/check_account');

  var response = await http.post(
    uri,
    body: jsonEncode(<String, List>{
      'data': results,
    }),
    headers: {
      'content-type': 'application/json',
      'X-RapidAPI-Key': '84024ab43bmsha3a872b3d68e5bdp1584e6jsn8d08ba92e9bf',
      'X-RapidAPI-Host': 'botometer-pro.p.rapidapi.com'
    },
  );

  log('Response status: ${response.statusCode}');
  log('Response body: ${response.body}');

  log(response.body);
  return response.body;
}
