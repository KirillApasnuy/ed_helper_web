import 'package:flutter/material.dart';

class DotIndicator extends StatelessWidget {
  final int itemCount;
  final int currentIndex;
  final Function(int) onDotTapped;

  const DotIndicator({
    Key? key,
    required this.itemCount,
    required this.currentIndex,
    required this.onDotTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(itemCount, (index) {
        return GestureDetector(
          onTap: () => onDotTapped(index),
          child: Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: currentIndex == index ? Colors.blue :  const Color(0xffCCE1F8),
            ),
          ),
        );
      }),
    );
  }
}
