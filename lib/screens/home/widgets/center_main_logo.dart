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

    double size = screenWidth ;
    double logoSize = screenWidth < 700 ? 200 :
    size * 0.3 >= 800 ? 800 : (size * 0.8 <= 200 ? 200 : size * 0.8) - 350;
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          color: AppColors.mainLogoFill,
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
                  Container(
                    width: logoSize,
                    height: logoSize,
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
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          S.of(context).toAccessAdvancedFeaturesDownloadTheApp,
                          style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
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
