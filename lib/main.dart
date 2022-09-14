import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
              hintText: "Enter your name"),
          controller: textController,
        ),
        ElevatedButton(
          //                         <--- Button
          child: const Text('Search the account'),
          onPressed: () {
            ReturnedText = something() as String;
            setState(() {
              displayText = textController.text;
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

Future<String> something() async {
  var url = Uri.https("https://api.twitter.com/2/users/by?usernames=");
  var response = await http.get(
    url,
    headers: {
      "usernames": "TwitterDev,TwitterAPI", // Edit usernames to look up
      "user.fields":
          "created_at,description", // Edit optional query parameters here
      "expansions": "pinned_tweet_id",
      "User-Agent": "v2UserLookupJS",
      "authorization":
          "Bearer token here"
    },
  );
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');
  return response.body;
}
