import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:get_it/get_it.dart';
import 'package:weather_app/app/config/context/app_actions.dart';
import 'package:weather_app/app/config/context/app_state.dart';
import 'package:weather_app/core/domain.dart';
import 'package:weather_app/core/usecases/cities_use_case.dart';

class ModalCityOptions extends StatelessWidget {
  final City _city;

  const ModalCityOptions(this._city, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(builder: (context, store) {
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
                store.dispatch(doRemoveCity(_city)),
                Navigator.of(context).pop()
              },
            )
          ],
        ),
      ));
    });
  }
}
