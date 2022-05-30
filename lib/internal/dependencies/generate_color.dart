import 'package:flutter/material.dart';
import 'package:passmanager_diplom/constant/type_extensions.dart';

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

  static Color generateExtension(String extension) {
    int count =
        TypeExtension.extensions.indexWhere((element) => element == extension);
    print(count);
    if (count <= 4) {
      return Colors.orange;
    }
    if (count == 5) {
      return Colors.red;
    }
    if (count <= 7) {
      return Colors.green;
    }
    if (count <= 9) {
      return Colors.blue;
    }
    return Colors.transparent;
  }
}
