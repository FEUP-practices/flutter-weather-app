import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/core/domain.dart';

class CitiesPersistentStorage {
  final SharedPreferences _sp;

  CitiesPersistentStorage(this._sp);

  List<City> getCities() {
    var citiesJson = _sp.getString('cities');
    if (citiesJson == null) return [];
    return jsonDecode(citiesJson)
        .map<City>((city) => City.fromJson(city))
        .toList();
  }

  void deleteCity(City city) {
    var cities = getCities();
    cities.removeWhere((c) => c.description == city.description);
    _saveCities(cities);
  }

  void addCity(City city) {
    var cities = getCities();
    if (cities.contains(city)) return;
    cities.add(city);
    _saveCities(cities);
  }

  void _saveCities(List<City> cities) {
    _sp.setString('cities', jsonEncode(cities.map((e) => e.toJson()).toList()));
  }

  void updateCity(City city) {
    var cities = getCities();
    var index = cities.indexWhere((c) => c.description == city.description);
    if (index == -1) return;
    cities[index] = city;
    _saveCities(cities);
  }
}
