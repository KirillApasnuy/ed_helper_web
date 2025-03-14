import 'package:flutter/material.dart';

class MessageClipper extends CustomClipper<Path> {
  final bool isUser;

  MessageClipper({required this.isUser});

  @override
  Path getClip(Size size) {
    double r = 16.0; // Радиус стандартных скруглений
    double dropSize = 20.0; // Размер "капли"

    Path path = Path();
    path.moveTo(0, r);
    path.quadraticBezierTo(0, 0, r, 0);
    path.lineTo(size.width - r, 0);
    path.quadraticBezierTo(size.width, 0, size.width, r);
    path.lineTo(size.width, size.height - r);

    if (isUser) {
      // "Капля" для отправителя (справа снизу)
      path.quadraticBezierTo(size.width, size.height, size.width - r, size.height);
      path.quadraticBezierTo(
          size.width - dropSize, size.height + dropSize, size.width - dropSize * 2, size.height);
    } else {
      // Обычное округление для собеседника (слева снизу)
      path.quadraticBezierTo(size.width, size.height, size.width - r, size.height);
    }

    path.lineTo(r, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - r);
    path.close();
    return path;
  }

  @override
  bool shouldReclip (CustomClipper<Path> oldClipper) => true;
}
