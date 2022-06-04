import 'package:weather_app/core/domain.dart';
import 'package:weather_app/core/ports.dart';
import 'package:weather_app/repositories/repositories.dart';

class CitiesServiceImpl implements CitiesService {
  final CitiesRepository _citiesRepository;

  CitiesServiceImpl(this._citiesRepository);

  @override
  Future<List<City>> getCities(String text) {
    return _citiesRepository.getCities(text);
  }

  @override
  List<City> getSavedCities() {
    return _citiesRepository.getSavedCities();
  }

  @override
  void saveCity(City city) {
    return _citiesRepository.saveCity(city);
  }

  @override
  void deleteCity(City city) {
    return _citiesRepository.deleteCity(city);
  }

  @override
  Future<LatLong> getLatLong(String localidade) {
    return _citiesRepository.getLatLong(localidade);
  }
}

class WeatherServiceImpl implements WeatherService {
  final WeatherRepository _weatherRepository;

  WeatherServiceImpl(this._weatherRepository);

  @override
  Future<Weather> getWeatherInfo(LatLong latLong) {
    return _weatherRepository.getWeatherInfo(latLong);
  }
}
