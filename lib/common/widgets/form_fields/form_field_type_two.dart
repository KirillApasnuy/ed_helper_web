import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class FormFieldTypeTwo extends StatefulWidget {
  FormFieldTypeTwo(
      {super.key,
      required this.controller,
      this.labelText,
      this.validator,
      this.hintText,
      this.icon,
      this.suffixIcon,
      this.onChanged,
      this.maxLines,
      this.isViewSuffixIcon,
      this.listTile,
      this.isViewTile,
      required this.isVoiceRecorder,
      required this.onFieldSubmitted,
      this.minLines = 1});

  final TextEditingController controller;
  final String? labelText;
  final String? hintText;
  final Widget? icon;
  final Widget? suffixIcon;
  final Widget? listTile;
  bool? isViewTile = false;
  bool? isViewSuffixIcon = false;
  bool isVoiceRecorder = false;
  int minLines;
  final Function? validator;
  final Function? onChanged;
  final Function onFieldSubmitted;
  final int? maxLines;

  @override
  State<FormFieldTypeTwo> createState() => _FormFieldTypeTwoState();
}

class _FormFieldTypeTwoState extends State<FormFieldTypeTwo> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return widget.isVoiceRecorder
        ? SizedBox(
            height: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              // Скругляем углы
              child: SizedBox(
                height: 40,
                child: SvgPicture.asset(
                  "assets/svg/voice_message_field.svg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
        : Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
            ),
            constraints: const BoxConstraints(minHeight: 35),
            padding: EdgeInsets.all(widget.isViewTile! ? 5 : 0),
            child: !widget.isVoiceRecorder
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (widget.listTile != null) widget.listTile!,
                      if (widget.labelText != null)
                        Text(
                          widget.labelText!,
                          style: GoogleFonts.montserrat(
                              fontSize: 19,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                      TextFormField(
                        style: GoogleFonts.montserrat(),
                        onFieldSubmitted: (_) async =>
                            widget.onFieldSubmitted(),
                        controller: widget.controller,
                        cursorColor: Colors.black,
                        onChanged: (_) => widget.onChanged != null
                            ? widget.onChanged!()
                            : null,
                        cursorWidth: 1.5,
                        maxLines: widget.maxLines ?? 1,
                        minLines: widget.minLines,
                        validator: (value) => widget.validator != null
                            ? widget.validator!(value)
                            : null,
                        decoration: InputDecoration(
                          prefixIcon: widget.icon != null
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: widget.icon,
                                )
                              : null,
                          hintText: widget.hintText,
                          hintStyle: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                            color: const Color(0xff252525),
                          ),
                          isDense: false,
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.white,
                                width: 2,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: screenWidth < 500 ? 15 : 35,
                              vertical: 15),
                          counterStyle: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w400),
                          focusColor: Colors.red,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.white,
                                width: 2,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.white,
                                width: 2,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        textInputAction: TextInputAction.send,
                        // Меняет Enter на действие "Отправить"
                        keyboardType: TextInputType.text,
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp(r'\n')),
                          // Блокирует перенос строки
                        ],
                      ),
                    ],
                  )
                : const SizedBox(),
          );
  }
}
