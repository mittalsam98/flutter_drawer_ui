import 'package:flutter/material.dart';
import 'dart:math' as math;

class SecondDesign extends StatefulWidget {
  @override
  _SecondDesignState createState() => _SecondDesignState();
}

class _SecondDesignState extends State<SecondDesign>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  final double maxSlide = 255;
  @override
  void initState() {
    // TODO: implement initState
    animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));

    super.initState();
  }

  void toggle() {
    animationController.isDismissed
        ? animationController.forward()
        : animationController.reverse();
  }

  void _onHorizontalDrag(DragEndDetails details) {
    toggle();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GestureDetector(
          onHorizontalDragEnd: (DragEndDetails details) =>
              _onHorizontalDrag(details),
          child: AnimatedBuilder(
            animation: animationController,
            builder: (context, _) {
              return Transform.translate(
                offset: Offset(200 * (animationController.value - 1), 0),
                child: Transform(
                  transform: Matrix4.identity()
//                  ..setEntry(3, 2, 0.001)
                    ..rotateY(
                      math.pi / 2 * (1 - animationController.value),
                    ),
//                ..rotateZ(slide),
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: maxSlide,
                    height: double.infinity,
                    color: Colors.lightGreen,
                  ),
                ),
              );
            },
          ),
        ),
        GestureDetector(
          onHorizontalDragEnd: (DragEndDetails details) =>
              _onHorizontalDrag(details),
          child: AnimatedBuilder(
            animation: animationController,
            builder: (context, _) {
              return Transform.translate(
                offset: Offset(maxSlide * animationController.value, 0),
                child: Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(
                      math.pi * animationController.value / 2,
                    ),
//                ..rotateZ(slide),
                  alignment: Alignment.centerLeft,
                  child: Scaffold(
                    appBar: AppBar(
                      leading: GestureDetector(
                        onTap: toggle,
                        child: Icon(Icons.menu),
                      ),
                      title: Text('My app'),
                    ),
                    body: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('Hi there'),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
