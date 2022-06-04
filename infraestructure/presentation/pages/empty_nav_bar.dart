import 'package:flutter/material.dart';
import 'package:weather_app/app/config/style.dart';
import 'package:weather_app/infraestructure/presentation/pages/city_search.dart';

class EmptyNavBar extends StatelessWidget {
  const EmptyNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: mh20,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          h2("Welcome to Portugal Weather App"),
          ElevatedButton(
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => const CitySearch())),
            child: p('Add new cities'),
          ),
        ]));
  }
}
