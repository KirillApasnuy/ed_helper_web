import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class FormFieldTypeOne extends StatefulWidget {
  FormFieldTypeOne(
      {super.key,
      required this.controller,
      this.labelText,
      this.validator,
      this.hintText,
      this.icon,
      this.suffixIcon, this.onChanged, this.maxLines, this.isViewSuffixIcon, this.inputFormatters});

  final TextEditingController controller;
  final String? labelText;
  final String? hintText;
  final Widget? icon;
  final Widget? suffixIcon;
  bool? isViewSuffixIcon = false;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;
  @override
  State<FormFieldTypeOne> createState() => _FormFieldTypeOneState();
}

class _FormFieldTypeOneState extends State<FormFieldTypeOne> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        widget.labelText != null
            ? Text(
                widget.labelText!,
                style: GoogleFonts.montserrat(
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              )
            : Container(),
        const SizedBox(
          height: 10,
        ),
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            // color: Colors.white,
          ),
          child: TextFormField(
            style: GoogleFonts.montserrat(),
            inputFormatters: widget.inputFormatters,
            controller: widget.controller,
            cursorColor: Colors.black,
            onChanged: (value) => widget.onChanged != null ? widget.onChanged!(value) : null,
            cursorWidth: 1.5,
            maxLines: widget.maxLines != null ? widget.maxLines! : 1,
            minLines: 1,
            key: widget.key,
            validator: widget.validator != null ? widget.validator : null,
            decoration: InputDecoration(

                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: widget.icon,
                ),
                hintText: widget.hintText,
                hintStyle: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                  color: const Color(0xff252525),
                ),
                isDense: false,
                focusedBorder: OutlineInputBorder(

                  borderSide: const BorderSide(
                      color: Colors.black, width: 2, style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(30),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
                counterStyle: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w400),
                focusColor: Colors.red,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Color(0xff949494),
                      width: 2,
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(30),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Color(0xff949494),
                      width: 2,
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(30),
                )),
          ),
        ),

      ],
    );
  }
}
