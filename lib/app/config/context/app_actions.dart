import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:weather_app/app/config/context/app_state.dart';
import 'package:weather_app/core/domain.dart';
import 'package:weather_app/core/usecases/cities_use_case.dart';

class SetCities {
  final List<City> cities;
  static const MAX_CITIES = 5;
  SetCities(this.cities);
}

class SetBackground {
  final String background;
  SetBackground(this.background);
}

ThunkAction<AppState> doGetCities() {
  return (Store<AppState> store) async {
    List<City> citiesList = await GetIt.I.get<CitiesUseCase>().getSavedCities();
    store.dispatch(SetCities(citiesList));
  };
}

ThunkAction<AppState> doRemoveCity(City city) {
  return (Store<AppState> store) async {
    GetIt.I.get<CitiesUseCase>().deleteCity(city);
    List<City> citiesList = await GetIt.I.get<CitiesUseCase>().getSavedCities();
    store.dispatch(SetCities(citiesList));
  };
}

ThunkAction<AppState> doAddCity(City city) {
  return (Store<AppState> store) async {
    List<City> citiesList = await GetIt.I.get<CitiesUseCase>().getSavedCities();
    if (citiesList.length >= SetCities.MAX_CITIES) {
      Fluttertoast.showToast(
          timeInSecForIosWeb: 3,
          msg: "You can't add more than ${SetCities.MAX_CITIES} cities",
          toastLength: Toast.LENGTH_SHORT);
      return;
    }
    GetIt.I.get<CitiesUseCase>().saveCity(city);
    citiesList = await GetIt.I.get<CitiesUseCase>().getSavedCities();
    store.dispatch(SetCities(citiesList));
  };
}

ThunkAction<AppState> doUpdateCity(City city) {
  return (Store<AppState> store) async {
    GetIt.I.get<CitiesUseCase>().updateCity(city);
    List<City> citiesList = await GetIt.I.get<CitiesUseCase>().getSavedCities();
    store.dispatch(SetCities(citiesList));
  };
}
