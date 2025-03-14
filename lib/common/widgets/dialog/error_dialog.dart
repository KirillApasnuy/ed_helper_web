import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ErrorDialog extends StatefulWidget {
  const ErrorDialog({super.key, required this.title});

  final String title;

  @override
  State<ErrorDialog> createState() => _ErrorDialogState();
}

class _ErrorDialogState extends State<ErrorDialog> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _closeDialog();
  }

  Future<void> _closeDialog() async {
    await Future.delayed(const Duration(milliseconds: 5000)); // Задержка 5 секунд
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Container(
      width: 500,
      height: 500,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/svg/error.svg'),
            const SizedBox(height: 40),
            Text(widget.title,
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                )),
          ],
        ),
      ),
    ));
  }
}
