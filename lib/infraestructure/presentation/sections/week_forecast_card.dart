import 'package:flutter/material.dart';
import 'package:weather_app/app/config/style.dart';
import 'package:weather_app/infraestructure/presentation/components/horizontal_divider.dart';
import 'package:weather_app/infraestructure/presentation/components/horizontal_padding.dart';

class WeekForecastCard extends StatelessWidget {
  const WeekForecastCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        p("Forecast (10-day)", color: Colors.white),
        const HorizontalPadding(),
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 10,
            padding: EdgeInsets.all(0),
            itemBuilder: ((context, index) => Column(children: [
                  const HorizontalDivider(),
                  const HorizontalPadding(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      p("Tod.", color: Colors.white),
                      Icon(Icons.wb_sunny, color: Colors.white),
                      p("min: 18°", color: Colors.white),
                      p("max: 25°", color: Colors.white),
                    ],
                  ),
                  const HorizontalPadding()
                ]))),
      ],
    );
  }
}
