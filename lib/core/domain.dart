import 'dart:convert';

class City {
  String description;
  LatLong latLong;

  City({required this.description, required this.latLong});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
        description: json["description"],
        latLong: json["latLong"] == null
            ? LatLong(latitude: 0, longitude: 0)
            : LatLong(
                latitude: json["latLong"]["lat"],
                longitude: json["latLong"]["lng"]));
  }

  Map<String, dynamic> toJson() {
    return {"description": description, "latLong": latLong.toJson()};
  }
}

class Weather {
  List<DailyForecastItem> dailyForecastItem;
  List<HourlyForecastItem> hourlyForecastItem;
  CurrentWeather currentWeather;

  Weather(
      {required this.dailyForecastItem,
      required this.hourlyForecastItem,
      required this.currentWeather});

  factory Weather.fromJson(Map<String, dynamic> json) {
    final current = json["current"];
    final daily = json["daily"];
    final hourly = json["hourly"];
    return Weather(
        dailyForecastItem:
            (daily as List).map((e) => DailyForecastItem.fromJson(e)).toList(),
        hourlyForecastItem: (hourly as List)
            .map((e) => HourlyForecastItem.fromJson(e))
            .toList(),
        currentWeather: CurrentWeather.fromJson(current));
  }
}

class CurrentWeather {
  DateTime dateTime;
  CurrentWeatherHeader currentWeatherHeader;
  CurrentWeatherCharacteristics currentWeatherCharacteristics;

  CurrentWeather(
      {required this.dateTime,
      required this.currentWeatherHeader,
      required this.currentWeatherCharacteristics});

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
        dateTime: DateTime.fromMillisecondsSinceEpoch(json["dt"] * 1000),
        currentWeatherHeader: CurrentWeatherHeader.fromJson(json),
        currentWeatherCharacteristics:
            CurrentWeatherCharacteristics.fromJson(json));
  }
}

class LatLong {
  num latitude;
  num longitude;

  LatLong({required this.latitude, required this.longitude});

  factory LatLong.fromJson(Map<String, dynamic> json) {
    return LatLong(
      latitude: json["results"][0]["geometry"]["location"]["lat"],
      longitude: json["results"][0]["geometry"]["location"]["lng"],
    );
  }

  Map<String, dynamic> toJson() {
    return {"lat": latitude, "lng": longitude};
  }
}

class DailyForecastItem {
  String weatherIcon;
  Temperature temperature;

  DailyForecastItem({
    required this.weatherIcon,
    required this.temperature,
  });

  factory DailyForecastItem.fromJson(Map<String, dynamic> json) {
    return DailyForecastItem(
      weatherIcon: json["weather"][0]["icon"],
      temperature: Temperature.fromJson(json["temp"]),
    );
  }
}

class Temperature {
  num min;
  num max;
  num temp;

  Temperature({required this.temp, required this.min, required this.max});

  factory Temperature.fromJson(Map<String, dynamic> json) {
    return Temperature(
      temp: json["day"],
      min: json["min"],
      max: json["max"],
    );
  }
}

class HourlyForecastItem {
  DateTime dateTime;
  String weatherIcon;
  num temperature;

  HourlyForecastItem({
    required this.dateTime,
    required this.weatherIcon,
    required this.temperature,
  });

  factory HourlyForecastItem.fromJson(Map<String, dynamic> json) {
    return HourlyForecastItem(
        dateTime: DateTime.fromMillisecondsSinceEpoch(json["dt"] * 1000),
        weatherIcon: json["weather"][0]["icon"],
        temperature: json["temp"]);
  }
}

class CurrentWeatherHeader {
  String main;
  String description;
  int temperature;
  String weatherIcon;

  CurrentWeatherHeader({
    required this.main,
    required this.description,
    required this.temperature,
    required this.weatherIcon,
  });

  factory CurrentWeatherHeader.fromJson(Map<String, dynamic> json) {
    final _weather = json["weather"][0];

    return CurrentWeatherHeader(
      main: _weather["main"],
      description: _weather["description"],
      weatherIcon: _weather["icon"],
      temperature: json["temp"].ceil(),
    );
  }
}

class CurrentWeatherCharacteristics {
  int humidity;
  // double precipitation;
  int uvi;
  int visibility;
  int pressure;

  CurrentWeatherCharacteristics({
    required this.humidity,
    // required this.precipitation,
    required this.uvi,
    required this.visibility,
    required this.pressure,
  });

  factory CurrentWeatherCharacteristics.fromJson(Map<String, dynamic> json) {
    return CurrentWeatherCharacteristics(
      humidity: json["humidity"],
      // precipitation: json["precipitation"],
      uvi: json["uvi"],
      visibility: json["visibility"],
      pressure: json["pressure"],
    );
  }
}
