import 'dart:convert';

import 'package:weather_app/core/domain.dart';

List<City> fromJsonListCity(String json) {
  Iterable list = jsonDecode(json)["predictions"];
  return list.map((patientResp) => City.fromJson(patientResp)).toList();
}
