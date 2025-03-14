import 'package:ed_helper_web/util/constants/app_colors.dart';
import 'package:flutter/material.dart';

class SwitcherTypeOne extends StatefulWidget {
  SwitcherTypeOne({super.key, required this.value, this.isValid = true, required this.onChanged});
  bool value;
  bool isValid;
  final ValueChanged<bool> onChanged;

  @override
  State<SwitcherTypeOne> createState() => _SwitcherTypeOneState();
}

class _SwitcherTypeOneState extends State<SwitcherTypeOne> {
  late bool _currentValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentValue = widget.value;
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300), // Длительность анимации


      child: Transform.scale(
        scale: 0.7,
        child: Switch(
          value: _currentValue,
          inactiveThumbColor: AppColors.primary, // Цвет "пальца" в неактивном состоянии
          inactiveTrackColor: widget.isValid ? const Color(0xff969696) : Colors.deepOrange,
          activeTrackColor: const Color(0xff20CB34),
          trackOutlineColor: MaterialStateProperty. resolveWith<Color?>((Set<MaterialState> states) {
            return !_currentValue ? const Color(0xff949494) : const Color(0xff20CB34); // Use the default color.
          }),
          onChanged: (_) {
            _currentValue = !_currentValue;
            widget.value = _currentValue;
            widget.onChanged(_currentValue);
          },
        ),
      ),
    );

  }
}
