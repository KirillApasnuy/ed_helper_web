import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextButtonTypeOne extends StatefulWidget {
  TextButtonTypeOne({super.key, required this.text, required this.onPressed, this.suffix, this.isPremium = false, this.mainAxisSize, this.isLoading = false});
  final bool isPremium;
  final MainAxisSize? mainAxisSize;
  final String text;
  final Function onPressed;
  final Widget? suffix;
  bool isLoading;
  @override
  State<TextButtonTypeOne> createState() => _TextButtonTypeOneState();
}

class _TextButtonTypeOneState extends State<TextButtonTypeOne> {
  bool isPressed = false;
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => isPressed = true),
        onTapUp: (_) => setState(() => isPressed = false),
        onTapCancel: () => setState(() => isPressed = false),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isPressed
                  ? [Colors.white, Colors.white] // Градиент при нажатии
                  : isHovered
                  ? [const Color(0xff073D9B), const Color(0xff1C54B5)] // Градиент при наведении
                  : widget.isPremium ? [const Color(0xff00BFCF),const Color(0xff1C54B5),] :[const Color(0xff1C54B5), const Color(0xff1C54B5)], // Стандартный градиент
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: Colors.transparent,
              width: 2,
            ),
          ),
          child: InkWell(
            onTap: () => widget.onPressed(),
            borderRadius: BorderRadius.circular(30),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: widget.mainAxisSize ?? MainAxisSize.max,
                children: [
                  widget.isLoading ? Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    width: 20,
                    height: 20,
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 3,
                    ),
                  ) : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.text,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          color: isPressed ? const Color(0xff1C54B5) : Colors.white, // Цвет текста
                          fontSize: screenWidth < 900 ? 16 : 18.5,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  if (widget.suffix != null) widget.suffix!,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
