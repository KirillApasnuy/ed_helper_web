import 'package:flutter/material.dart';

import 'background_logo.dart';
class BackgroundLogos extends StatelessWidget {
  const BackgroundLogos({super.key});

  @override
  Widget build(BuildContext context) {
    return
      Column(children: [
        const SizedBox(height: 500),
        Transform.translate(
            offset: const Offset(-200, 0),
            child: const BackgroundLogo(
              mainAxisAlignment: MainAxisAlignment.start,
            )),
        const SizedBox(height: 100),
        Transform.translate(
            offset: const Offset(150, 0),
            child: const BackgroundLogo(
              mainAxisAlignment: MainAxisAlignment.end,
            )),
        const SizedBox(height: 100),
        Transform.translate(
            offset: const Offset(-200, 0),
            child: const BackgroundLogo(
              mainAxisAlignment: MainAxisAlignment.start,
            )),
        const SizedBox(height: 100),
        Transform.translate(
            offset: const Offset(150, 0),
            child: const BackgroundLogo(
              mainAxisAlignment: MainAxisAlignment.end,
            )),
        const SizedBox(height: 100),
        Transform.translate(
            offset: const Offset(-200, 0),
            child: const BackgroundLogo(
              mainAxisAlignment: MainAxisAlignment.start,
            )),
        const SizedBox(height: 100),
        Transform.translate(
            offset: const Offset(150, 0),
            child: const BackgroundLogo(
              mainAxisAlignment: MainAxisAlignment.end,
            )),
        const SizedBox(height: 100),
      ]);
  }
}
