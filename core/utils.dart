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
