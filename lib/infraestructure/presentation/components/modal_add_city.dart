import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:get_it/get_it.dart';
import 'package:weather_app/app/config/context/app_actions.dart';
import 'package:weather_app/app/config/context/app_state.dart';
import 'package:weather_app/app/config/style.dart';
import 'package:weather_app/core/domain.dart';
import 'package:weather_app/core/usecases/cities_use_case.dart';
import 'package:weather_app/core/usecases/weather_use_case.dart';

class ModalAddCity extends StatefulWidget {
  final City _cityToAdd;

  const ModalAddCity(this._cityToAdd, {Key? key}) : super(key: key);

  @override
  State<ModalAddCity> createState() => _ModalAddCityState();
}

class _ModalAddCityState extends State<ModalAddCity> {
  @override
  void initState() {
    super.initState();
    loadInfo();
  }

  void loadInfo() async {
    final cityName = widget._cityToAdd.description.split(',')[0];
    final latLong = await GetIt.I.get<CitiesUseCase>().getLatLong(cityName);
    final weatherInfo =
        await GetIt.I.get<WeatherUseCase>().getWeatherInfo(latLong);
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(
      builder: (context, store) {
        return Material(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  h3("  Add new city"),
                  IconButton(
                    icon: const Icon(CupertinoIcons.clear_thick),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              ElevatedButton(
                  onPressed: () => {
                        store.dispatch(
                          doAddCity(
                              City(description: widget._cityToAdd.description)),
                        ),
                        Navigator.of(context).pop()
                      },
                  child: p('Add')),
              const SizedBox(
                height: 30,
              )
            ],
          ),
        );
      },
    );
  }
}
