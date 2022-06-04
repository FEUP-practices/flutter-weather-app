import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/app/config/context/app_state.dart';
import 'package:weather_app/app/config/global_variables.dart';
import 'package:weather_app/core/ports.dart';
import 'package:weather_app/core/usecases/cities_use_case.dart';
import 'package:weather_app/core/usecases/weather_use_case.dart';
import 'package:weather_app/infraestructure/ports_impl.dart';
import 'package:weather_app/repositories/data_sources/cities_persistent_storage.dart';
import 'package:weather_app/repositories/data_sources/cities_rest_api.dart';
import 'package:weather_app/repositories/data_sources/weather_rest_api.dart';
import 'package:weather_app/repositories/repositories.dart';
import 'package:http/http.dart' as http;

import 'context/app_reducer.dart';

/// Register all the beans here
Future<void> setUpBeans() async {
  var getIt = GetIt.I;
  CitiesRepository citiesRepository = CitiesRepositoryImpl(
      CitiesRestApi(http.Client()),
      CitiesPersistentStorage(await SharedPreferences.getInstance()));
  CitiesService citiesService = CitiesServiceImpl(citiesRepository);
  CitiesUseCase citiesUseCase = CitiesUseCaseImpl(citiesService);
  getIt.registerLazySingleton<CitiesUseCase>(() => citiesUseCase);

  WeatherRepository weatherRepository =
      WeatherRepositoryImpl(WeatherRestApi(http.Client()));
  WeatherService weatherService = WeatherServiceImpl(weatherRepository);
  WeatherUseCase weatherUseCase = WeatherUseCaseImpl(weatherService);
  getIt.registerLazySingleton<WeatherUseCase>(() => weatherUseCase);
}

Future<Store<AppState>> setUpStore() async {
  final cities = await GetIt.I.get<CitiesUseCase>().getSavedCities();
  return Store<AppState>(appReducer,
      initialState: AppState().copyWith(cities: cities),
      middleware: [thunkMiddleware]);
}

setUpEnv() async {
  await dotenv.load(fileName: '.env');
  WEATHER_API_KEY = dotenv.env['WEATHER_API_KEY']!;
  PLACES_API_KEY = dotenv.env['PLACES_API_KEY']!;
}
