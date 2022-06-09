import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:weather_app/app/config/global_variables.dart';
import 'package:weather_app/app/config/style.dart';
import 'package:weather_app/core/domain.dart';
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
        SizedBox(
            height: 55,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(0),
                itemBuilder: (context, index) {
                  return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          p("14 h", color: Colors.white),
                          const HorizontalPadding(),
                          Row(
                            children: [
                              p("27°", color: Colors.white),
                              const SizedBox(
                                width: 7,
                              ),
                              const Icon(
                                Icons.wb_sunny,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ],
                      ));
                }))
      ],
    );
  }
}
