import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/app/config/global_variables.dart';
import 'package:weather_app/core/domain.dart';
import 'package:weather_app/core/exceptions.dart';
import 'package:weather_app/repositories/converters.dart';

class CitiesRestApi {
  final http.Client _httpClient;

  CitiesRestApi(this._httpClient);

  Future<List<City>> getCitiesList(String input) async {
    var url = Uri.parse(
        "${PLACES_API_URL}json?input=$input&types=locality&language=en&components=country:pt&key=$PLACES_API_KEY");
    var res = await _httpClient.get(url);
    if (res.statusCode != 200 ||
        jsonDecode(res.body)["error_message"] != null) {
      throw PlacesException;
    }
    return fromJsonListCity(res.body);
  }

  Future<LatLong> getLatLong(String localidade) async {
    var url = Uri.parse(
        "${GEOCODE_API_URL}json?address=$localidade&key=$PLACES_API_KEY");
    var res = await _httpClient.get(url);
    if (res.statusCode != 200 ||
        jsonDecode(res.body)["error_message"] != null) {
      throw PlacesException;
    }
    return LatLong.fromJson(jsonDecode(res.body));
  }
}
