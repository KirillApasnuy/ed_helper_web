import 'package:flutter/material.dart';

class PreferensCard extends StatefulWidget {
  PreferensCard({super.key, required this.child, this.axis = MainAxisSize.max});
  final Widget child;
  MainAxisSize axis;

  @override
  State<PreferensCard> createState() => _PreferensCardState();
}

class _PreferensCardState extends State<PreferensCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(50),
      constraints: const BoxConstraints(
        maxWidth: 1200,
      ),
      decoration: BoxDecoration(
        color: const Color(0xffCCE1F8),
        borderRadius: BorderRadius.circular(80),
      ),
      child: widget.child,
    );

  }
}
