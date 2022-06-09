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
  final String _description;

  const ModalAddCity(this._description, {Key? key}) : super(key: key);

  @override
  State<ModalAddCity> createState() => _ModalAddCityState();
}

class _ModalAddCityState extends State<ModalAddCity> {
  late LatLong _latLong;

  @override
  void initState() {
    super.initState();
    loadInfo();
  }

  void loadInfo() async {
    final cityName = widget._description.split(',')[0];
    _latLong = await GetIt.I.get<CitiesUseCase>().getLatLong(cityName);
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
                        store.dispatch(doAddCity(
                          City(
                              description: widget._description,
                              latLong: _latLong),
                        )),
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
