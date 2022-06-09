get PlacesException =>
    Exception(CustomException("error trying to get available cities"));
get CityNotFoundException => Exception(CustomException("city not registered"));
get WeatherInfoException =>
    Exception(CustomException("error recovering weather information"));

class CustomException {
  String message;
  CustomException(this.message);
}
