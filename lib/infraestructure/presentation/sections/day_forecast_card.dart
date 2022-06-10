import 'package:flutter/material.dart';
import 'package:weather_app/app/config/global_variables.dart';
import 'package:weather_app/app/config/style.dart';
import 'package:weather_app/core/domain.dart';
import 'package:weather_app/infraestructure/presentation/components/horizontal_divider.dart';
import 'package:weather_app/infraestructure/presentation/components/horizontal_padding.dart';

class DayForecastCard extends StatelessWidget {
  final List<HourlyForecastItem> _listWeeklyForecastItem;

  const DayForecastCard(this._listWeeklyForecastItem, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        p("High temperatures next days", color: Colors.white),
        const HorizontalPadding(),
        const HorizontalDivider(),
        const HorizontalPadding(),
        SizedBox(
            height: 70,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: _listWeeklyForecastItem.length,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(0),
                itemBuilder: (context, index) {
                  return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          p("${_listWeeklyForecastItem[index].dateTime.hour} h",
                              color: Colors.white),
                          const HorizontalPadding(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              p("${_listWeeklyForecastItem[index].temperature} °",
                                  color: Colors.white),
                              const SizedBox(
                                width: 7,
                              ),
                              Image.network(
                                "$WEATHER_ICONS_URL${_listWeeklyForecastItem[index].weatherIcon}.png",
                                height: 30,
                                width: 30,
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
