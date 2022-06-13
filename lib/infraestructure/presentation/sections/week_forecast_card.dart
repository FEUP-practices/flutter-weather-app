import 'package:flutter/material.dart';
import 'package:weather_app/app/config/global_variables.dart';
import 'package:weather_app/app/config/style.dart';
import 'package:weather_app/core/domain.dart';
import 'package:weather_app/infraestructure/presentation/components/horizontal_divider.dart';
import 'package:weather_app/infraestructure/presentation/components/horizontal_padding.dart';

class WeekForecastCard extends StatelessWidget {
  final List<DailyForecastItem> _listDailyForecastItem;

  const WeekForecastCard(this._listDailyForecastItem, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        p("Forecast (${_listDailyForecastItem.length}-day)",
            color: Colors.white),
        const HorizontalPadding(),
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: _listDailyForecastItem.length,
            padding: const EdgeInsets.all(0),
            itemBuilder: ((context, index) => Column(children: [
                  const HorizontalDivider(),
                  const HorizontalPadding(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      p("Tod.", color: Colors.white),
                      Image.network(
                          "$WEATHER_ICONS_URL${_listDailyForecastItem[index].weatherIcon}.png",
                          height: 30,
                          width: 30),
                      p("min: ${_listDailyForecastItem[index].temperature.min.ceil()} °",
                          color: Colors.white),
                      p("max: ${_listDailyForecastItem[index].temperature.max.ceil()} °",
                          color: Colors.white),
                    ],
                  ),
                  const HorizontalPadding()
                ]))),
      ],
    );
  }
}
