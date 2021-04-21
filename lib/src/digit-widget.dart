import 'dart:math';

import 'package:flutter/material.dart';

class DigitWidget extends StatefulWidget {
  final String value;
  TextStyle textStyle;
  num delayTime = 0;
  final bool animateSameValue;

  DigitWidget(this.value, this.delayTime, {this.textStyle, this.animateSameValue = true});

  @override
  DigitWidgetState createState() => DigitWidgetState();
}

class DigitWidgetState extends State<DigitWidget> with TickerProviderStateMixin {
  String oldValue = ' ';
  TextStyle textStyle;
  Size digitSize;

  Animation<double> animation;
  AnimationController controller;

  List<String> futureTasks = [];

  @override
  void initState() {
    // print('*****   Digit Widget  initState  *****');
    textStyle = widget.textStyle;
    digitSize = getSingleDigitSize(widget.value);
    initAnimation();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant DigitWidget oldWidget) {
    digitSize = getSingleDigitSize(widget.value);
    // print('digit rebuild: ${widget.value}');
    if (widget.animateSameValue) animate();
    super.didUpdateWidget(oldWidget);
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
        oldValue = '' + widget.value;
        controller.reset();
      }
    });

    animate();
  }

  isAVisible() => animation.value == 0;

  animate() async {
    Future.delayed(Duration(milliseconds: widget.delayTime), () {
      if(mounted) {
        controller.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // print('*****   Digit Widget  build, value is: ${widget.value}, Old value = $oldValue, New value=${widget.value}  *****');

    String a = oldValue;
    String b = widget.value;

    // animate();

    return Container(
      child: SizedOverflowBox(
        size: digitSize,
        alignment: Alignment.topCenter,
        child: ClipRect(
          clipper: DigitClipper(digitSize),
          child: Transform.translate(
            offset: Offset(0, -1 * animation.value),
            child: Column(
              children: [
                Text(a, style: textStyle),
                Text(b, style: textStyle),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getSingleDigitSize(String char) {
    final painter = TextPainter();
    painter.text = TextSpan(style: textStyle, text: char);
    painter.textDirection = TextDirection.ltr;
    painter.textAlign = TextAlign.left;
    painter.textScaleFactor = 1.0;
    painter.layout();
    return painter.size;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
