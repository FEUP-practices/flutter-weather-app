import 'package:flutter/material.dart';

class CardInfo extends StatelessWidget {
  final Widget child;

  const CardInfo({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
          color: Color.fromARGB(148, 24, 17, 33),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: child,
    );
  }
}
