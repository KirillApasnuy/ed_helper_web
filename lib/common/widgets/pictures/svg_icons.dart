import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIcons extends StatelessWidget {
  const SvgIcons({super.key, required this.path, required this.size, this.suffixIcon});
  final String path;
  final double size;
  final Widget? suffixIcon;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(path, width: size, height: size,),
            if (suffixIcon != null ) const SizedBox(width: 10,),
            if (suffixIcon != null ) suffixIcon!,
          ],
        ));
  }
}
