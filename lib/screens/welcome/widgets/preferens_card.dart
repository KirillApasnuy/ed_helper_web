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
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.all(screenWidth < 600 ? 30 : 50),
      constraints: const BoxConstraints(
        maxWidth: 1200,

      ),
      decoration: BoxDecoration(
        color: const Color(0xffCCE1F8),
        borderRadius: BorderRadius.circular(80),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
          )
        ],
      ),
      child: widget.child,
    );

  }
}
