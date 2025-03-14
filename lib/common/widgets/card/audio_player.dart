import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AudioPlayerAnimation extends StatefulWidget {
  @override
  _AudioPlayerAnimationState createState() => _AudioPlayerAnimationState();
}

class _AudioPlayerAnimationState extends State<AudioPlayerAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    )..addListener(() {
      setState(() {});
    });

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 40,
        width: 40,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SvgPicture.asset(
              "assets/svg/voice_message.svg",
              fit: BoxFit.cover,
            ),
            Positioned(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  height: 40 * _animation.value,
                  width: 40 * _animation.value,
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}