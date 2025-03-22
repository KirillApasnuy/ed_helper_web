import 'package:ed_helper_web/common/widgets/pictures/svg_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';
import '../../../util/device/localization/locale_provider.dart';

class LanguageSelector extends StatefulWidget {
  LanguageSelector({super.key, this.isLong = false});

  bool isLong;

  @override
  _LanguageSelectorState createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  bool _isEnglish = true;

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    setState(() {
      _isEnglish = localeProvider.locale.languageCode == 'en';
    });
    return PopupMenuButton<String>(
      tooltip: S.of(context).selectLanguage,
      icon: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 16,
        children: [
          const SvgIcons(path: "assets/svg/land.svg", size: 40),
          if (widget.isLong) Text(S.of(context).language,
              style: GoogleFonts.montserrat(
                  fontSize: 18, fontWeight: FontWeight.w500))
        ],
      ),
      onSelected: (String value) {
        print(value);

        localeProvider.setLocale(Locale(value));
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        overlayColor: Colors.blue
      ),
      color: const Color(0xffCCE1F8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // Rounded corners
        side: const BorderSide(
          color: Color(0xff77ADED), // Border color
          width: 2, // Border width
        ),
      ),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'ru',
          height: 20,
          padding:
              const EdgeInsets.only(left: 30, right: 20, top: 10, bottom: 5),
          child: Row(
            spacing: 16,
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), // Скругление углов
                  border: Border.all(
                    color: Colors.black, // Цвет границы
                    width: 2, // Толщина границы
                  ),
                ),
                child: Transform.scale(
                  scale: 0.8, // Уменьшаем размер чекбокса
                  child: Checkbox(
                    value: !_isEnglish,
                    onChanged: (_) {
                      setState(() {
                        _isEnglish = !_isEnglish; // Переключение состояния
                      });
                    },
                    focusColor: Colors.black,
                    hoverColor: Colors.transparent,
                    activeColor: Colors.transparent,
                    // Прозрачный фон при активном состоянии
                    checkColor: Colors.black,
                    // Цвет галочки
                    tristate: false,
                    side: BorderSide.none,
                  ),
                ),
              ),
              Text(
                'Русский',
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'en',
          height: 20,
          padding:
              const EdgeInsets.only(left: 30, right: 20, top: 5, bottom: 10),
          child: Row(
            spacing: 16,
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), // Скругление углов
                  border: Border.all(
                    color: Colors.black, // Цвет границы
                    width: 2, // Толщина границы
                  ),
                ),
                child: Transform.scale(
                  scale: 0.8, // Уменьшаем размер чекбокса
                  child: Checkbox(
                    value: _isEnglish,
                    onChanged: (_) {
                      setState(() {
                        _isEnglish = !_isEnglish; // Переключение состояния
                      });
                    },
                    focusColor: Colors.black,
                    hoverColor: Colors.transparent,
                    activeColor: Colors.transparent,
                    // Прозрачный фон при активном состоянии
                    checkColor: Colors.black,
                    // Цвет галочки
                    tristate: false,
                    side: BorderSide.none,
                  ),
                ),
              ),
              Text(
                'English',
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
