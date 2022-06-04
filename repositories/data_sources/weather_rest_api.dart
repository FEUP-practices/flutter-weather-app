import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/app/config/global_variables.dart';
import 'package:weather_app/core/domain.dart';
import 'package:weather_app/core/exceptions.dart';

class WeatherRestApi {
  final http.Client _httpClient;

  WeatherRestApi(this._httpClient);

  Future<Weather> getWeatherInfo(LatLong ll) async {
    var url = Uri.parse(
        "${WEATHER_API_URL}onecall?lat=${ll.latitude}&lon=${ll.longitude}&appid=$WEATHER_API_KEY&units=metric&exclude=minutely,alerts&lang=en");
    var res = await _httpClient.get(url);
    if (res.statusCode != 200 ||
        jsonDecode(res.body)["error_message"] != null) {
      throw WeatherInfoException;
    }
    print(jsonDecode(res.body));
    return Weather.fromJson(jsonDecode(res.body));
  }
}
