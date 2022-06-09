import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:weather_app/app/config/style.dart';
import 'package:weather_app/infraestructure/presentation/components/horizontal_divider.dart';
import 'package:weather_app/infraestructure/presentation/components/horizontal_padding.dart';

class DayForecastCard extends StatelessWidget {
  const DayForecastCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        p("High temperatures next days", color: Colors.white),
        const HorizontalPadding(),
        const HorizontalDivider(),
        const HorizontalPadding(),
        const HorizontalPadding()
      ],
    );
  }
}
