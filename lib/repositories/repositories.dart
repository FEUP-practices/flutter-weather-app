import 'package:weather_app/core/domain.dart';
import 'package:weather_app/repositories/data_sources/cities_persistent_storage.dart';
import 'package:weather_app/repositories/data_sources/cities_rest_api.dart';
import 'package:weather_app/repositories/data_sources/weather_rest_api.dart';

/// --- Abstractions of the repositories ---

abstract class CitiesRepository {
  Future<List<City>> getCities(String text);
  Future<LatLong> getLatLong(String localidade);
  List<City> getSavedCities();
  void saveCity(City city);
  void deleteCity(City city);
}

abstract class WeatherRepository {
  Future<Weather> getWeatherInfo(LatLong latLong);
}

///--- Implementation of the repositories ---

class CitiesRepositoryImpl implements CitiesRepository {
  final CitiesRestApi _data;
  final CitiesPersistentStorage _storage;

  CitiesRepositoryImpl(this._data, this._storage);

  @override
  Future<List<City>> getCities(String text) async {
    return await _data.getCitiesList(text);
  }

  @override
  List<City> getSavedCities() {
    return _storage.getCities();
  }

  @override
  void saveCity(City city) {
    _storage.addCity(city);
  }

  @override
  void deleteCity(City city) {
    _storage.deleteCity(city);
  }

  @override
  Future<LatLong> getLatLong(String localidade) {
    return _data.getLatLong(localidade);
  }
}

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRestApi _data;

  WeatherRepositoryImpl(this._data);

  @override
  Future<Weather> getWeatherInfo(LatLong latLong) async {
    return await _data.getWeatherInfo(latLong);
  }
}
