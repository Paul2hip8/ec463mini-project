import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
