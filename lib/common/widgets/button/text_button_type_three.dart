import 'package:ed_helper_web/util/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextButtonTypeThree extends StatefulWidget {
  TextButtonTypeThree(
      {super.key, required this.text, required this.onPressed, this.borderColor, this.suffixIcon, this.textColor});

  final String text;
  final Function onPressed;
  Color? borderColor = const Color(0xff1C54B5);
  Color? textColor = const Color(0xff000000);
  final Widget? suffixIcon;

  @override
  State<TextButtonTypeThree> createState() => _TextButtonTypeThreeState();
}

class _TextButtonTypeThreeState extends State<TextButtonTypeThree> {
  bool isHovered = false;
  bool isPressed = false;

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
          child: TextButton(
              onPressed: () => widget.onPressed(),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                !isPressed ? isHovered? AppColors.cardBackground : Colors.white : const Color(0xff1C54B5),
                foregroundColor: AppColors.cardBackground,

                surfaceTintColor: Colors.white,
                overlayColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                )
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: screenWidth < 900 ? 16 : 20, vertical: screenWidth < 900 ? 18 : 22),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.text,
                      style: GoogleFonts.montserrat(
                        color:
                        !isPressed ? Colors.black : AppColors.primary,
                        fontSize: screenWidth < 900 ?20 : 25,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    widget.suffixIcon != null ?
                    const SizedBox(width: 10) : const SizedBox(width: 0),
                    widget.suffixIcon != null ?
                    widget.suffixIcon! : const SizedBox(width: 0),

                  ],
                ),
              ))),
    );
  }
}
