import 'package:flutter/cupertino.dart';

class GenerateColor {
  static const List<Color> colorAvatar = [
    Color(0xFF7965C1),
    Color(0xFFDD4554),
    Color(0xFFA46EB9),
    Color(0xFFCB4F87),
    Color(0xFF155DBF),
    Color(0xFF8EEAEA),
    Color(0xFFDB863B),
    Color(0xFF7087EF),
    Color(0xFF0D90E0),
    Color(0xFF329A4B),
  ];

  static Color generate(int userId) {
    int colorIndex = userId - ((userId / 10).ceil() * 10);
    return colorAvatar[colorIndex.abs()];
  }
}
