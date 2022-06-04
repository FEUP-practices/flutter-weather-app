import 'dart:ui';

import 'package:flutter/material.dart';

class CardInfo extends StatelessWidget {
  final Widget child;

  const CardInfo({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRect(
        child: Container(
      height: 200,
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          color: Color.fromARGB(126, 24, 17, 33),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Center(child: child),
    ));
  }
}
