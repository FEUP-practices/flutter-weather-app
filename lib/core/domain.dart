import 'package:animated_widgets/generated/i18n.dart';
import 'package:flutter/material.dart';

class City {
  String description;
  LatLong latLong;

  City({required this.description, required this.latLong});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
        description: json["description"],
        latLong: LatLong(latitude: 0, longitude: 0));
  }

  Map<String, dynamic> toJson() {
    return {
      "description": description,
    };
  }
}

class Weather {
  Weather();

  factory Weather.fromJson(Map<String, dynamic> json) {
    final current = json["current"];
    final daily = json["daily"];
    final hourly = json["hourly"];
    return Weather(
        //current_temp = current["temp"],
        );
  }
}

// class CurrentWeather {
//   DateTime dateTime;
//   int humidity;
//   double precipitation;

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

class WeekForecastItem {
  String day;
  String weatherIcon;
  Temperature temperature;

  WeekForecastItem({
    required this.day,
    required this.weatherIcon,
    required this.temperature,
  });

  factory WeekForecastItem.fromJson(Map<String, dynamic> json) {
    return WeekForecastItem(
      day: json["day"],
      weatherIcon: json["weather"]["icon"],
      temperature: Temperature.fromJson(json["temp"]),
    );
  }
}

class Temperature {
  double min;
  double max;
  double temp;

  Temperature({required this.temp, required this.min, required this.max});

  factory Temperature.fromJson(Map<String, dynamic> json) {
    return Temperature(
      temp: json["temp"],
      min: json["min"],
      max: json["max"],
    );
  }
}

class HourlyForecastItem {
  DateTime dateTime;
  String weatherIcon;
  Temperature temperature;

  HourlyForecastItem({
    required this.dateTime,
    required this.weatherIcon,
    required this.temperature,
  });

  factory HourlyForecastItem.fromJson(Map<String, dynamic> json) {
    return HourlyForecastItem(
        dateTime: DateTime.fromMillisecondsSinceEpoch(json["dt"] * 1000),
        weatherIcon: json["weather"]["icon"],
        temperature: json["temp"]);
  }
}
