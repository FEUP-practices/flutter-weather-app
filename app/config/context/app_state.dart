import 'package:get_it/get_it.dart';
import 'package:weather_app/core/domain.dart';
import 'package:weather_app/core/usecases/cities_use_case.dart';

class AppState {
  // Global state
  List<City>? cities = [];

  AppState copyWith({List<City>? cities}) {
    this.cities = cities;
    return this;
  }
}
