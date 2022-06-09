import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:weather_app/core/domain.dart';
import 'package:weather_app/core/usecases/cities_use_case.dart';

class ModalCityOptions extends StatelessWidget {
  final City _city;

  const ModalCityOptions(this._city, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        child: SafeArea(
      top: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: const Text('Delete'),
            leading: const Icon(
              CupertinoIcons.delete,
              color: Colors.red,
            ),
            onTap: () => {
              GetIt.I.get<CitiesUseCase>().deleteCity(_city),
              Navigator.of(context).pop()
            },
          )
        ],
      ),
    ));
  }
}
