import 'package:weather_app/core/domain.dart';

abstract class CitiesService {
  Future<List<City>> getCities(String text);
  Future<LatLong> getLatLong(String localidade);
  List<City> getSavedCities();
  void saveCity(City city);
  void deleteCity(City city);
  void updateCity(City city);
}

abstract class WeatherService {
  Future<Weather> getWeatherInfo(LatLong latLong);
}
