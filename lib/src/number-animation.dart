import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'digit-widget.dart';

class NumberAnimation extends StatefulWidget {
  TextStyle textStyle;
  Duration timeBetweenFlips = Duration(milliseconds: 400);

  NumberAnimation({this.textStyle, this.timeBetweenFlips, Key key}) : super(key: key);

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

    if (widget.textStyle == null) {
      widget.textStyle = TextStyle(fontSize: 25);
    }

    /*Future.delayed(Duration(milliseconds: 200), () {
      setValue(Random().nextInt(1000).toString());
    });*/
  }

  setValue(String newValue) {
    print('got $newValue');
    if (digits.length == 0) {
      digits = newValue.runes.map((rune) => String.fromCharCode(rune)).toList();
      digits.forEach((digit) {
        GlobalKey<DigitWidgetState> key = GlobalKey<DigitWidgetState>();
        keys.add(key);
        digitWidgets.add(DigitWidget(digit, key: key, textStyle: widget.textStyle));
      });
      setState(() {});
      return;
    }
    var newDigits = newValue.runes.map((rune) => String.fromCharCode(rune)).toList();

    // remove last items if new value is shorter
    while (newDigits.length < digits.length) {
      digits.removeLast();
      keys.removeLast();
      digitWidgets.removeLast();
    }

    for (int i = 0; i < newDigits.length; ++i) {
      Future.delayed(Duration(milliseconds: (i * widget.timeBetweenFlips.inMilliseconds) + 200), () {
        String currentDigit = newDigits[i];
        if (i < digits.length) {
          // just replace digit
          digits[i] = currentDigit;
          keys[i].currentState.setValue(currentDigit);
          setState(() {});
          return;
        }

        // new digit
        digits.add(currentDigit);
        GlobalKey<DigitWidgetState> key = GlobalKey<DigitWidgetState>();
        keys.add(key);
        digitWidgets.add(DigitWidget(currentDigit, key: keys[i], textStyle: widget.textStyle));
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        // setValue(Random().nextInt(10000).toString());
        // setValue('Hii there');
      },
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: digitWidgets,
        ),
      ),
    );
  }
}
