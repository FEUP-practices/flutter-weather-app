import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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

class LifecycleEventHandler extends WidgetsBindingObserver {
  final AsyncCallback resumeCallBack;
  final AsyncCallback? suspendingCallBack;

  LifecycleEventHandler({
    required this.resumeCallBack,
    this.suspendingCallBack,
  });

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        await resumeCallBack();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        if (suspendingCallBack != null) {
          await suspendingCallBack!();
        }
        break;
    }
  }
}
