import 'dart:async';

import 'package:flutter/material.dart';

/// Класс отвечающий за кастомный элемент за его логику и отрисовку
class FloatingActionMessage extends StatefulWidget {
  const FloatingActionMessage({Key? key, required this.color})
      : super(key: key);
  final Color color;

  @override
  _FloatingActionMessageState createState() =>
      _FloatingActionMessageState(color);
}

class _FloatingActionMessageState extends State<FloatingActionMessage> {
  final Color color;
  bool isCheck = false;

  _FloatingActionMessageState(this.color);

  @override
  Widget build(BuildContext context) {
    return isCheck
        ? Container(
            padding: EdgeInsets.all(7),
            child: const Text(
              "\n",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ))
        : InkWell(
            onTap: () {
              Timer(Duration(milliseconds: 10000), () {
                setState(() {
                  isCheck = false;
                });
              });
              setState(() {
                isCheck = true;
              });
            },
            child: CustomPaint(
                painter: _ShapesPainter(color),
                child: Container(
                    padding: EdgeInsets.all(7),
                    child: const Text(
                      "Нажмите, чтобы \n добавить запись",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ))),
          );
  }
}

/// Класс который вырисовывает кастомный эелмент
class _ShapesPainter extends CustomPainter {
  final Color color;

  _ShapesPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = color;
    double radius = 5;
    var path = Path()
      ..lineTo(size.width - radius, 0)
      ..arcToPoint(Offset(size.width, radius), radius: Radius.circular(radius))
      ..lineTo(size.width, size.height - radius)
      ..arcToPoint(Offset(size.width - radius, size.height),
          radius: Radius.circular(radius))
      ..lineTo(radius, size.height)
      ..lineTo(size.width * 0.8, size.height)
      ..lineTo(size.width * 0.95, size.height * 1.25)
      ..lineTo(size.width * 0.92, size.height)
      ..lineTo(radius, size.height)
      ..arcToPoint(Offset(0, size.height - radius),
          radius: Radius.circular(radius))
      ..lineTo(0, radius)
      ..arcToPoint(Offset(radius, 0), radius: Radius.circular(radius))
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
