import 'package:flutter/material.dart';
import 'package:weather_app/app/config/style.dart';
import 'package:weather_app/infraestructure/presentation/components/horizontal_divider.dart';
import 'package:weather_app/infraestructure/presentation/components/horizontal_padding.dart';

class WeatherCharacteristics extends StatelessWidget {
  const WeatherCharacteristics({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          p("Other characteristics", color: Colors.white),
        ]),
        const HorizontalPadding(),
        const HorizontalDivider(),
        const HorizontalPadding(),
        p("Pressure: 23", color: Colors.white),
        const HorizontalPadding(),
        p("Precitipitation: 34 mm", color: Colors.white)
      ],
    );
  }
}
