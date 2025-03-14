import 'package:flutter/material.dart';
class BackgroundLogo extends StatefulWidget {
  const BackgroundLogo({super.key, required this.mainAxisAlignment});
  final MainAxisAlignment mainAxisAlignment;
  @override
  State<BackgroundLogo> createState() => _BackgroundLogoState();
}

class _BackgroundLogoState extends State<BackgroundLogo> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: widget.mainAxisAlignment,
      children: [
        Column(
          children: [
            Image.asset("assets/logo_back_transparet.png", fit: BoxFit.fill, width: width < 900 ? 450 :650, height:width < 900 ? 456 : 658,),
          ],
        )
      ],
    );
  }
}
