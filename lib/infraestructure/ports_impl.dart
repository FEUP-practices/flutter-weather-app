import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const WEEK_DAYS = [
  'Mon.',
  'Tue.  ',
  'Wed.',
  'Thu. ',
  'Fri.    ',
  'Sat.  ',
  'Sun. ',
];

String getWallpaper(String code) {
  switch (code) {
    case 'Clear':
      return 'assets/images/clear-day.jpg';
    case 'Rain':
    case 'Drizzle':
      return 'assets/images/rain.jpg';
    case 'Snow':
      return 'assets/images/snow.jpg';
    case 'Wind':
      return 'assets/images/wind.jpg';
    case 'Fog':
    case 'Mist':
    case 'Haze':
      return 'assets/images/fog.jpg';
    case 'Thunderstorm':
      return 'assets/images/thunderstorm.jpg';
    case 'Clouds':
      return 'assets/images/cloudy.jpg';
    default:
      return 'assets/images/clear-day.jpg';
  }
}

List<String> getWeekDays(int numDays) {
  List<String> days = [];
  for (int i = 0; i < numDays; i++) {
    days.add(WEEK_DAYS[DateTime.now().add(Duration(days: i)).weekday - 1]);
  }
  return days;
}
