import 'package:flutter/material.dart';
class AuthCard extends StatelessWidget {
  const AuthCard({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 500,
        minHeight: 200,
      ),
      color: Colors.black,
      child: child,
    );
  }
}
