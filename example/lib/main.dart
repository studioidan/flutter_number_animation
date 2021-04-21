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
  // GlobalKey<NumberAnimationState> key1 = GlobalKey();
  // GlobalKey<NumberAnimationState> key2 = GlobalKey();

  // GlobalKey<NumberAnimationState> key3 = GlobalKey();

  var words = ['coding', 'is', 'fun!'];
  int wordPos = 0;

  String value1 = '1';
  String value2 = '';

  @override
  void initState() {
    super.initState();

    /* Timer.periodic(Duration(seconds: 3), (timer) {
      key1.currentState.setValue(Random().nextInt(100000).toString());
    });

    Timer.periodic(Duration(seconds: 1), (timer) {
      String minute = DateTime.now().minute.toString().padLeft(2, '0');
      String second = DateTime.now().second.toString().padLeft(2, '0');
      key2.currentState.setValue('$minute:$second');
    });

    Timer.periodic(Duration(seconds: 3), (timer) {
      key3.currentState.setValue(words[(++wordPos) % words.length]);
    });*/
  }

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
              NumberAnimation(value1,
                  animateSameValue: false,
                  textStyle: TextStyle(fontSize: 60, color: Colors.deepPurple),
                  timeBetweenSlides: Duration(milliseconds: 200)),
              SizedBox(height: 100),
              /*NumberAnimation(words[wordPos % words.length],
                  animateSameValue: false,
                  textStyle: TextStyle(fontSize: 60, color: Colors.red),
                  timeBetweenSlides: Duration(milliseconds: 0)),
              SizedBox(height: 100),
              NumberAnimation(value2,
                  textStyle: TextStyle(fontSize: 60, color: Colors.green), timeBetweenSlides: Duration(milliseconds: 200)),
              SizedBox(height: 100),*/
              MaterialButton(
                  child: Text('Randomize number',style: TextStyle(color: Colors.white)),
                  color: Colors.deepPurple,
                  onPressed: () {
                    setState(() {
                      value1 = ((Random().nextInt(1000000) + 0)).toString();

                      String minute = DateTime.now().minute.toString().padLeft(2, '0');
                      String second = DateTime.now().second.toString().padLeft(2, '0');
                      value2 = '$minute:$second';
                      wordPos++;
                    });
                  })
            ],
          ),
        )));
  }
}
