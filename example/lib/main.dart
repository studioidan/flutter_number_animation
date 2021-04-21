import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_number_animation/flutter_number_animation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Number Animation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String value = '1000';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter number animation'),
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: Container(
            child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NumberAnimation(value,
                  textStyle: TextStyle(fontSize: 60, color: Colors.deepOrange), timeBetweenSlides: Duration(milliseconds: 400)),
              SizedBox(height: 100),
              MaterialButton(
                  child: Text('Randomize number', style: TextStyle(color: Colors.white)),
                  color: Colors.deepPurple,
                  onPressed: () {
                    setState(() {
                      value = Random().nextInt(1000000).toString();
                    });
                  }),
              SizedBox(height: 30),
              MaterialButton(
                  child: Text('Test', style: TextStyle(color: Colors.white)),
                  color: Colors.deepPurple,
                  onPressed: () {
                    setState(() {});
                  })
            ],
          ),
        )));
  }
}
