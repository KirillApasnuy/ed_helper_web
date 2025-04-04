import 'package:ed_helper_web/util/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextButtonTypeTwo extends StatefulWidget {
  TextButtonTypeTwo(
      {super.key, required this.text, required this.onPressed, this.borderColor, this.suffixIcon, this.textColor, this.mainAxisSize= MainAxisSize.max});

  final String text;
  final Function onPressed;
  final MainAxisSize mainAxisSize;
  Color? borderColor = const Color(0xff1C54B5);
  Color? textColor = const Color(0xff000000);
  final Widget? suffixIcon;

  @override
  State<TextButtonTypeTwo> createState() => _TextButtonTypeTwoState();
}

class _TextButtonTypeTwoState extends State<TextButtonTypeTwo> {
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
                  side: BorderSide(color: widget.borderColor ?? const Color(0xff1C54B5), width: 2),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                child: Row(
                  mainAxisAlignment: widget.suffixIcon != null ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
                  mainAxisSize: widget.mainAxisSize,
                  children: [
                    Text(
                      widget.text,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.montserrat(
                        color:
                            !isPressed ? widget.textColor ?? widget.borderColor ?? const Color(0xff1C54B5) : AppColors.primary,
                        fontSize: screenWidth < 900 ? 16 : 18.5,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    if (widget.suffixIcon != null) const SizedBox(width: 10),
                    if (widget.suffixIcon != null) widget.suffixIcon!,
                  ],
                ),
              ))),
    );
  }
}
