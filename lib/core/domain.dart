import 'package:animated_widgets/generated/i18n.dart';
import 'package:flutter/material.dart';

class City {
  String description;

  City({required this.description});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      description: json["description"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "description": description,
    };
  }
}

class Weather {
  DateTime dateTime;
  String code;
  String description;
  String icon;
  int humidity;
  double temperature;
  double temperatureMin;
  double temperatureMax;
  double pressure;
  double windSpeed;
  double windDegree;
  double uvIndex;
  double visibility;
  double cloudiness;
  double feelsLike;
  String sunrise;
  String sunset;
  double rain;

  Weather({
    required this.dateTime,
    required this.code,
    required this.description,
    required this.icon,
    required this.humidity,
    required this.temperature,
    required this.temperatureMin,
    required this.temperatureMax,
    required this.pressure,
    required this.windSpeed,
    required this.windDegree,
    required this.uvIndex,
    required this.visibility,
    required this.cloudiness,
    required this.feelsLike,
    required this.sunrise,
    required this.sunset,
    required this.rain,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    final current = json["current"];
    final daily = json["daily"];
    final hourly = json["hourly"];
    return Weather(
      dateTime: DateTime.fromMillisecondsSinceEpoch(current["dt"] * 1000),
      code: current["weather"][0]["main"],
      description: json["description"],
      icon: json["icon"],
      humidity: json["humidity"],
      temperature: json["temperature"],
      temperatureMin: json["temp"]["min"],
      temperatureMax: json["temp"]["max"],
      pressure: json["pressure"],
      windSpeed: json["wind_speed"],
      windDegree: json["wind_degree"],
      uvIndex: json["uv_index"],
      visibility: json["visibility"],
      cloudiness: json["cloudiness"],
      feelsLike: json["feels_like"],
      sunrise: json["sunrise"],
      sunset: json["sunset"],
      rain: json["rain"],
    );
  }
}

// class Current {
//   DateTime dateTime;
//   String code;
//   String description;
//   String icon;
//   int humidity;
//   double temperature;
// }

class LatLong {
  double latitude;
  double longitude;

  LatLong({required this.latitude, required this.longitude});

  factory LatLong.fromJson(Map<String, dynamic> json) {
    return LatLong(
      latitude: json["results"][0]["geometry"]["location"]["lat"],
      longitude: json["results"][0]["geometry"]["location"]["lng"],
    );
  }
}
