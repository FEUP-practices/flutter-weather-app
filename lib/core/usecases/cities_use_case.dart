import 'package:weather_app/core/domain.dart';
import 'package:weather_app/core/ports.dart';

abstract class CitiesUseCase {
  Future<List<City>> getCities(String text);
  Future<LatLong> getLatLong(String localidade);
  Future<List<City>> getSavedCities();
  void saveCity(City city);
  void deleteCity(City city);
  void updateCity(City city);
}

class CitiesUseCaseImpl implements CitiesUseCase {
  final CitiesService _service;

  CitiesUseCaseImpl(this._service);

  @override
  Future<List<City>> getCities(String text) async {
    return await _service.getCities(text);
  }

  @override
  Future<List<City>> getSavedCities() async {
    return _service.getSavedCities();
  }

  @override
  void saveCity(City city) {
    return _service.saveCity(city);
  }

  @override
  void deleteCity(City city) {
    return _service.deleteCity(city);
  }

  @override
  void updateCity(City city) {
    return _service.updateCity(city);
  }

  @override
  Future<LatLong> getLatLong(String localidade) async {
    return await _service.getLatLong(localidade);
  }
}
