import 'package:flutter/material.dart';

class ChatCard extends StatefulWidget {
  ChatCard({super.key, required this.child, this.maxWidth = 1200, this.isPadding = true, this.isViewLogo = true});
  final Widget child;
  double maxWidth;
  final isPadding;
  final bool isViewLogo;
  @override
  State<ChatCard> createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {
  @override
  Widget build(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        decoration: const BoxDecoration(
        color: Color(0xffF1F7FC),
            shape: BoxShape.rectangle,
            boxShadow: [
              BoxShadow(
                color: Color(0x260F4CB4),
                spreadRadius: 3,
                blurRadius: 30,

              )
            ]
        ),
        child: Stack(
          children: [
            if (widget.isViewLogo) Positioned(
              top: 100,
              child: Transform.translate(
                offset: const Offset(-290, 0),
                child: Image.asset(
                  "assets/logo_back_transparet.png",
                  fit: BoxFit.cover,
                  width: 800,
                  height: 800,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(screenWidth < 500 ? 10:20),
              constraints: BoxConstraints(
                maxWidth: widget.maxWidth,

              ),

              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  widget.child,
                ],
              ),
            ),


          ],
        ),
      ),
    );
  }
}
