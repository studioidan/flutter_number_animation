import 'dart:math';

import 'package:flutter/material.dart';

class DigitWidget extends StatefulWidget {
  final initialValue;
  TextStyle textStyle;

  DigitWidget(this.initialValue, {Key key,this.textStyle}) : super(key: key);

  @override
  DigitWidgetState createState() => DigitWidgetState();
}

class DigitWidgetState extends State<DigitWidget> with TickerProviderStateMixin {
  String a = ' ';
  String b = ' ';
  TextStyle textStyle;
  Size digitSize;

  Animation<double> animation;
  AnimationController controller;

  List<String> futureTasks = [];

  @override
  void initState() {
    textStyle = widget.textStyle;
    digitSize = getSingleDigitSize();
    a = widget.initialValue;
    b = widget.initialValue;
    initAnimation();

    setValue(widget.initialValue, noAnimation: false);
    super.initState();
  }

  initAnimation() {
    controller = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
    final Animation<double> curve = CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);
    animation = Tween(begin: 0.0, end: digitSize.height.toDouble()).animate(curve)
      ..addListener(() {
        setState(() {});
      });

    animation.addStatusListener((status) {
      if (controller.status == AnimationStatus.completed) {
        a = '' + b;
        setState(() {});
        controller.reset();

        // check for future tasks
        if (futureTasks.length > 0) {
          setValue(futureTasks[0]);
          futureTasks.removeAt(0);
        }
      }
    });
  }

  setValue(String newVal, {bool noAnimation = false}) {
    if (controller.value != 0) {
      futureTasks.add(newVal);
      return;
    }

    if (noAnimation) {
      a = '' + b;
      setState(() {});
      controller.reset();
      return;
    }

    print('set value: $newVal');
    b = newVal;
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () => setValue(Random().nextInt(10).toString()),
      child: Container(
        // color: Colors.lightBlue,
        child: SizedOverflowBox(
          size: digitSize,
          alignment: Alignment.topCenter,
          child: ClipRect(
            clipper: DigitClipper(digitSize),
            child: Transform.translate(
              offset: Offset(0, -1 * animation.value),
              child: Column(
                children: [
                  Text(
                    a,
                    style: textStyle,
                  ),
                  Text(
                    b,
                    style: textStyle,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  getSingleDigitSize() {
    final painter = TextPainter();
    painter.text = TextSpan(style: textStyle, text: '0');
    painter.textDirection = TextDirection.ltr;
    painter.textAlign = TextAlign.left;
    painter.textScaleFactor = 1.0;
    painter.layout();
    return painter.size;
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
}

class DigitClipper extends CustomClipper<Rect> {
  final Size digitSize;

  DigitClipper(this.digitSize);

  @override
  Rect getClip(Size size) => Rect.fromPoints(Offset.zero, Offset(digitSize.width, digitSize.height));

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) => false;
}
