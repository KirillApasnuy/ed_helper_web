import 'package:ed_helper_web/common/widgets/button/text_button_type_one.dart';
import 'package:ed_helper_web/common/widgets/pictures/svg_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../generated/l10n.dart';
import '../../../util/constants/app_colors.dart';


class CenterMainLogo extends StatefulWidget {
  const CenterMainLogo({super.key, required this.combination});
  final String combination;
  @override
  State<CenterMainLogo> createState() => _CenterMainLogoState();
}

class _CenterMainLogoState extends State<CenterMainLogo> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all( screenWidth < 500 ? 0 : 20),

        margin: const EdgeInsets.only(top: 80),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          color: screenWidth < 500 ? Colors.transparent : AppColors.mainLogoFill,
        ),
        constraints: const BoxConstraints(maxWidth: 400, maxHeight: 730),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  // const SizedBox(height: 20),
                  Container(
                    width: screenWidth < 500 ? 220 : 300,
                    height: screenWidth < 500 ? 225 : 310,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/logo_back.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          S.of(context).helloWords,
                          style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontSize: screenWidth < 600 ? 16:20,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          S.of(context).toAccessAdvancedFeaturesDownloadTheApp,
                          style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontSize: screenWidth < 600 ? 16:20,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 30),
                        TextButtonTypeOne(
                          text: S.of(context).downloadApp,
                          onPressed: () {},
                          suffix: const SvgIcons(path: "assets/logo/windows.svg", size: 25),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
