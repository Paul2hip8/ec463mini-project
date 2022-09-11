import 'package:flutter/material.dart';

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
      home: const what_is_this(),
    );
  }
}

class what_is_this extends StatelessWidget {
  const what_is_this({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("hello"),
          ),
          const TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Search a twitter user',
            ),
          ),
          TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            ),
            onPressed: () {},
            child: const Text('Search it!'),
          )
        ],
      ),
    );
  }
}
