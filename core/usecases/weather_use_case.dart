import 'package:weather_app/core/domain.dart';
import 'package:weather_app/core/ports.dart';

abstract class WeatherUseCase {
  Future<Weather> getWeatherInfo(LatLong latLong);
}

class WeatherUseCaseImpl implements WeatherUseCase {
  final WeatherService _service;

  WeatherUseCaseImpl(this._service);

  @override
  Future<Weather> getWeatherInfo(LatLong latLong) async {
    return await _service.getWeatherInfo(latLong);
  }
}
