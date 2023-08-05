import 'package:flutter/material.dart';
import 'package:web_socket/WSdemo_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Web Socket Demo",
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Web Socket Demo",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.deepPurpleAccent,
        ),
        backgroundColor: Colors.blueGrey[300],
        body: WebSocketDemo(),
      ),
    );
  }
}
