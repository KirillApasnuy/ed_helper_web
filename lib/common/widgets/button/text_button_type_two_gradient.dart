import 'package:ed_helper_web/util/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextButtonTypeTwoGradient extends StatefulWidget {
  TextButtonTypeTwoGradient(
      {super.key,
      required this.text,
      required this.onPressed,
      this.borderColor,
      this.suffixIcon,
      this.textColor,
      this.backgroundColor = Colors.white,});

  final String text;
  final Function onPressed;
  Color? borderColor = const Color(0xff1C54B5);
  Color? textColor = const Color(0xff000000);
  Color backgroundColor;
  final Widget? suffixIcon;

  @override
  State<TextButtonTypeTwoGradient> createState() =>
      _TextButtonTypeTwoGradientState();
}

class _TextButtonTypeTwoGradientState extends State<TextButtonTypeTwoGradient> {
  bool isHovered = false;
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.all(5),
      child: MouseRegion(
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        child: GestureDetector(
            onTapDown: (_) => setState(() => isPressed = true),
            onTapUp: (_) => setState(() => isPressed = false),
            onTapCancel: () => setState(() => isPressed = false),
            child: TextButton(
                onPressed: () => widget.onPressed(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: !isPressed
                      ? isHovered
                          ? AppColors.cardBackground
                          : widget.backgroundColor
                      : const Color(0xff1C54B5),
                  foregroundColor: AppColors.cardBackground,
                  surfaceTintColor: Colors.white,
                  overlayColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: BorderSide(
                        color: widget.borderColor ?? const Color(0xff1C54B5),
                        width: 2),
                  ),
                ),
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                  child: Row(
                    mainAxisAlignment: widget.suffixIcon != null
                        ? MainAxisAlignment.spaceBetween
                        : MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        widget.text,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.montserrat(
                          color: !isPressed
                              ? widget.textColor ??
                                  widget.borderColor ??
                                  const Color(0xff1C54B5)
                              : AppColors.primary,
                          fontSize: screenWidth < 900 ? 16 : 18.5,
                          height: 1.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (widget.suffixIcon != null) const SizedBox(width: 10),
                      if (widget.suffixIcon != null) widget.suffixIcon!,
                    ],
                  ),
                ))),
      ),
    );
  }
}
