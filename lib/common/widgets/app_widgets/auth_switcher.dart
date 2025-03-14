import 'package:flutter/material.dart';

class AuthSwitch extends StatefulWidget {
  @override
  _AuthSwitchState createState() => _AuthSwitchState();
}

class _AuthSwitchState extends State<AuthSwitch> {
  bool isLogin = true;
  double _indicatorPosition = 0.0;

  void _updateIndicatorPosition(double newPosition) {
    setState(() {
      _indicatorPosition = newPosition;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildAuthButton('Логин', isLogin, 0.0),
                _buildAuthButton('Регистрация', !isLogin, 1.0),
              ],
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              left: _indicatorPosition * (MediaQuery.of(context).size.width / 2 - 40),
              bottom: 0,
              child: Container(
                height: 2,
                width: 80,
                color: Colors.blue,
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Expanded(
          child: isLogin ? LoginUI() : RegisterUI(),
        ),
      ],
    );
  }

  Widget _buildAuthButton(String text, bool isActive, double position) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isLogin = text == 'Логин';
          _updateIndicatorPosition(position);
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}


class LoginUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Логин UI'),
    );
  }
}

class RegisterUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Регистрация UI'),
    );
  }
}