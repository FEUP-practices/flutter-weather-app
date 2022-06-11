import 'package:weather_app/app/config/context/app_actions.dart';
import 'package:weather_app/app/config/context/app_state.dart';

AppState appReducer(AppState state, dynamic action) {
  if (action is SetCities) return state.CopyWith(cities: action.cities);
  return state;
}
