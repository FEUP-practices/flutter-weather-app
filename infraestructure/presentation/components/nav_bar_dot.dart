import 'package:flutter/material.dart';

class NavBarDot extends StatelessWidget {
  final Color? color;

  const NavBarDot({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      width: 10,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}
