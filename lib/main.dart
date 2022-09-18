import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:twitter_api_v2/twitter_api_v2.dart' as v2;
import 'package:dart_twitter_api/twitter_api.dart';

import 'dart:io';
import 'package:oauth1/oauth1.dart' as oauth1;

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
          title: const Text('Flutter app1'),
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

  final String _textString = 'Search the Twitter User!';
  String displayText = "";
  String ReturnedText = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          _textString,
          style: const TextStyle(fontSize: 30),
        ),
        TextField(
          decoration: const InputDecoration(
              hintStyle: TextStyle(color: Colors.blue),
              hintText: "Enter account name, no@"),
          controller: textController,
        ),
        ElevatedButton(
          //                         <--- Button
          child: const Text('Search the account'),
          onPressed: () async {
            ReturnedText = "place_holder";
            // ReturnedText = await something(textController.text);
            Map<String, Object> resMap = await do_stuff("TwitterDev");
            // Map<String, dynamic> responseMap =
            await botometer(resMap);
            // ReturnedText = testing().toString();
            setState(() {
              displayText = ReturnedText;
            });
          },
        ),
        Text(
          ReturnedText,
          style: const TextStyle(fontSize: 30),
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

final twitterApi = TwitterApi(
  client: TwitterClient(
    consumerKey: 'c5uB923Kxhmm4CbTN2H9xbd5w',
    consumerSecret: 'ubA7OYSwgvsxjHsv9DRWHgY7Z466BWLS1fbEcuKSAd4JtAVKo2',
    token: '1568054324311343106-q5JIqaAInwtOAvfWDBrEb7xKgOE3s9',
    secret: 'lUAZ0ua2ck8XiINxmkGjTbGtAFhWNhnW13lRjEU8ufPeJ',
  ),
);

Future<Map<String, Object>> do_stuff(String usrName) async {
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
    oauthTokens: const v2.OAuthTokens(
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
    timeout: const Duration(seconds: 20),
  );

  try {
    // Get the authenticated user's profile.
    final targetUser = await twitter.usersService.lookupByName(
      username: usrName,
    );

    String userId = targetUser.data.id;
    // log(userId);
    // Get the tweets associated with the search query.

    // final timeline = await twitter.tweetsService.lookupTweets(
    //   userId: userId,
    //   maxResults: 100,
    //   expansions: [
    //     v2.TweetExpansion.authorId,
    //     v2.TweetExpansion.inReplyToUserId,
    //   ],
    //   tweetFields: [
    //     v2.TweetField.conversationId,
    //     v2.TweetField.publicMetrics,
    //   ],
    //   userFields: [
    //     v2.UserField.id,
    //     v2.UserField.name,
    //     v2.UserField.username,
    //     v2.UserField.location,
    //     v2.UserField.verified,
    //     v2.UserField.entities,
    //     v2.UserField.publicMetrics,
    //   ],
    // );

    var platform = new oauth1.Platform(
        'https://api.twitter.com/oauth/request_token', // temporary credentials request
        'https://api.twitter.com/oauth/authorize', // resource owner authorization
        'https://api.twitter.com/oauth/access_token', // token credentials request
        oauth1.SignatureMethods.hmacSha1 // signature method
        );

    const String apiKey = 'c5uB923Kxhmm4CbTN2H9xbd5w';
    const String apiSecret =
        'ubA7OYSwgvsxjHsv9DRWHgY7Z466BWLS1fbEcuKSAd4JtAVKo2';
    var clientCredentials = new oauth1.ClientCredentials(apiKey, apiSecret);

    var resCredentials = new oauth1.Credentials(
        '1568054324311343106-q5JIqaAInwtOAvfWDBrEb7xKgOE3s9',
        'lUAZ0ua2ck8XiINxmkGjTbGtAFhWNhnW13lRjEU8ufPeJ');

    var client = new oauth1.Client(
        platform.signatureMethod, clientCredentials, resCredentials);

    var uri = Uri.parse(
        // 'https://api.twitter.com/1.1/search/tweets.json?q=@$usrName&count=100&include_entities=true'
        'https://api.twitter.com/1.1/search/tweets.json?q=$usrName&include_entities=true');
    var returnedmentions = await client.get(uri);

    // print(returnedmentions.body);

    // final mentions = await twitter.tweetsService.lookupMentions(
    //   userId: userId,
    //   maxResults: 100,
    //   expansions: [
    //     v2.TweetExpansion.authorId,
    //     v2.TweetExpansion.inReplyToUserId,
    //   ],
    //   tweetFields: [
    //     v2.TweetField.conversationId,
    //     v2.TweetField.publicMetrics,
    //   ],
    //   userFields: [
    //     v2.UserField.id,
    //     v2.UserField.name,
    //     v2.UserField.username,
    //     v2.UserField.location,
    //     v2.UserField.verified,
    //     v2.UserField.entities,
    //     v2.UserField.publicMetrics,
    //   ],
    // );

    var uri1 = Uri.parse(
        'https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=$usrName&count=200&tweet_mode=extended&exclude_replies=false&include_rts=true&include_entities=true&trim_user=false');

    List<Tweet> returnedtimeline = await client.get(uri1).then((response) {
      final json = jsonDecode(response.body);
      final data = json as List;
      return data.map((e) => Tweet.fromJson(e)).toList();
    });
    // print(targetUser.data.toJson());
    // print(timeline.data.map((x) => x.toJson()).toList());
    // print(returnedtimeline.body);
    // print(mentions.includes?.users?.map((x) => x.toJson()).toList());

    // List tempList = [];

    // int i = 0;
    // while (i < 3) {
    //   Map<String, dynamic> tempMap = timeline.data[i].toJson();
    //   tempMap["user"] = timeline.includes?.users?[i].toJson();
    //   tempList.add(tempMap);
    //   i++;
    // }

    // // print(tempList[0]);
    // List tempList2 = [];
    // i = 0;
    // while (i < 94) {
    //   Map<String, dynamic> tempMap = mentions.data[i].toJson();
    //   tempMap["user"] = mentions.includes?.users?[i].toJson();
    //   tempList2.add(tempMap);
    //   i++;
    // }

    return {
      "user": {
        "id": targetUser.data.id.toString(),
        "screen_name": targetUser.data.username.toString(),
      },
      "timeline": returnedtimeline,
      "mentions": [],
    };
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
  return {
    "user": "error",
    "timeline": "error",
    "mentions": "error",
  };
}

Future<void> botometer(Map<String, Object> results) async {
  var uri = Uri.parse('https://botometer-pro.p.rapidapi.com/4/check_account');

  var response = await http.post(
    uri,
    body: jsonEncode(results),
    headers: {
      'content-type': 'application/json',
      'X-RapidAPI-Key': '84024ab43bmsha3a872b3d68e5bdp1584e6jsn8d08ba92e9bf',
      'X-RapidAPI-Host': 'botometer-pro.p.rapidapi.com'
    },
  );

  // log('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');

  // Map<String, dynamic> responseMap = jsonDecode(response.body);
  // return jsonDecode(response.body);
}

// Future<List<Tweet>> testing() async {
//   var returnedTimeline = await twitterApi.timelineService.userTimeline(
//     userId: "2244994945",
//     count: 200,
//     excludeReplies: false,
//     trimUser: false,
//     includeRts: true,
//   );

//   // print(userTimeline.body);
//   // userTimeline.forEach((element) {
//   //   print(element.text);
//   // });

//   // final params = <String, String>{
//   //   "screen_name": "realDonaldTrump",
//   // };

//   // TransformResponse<List<Tweet>> transform = defaultTweetListTransform;

//   // final resp = await twitterApi1.client.get(Uri.https(
//   //   'https://api.twitter.com',
//   //   '/1.1/users/lookup.json',
//   //   params,
//   // ));

//   return returnedTimeline;
// }
