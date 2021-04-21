import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'digit-widget.dart';

class NumberAnimation extends StatefulWidget {
  TextStyle textStyle;
  Duration timeBetweenSlides = Duration(milliseconds: 400);
  final String value;
  final bool animateSameValue;

  NumberAnimation(this.value, {this.textStyle, this.timeBetweenSlides, this.animateSameValue = true});

  @override
  NumberAnimationState createState() => NumberAnimationState();
}

class NumberAnimationState extends State<NumberAnimation> {
  String value;

  List<Widget> items = [];
  List<String> digits = [];

  @override
  void initState() {
    super.initState();

    print('*****    Number Animation initState  *****');
    if (widget.textStyle == null) {
      widget.textStyle = TextStyle(fontSize: 25);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isNewValue = value != widget.value;
    print('is new value = $isNewValue');

    // update widget list only if value has changed
    if (isNewValue) {
      value = widget.value;
      items = [];
      for (int i = 0; i < value.runes.length; ++i) {
        String char = String.fromCharCode(value.runes.elementAt(i));
        items.add(DigitWidget(char, widget.timeBetweenSlides.inMilliseconds * i, textStyle: widget.textStyle));
      }
    }

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: items,
      ),
    );
  }
}
