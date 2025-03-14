import 'package:flutter/material.dart';

class CustomLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue // Цвет линии
      ..style = PaintingStyle.fill;

    // Создаем путь для линии с клиньями
    Path path = Path();
    path.moveTo(0, size.height / 2); // Начинаем в центре по высоте

    // Левый клин
    path.lineTo(size.width * 0.2, size.height); // Левый нижний угол
    path.lineTo(size.width * 0.2, 0); // Левый верхний угол

    // Середина
    path.lineTo(size.width * 0.8, 0); // Правый верхний угол
    path.lineTo(size.width * 0.8, size.height); // Правый нижний угол

    path.lineTo(size.width, size.height / 2); // Завершаем линию в центре

    // Замыкаем путь
    path.lineTo(size.width * 0.2, size.height / 2); // Возвращаемся к центру
    path.close(); // Замыкаем путь

    canvas.drawPath(path, paint); // Рисуем путь
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class ThickerMiddleLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(200, 30), // Ширина и высота линии
      painter: CustomLinePainter(),
    );
  }
}
