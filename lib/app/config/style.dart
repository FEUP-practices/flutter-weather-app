import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget h1(String text) => Text(
      text,
      style: const TextStyle(fontSize: 86, fontWeight: FontWeight.w200),
    );

Widget h2(String text) => Text(
      text,
      style: const TextStyle(fontSize: 42, fontWeight: FontWeight.w200),
      textAlign: TextAlign.center,
    );

Widget h3(String text) => Text(
      text,
      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w300),
      textAlign: TextAlign.center,
    );

Widget p(String text) => Text(
      text,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
    );

get mh20 => const EdgeInsets.symmetric(horizontal: 20);

inputStyle(TextEditingController? controller) => InputDecoration(
    contentPadding: const EdgeInsets.all(5),
    filled: true,
    fillColor: const Color.fromARGB(255, 52, 52, 52),
    hintText: "Search for a city",
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10)),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
            color: Color.fromARGB(255, 107, 107, 107), width: 1)),
    hintStyle: const TextStyle(
      color: Color.fromARGB(255, 178, 178, 178),
    ),
    prefixIcon: const Icon(
      CupertinoIcons.search,
      color: Color.fromARGB(255, 178, 178, 178),
    ),
    suffixIcon: IconButton(
        icon: const Icon(CupertinoIcons.clear,
            color: Color.fromARGB(255, 178, 178, 178)),
        onPressed: () => controller?.clear()));
