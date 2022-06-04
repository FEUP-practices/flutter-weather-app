import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weather_app/app/config/configuration.dart';
import 'package:weather_app/app/config/context/app_state.dart';
import 'package:weather_app/infraestructure/presentation/pages/nav_bar.dart';

void main() async {
  await setUpEnv();
  WidgetsFlutterBinding.ensureInitialized();
  await setUpBeans();
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    runApp(StoreProvider<AppState>(
        store: await setUpStore(), child: const MyApp()));
  },
      (error, stack) => {
            print(stack),
            Fluttertoast.showToast(
                msg: error.toString(), toastLength: Toast.LENGTH_LONG)
          });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.deepPurple,
        ),
        home: const NavBar());
  }
}
