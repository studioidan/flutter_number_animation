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
  GlobalKey<NumberAnimationState> key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Flutter number animation')),
        body: Container(
            child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NumberAnimation(key: key, textStyle: TextStyle(fontSize: 30), timeBetweenFlips: Duration(milliseconds: 200)),
              SizedBox(height: 100),
              MaterialButton(
                  child: Text('Random number', style: TextStyle(color: Colors.white)),
                  color: Colors.lightBlue,
                  onPressed: () {
                    key.currentState.setValue(Random().nextInt(100000).toString());
                  })
            ],
          ),
        )));
  }
}
