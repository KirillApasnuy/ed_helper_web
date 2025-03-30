import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../util/constants/app_colors.dart';

class TextButtonTypeOneGradient extends StatefulWidget {
  const TextButtonTypeOneGradient(
      {super.key, required this.text, required this.onPressed});

  final String text;
  final Function onPressed;

  @override
  State<TextButtonTypeOneGradient> createState() =>
      _TextButtonTypeOneGradientState();
}

class _TextButtonTypeOneGradientState extends State<TextButtonTypeOneGradient> {
  bool isPressed = false;
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: () => widget.onPressed(),
        onTapDown: (_) => setState(() => isPressed = true),
        onTapUp: (_) => setState(() => isPressed = false),
        onTapCancel: () => setState(() => isPressed = false),
        child: Container(
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.2),
                blurRadius: 5,
                spreadRadius: 1,
              )
            ],
            gradient: isPressed
                ? const LinearGradient(
                    colors: [
                      Colors.white,
                      Colors.white
                    ], // Градиент для isPressed
                  )
                : isHovered
                    ? const LinearGradient(
                        colors: [Color(0xff073D9B), Color(0xff001F3F)],
                        // Градиент для isHovered
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : LinearGradient(
                        colors: [
                          AppColors.textBtnTypeOneGradientStart,
                          AppColors.textBtnTypeOneGradientEnd
                        ], // Градиент по умолчанию
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
            borderRadius: BorderRadius.circular(30), // Закругление углов
          ),
          child: Center(
            child: Text(
              widget.text,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                color: isPressed ? const Color(0xff1C54B5) : AppColors.primary,
                fontSize: screenWidth < 900 ? 16 : 18.5,
                height: 1.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
    ;
  }
}
