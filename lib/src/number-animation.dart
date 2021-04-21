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

  List<GlobalKey<DigitWidgetState>> keys = [];
  List<DigitWidget> digitWidgets = [];
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

    // print('*****   Number Animation  build ${isNewValue ? ' Value changed from $value to ${widget.value}' : ''}  (value is: ${widget.value})*****');
    value = widget.value;

    List<Widget> items = [];
    for (int i = 0; i < value.runes.length; ++i) {
      String char = String.fromCharCode(value.runes.elementAt(i));
      items.add(DigitWidget(char, 200 * i, textStyle: widget.textStyle));
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
