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
      decoration: BoxDecoration(
      color: Colors.black,
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.5),
            blurRadius: 20,
            spreadRadius: 10,
          )
        ]
      ),
      child: child,
    );
  }
}
