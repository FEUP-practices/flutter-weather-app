import 'package:animated_widgets/widgets/translation_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:get_it/get_it.dart';
import 'package:redux/redux.dart';
import 'package:weather_app/app/config/context/app_actions.dart';
import 'package:weather_app/app/config/context/app_state.dart';
import 'package:weather_app/app/config/style.dart';
import 'package:weather_app/core/domain.dart';
import 'package:weather_app/core/usecases/weather_use_case.dart';
import 'package:weather_app/core/utils.dart';
import 'package:weather_app/infraestructure/presentation/components/card_info.dart';
import 'package:weather_app/infraestructure/presentation/components/horizontal_padding.dart';
import 'package:weather_app/infraestructure/presentation/sections/day_forecast_card.dart';
import 'package:weather_app/infraestructure/presentation/sections/footer.dart';
import 'package:weather_app/infraestructure/presentation/sections/weather_characteristics.dart';
import 'package:weather_app/infraestructure/presentation/sections/week_forecast_card.dart';

class WeatherTab extends StatefulWidget {
  final City city;

  const WeatherTab({Key? key, required this.city}) : super(key: key);

  @override
  State<WeatherTab> createState() => _WeatherTabState();
}

class _WeatherTabState extends State<WeatherTab>
    with AutomaticKeepAliveClientMixin {
  ScrollController? _controller;
  bool _silverCollapsed = false;
  String title = "--";

  Future<Weather>? _weather;

  @override
  void initState() {
    super.initState();

    _weather = _fetchWeather();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _controller = ScrollController();
      _controller?.addListener(() {
        if (_controller!.offset > 168) {
          setState(() {
            _silverCollapsed = true;
          });
        } else if (_silverCollapsed) {
          setState(() {
            _silverCollapsed = false;
            title = widget.city.description;
          });
        }
      });
    });
    setState(() {
      title = widget.city.description;
    });
  }

  Future<Weather> _fetchWeather() async {
    return await GetIt.I
        .get<WeatherUseCase>()
        .getWeatherInfo(widget.city.latLong);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StoreBuilder<AppState>(builder: (context, store) {
      return Scaffold(
          backgroundColor: Colors.transparent,
          body: FutureBuilder<Weather>(
              future: _weather,
              builder: (
                BuildContext context,
                AsyncSnapshot<Weather> snapshot,
              ) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Theme.of(context).colorScheme.primary,
                  ));
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data == null) {
                    return Center(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: h3(
                        "Error loading the weather data",
                      ),
                    ));
                  }
                  widget.city.background =
                      snapshot.data!.currentWeather.currentWeatherHeader.main;
                  store.dispatch(doUpdateCity(widget.city));
                  return Stack(alignment: Alignment.topCenter, children: [
                    _silverCollapsed
                        ? Positioned(
                            top: 5,
                            child: SafeArea(
                                child: TranslationAnimatedWidget.tween(
                                    enabled: _silverCollapsed,
                                    duration: const Duration(milliseconds: 200),
                                    translationDisabled: const Offset(0, 20),
                                    translationEnabled: const Offset(0, 0),
                                    curve: Curves.easeInOut,
                                    child: h3(
                                        "${widget.city.description}\n${snapshot.data!.currentWeather.currentWeatherHeader.temperature} ° - ${snapshot.data!.currentWeather.currentWeatherHeader.main}",
                                        color: Colors.white))))
                        : Container(),
                    Container(
                      padding: _silverCollapsed
                          ? EdgeInsets.only(
                              top: MediaQuery.of(context).viewPadding.top + 80)
                          : EdgeInsets.zero,
                      child: CustomScrollView(
                        controller: _controller,
                        slivers: <Widget>[
                          SliverAppBar(
                            pinned: true,
                            elevation: 0,
                            backgroundColor: Colors.transparent,
                            expandedHeight: 250.0,
                            collapsedHeight: 90,
                            flexibleSpace: FlexibleSpaceBar(
                              title: _silverCollapsed
                                  ? Container()
                                  : h3(title, color: Colors.white),
                              expandedTitleScale: 1.2,
                              background: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        h1("${snapshot.data!.currentWeather.currentWeatherHeader.temperature}°",
                                            color: Colors.white),
                                        h2(
                                            snapshot.data!.currentWeather
                                                .currentWeatherHeader.main,
                                            color: Colors.white),
                                      ])),
                            ),
                          ),
                          SliverList(
                              delegate: SliverChildListDelegate([
                            Container(
                                margin: mh20,
                                child: Column(children: [
                                  CardInfo(
                                      child: DayForecastCard(
                                          snapshot.data!.hourlyForecastItem)),
                                  const HorizontalPadding(),
                                  CardInfo(
                                      child: WeekForecastCard(
                                          snapshot.data!.dailyForecastItem)),
                                  const HorizontalPadding(),
                                  CardInfo(
                                      child: WeatherCharacteristics(snapshot
                                          .data!
                                          .currentWeather
                                          .currentWeatherCharacteristics)),
                                  const HorizontalPadding(),
                                  CardInfo(
                                    child: Footer(widget.city.description),
                                  ),
                                ]))
                          ])),
                        ],
                      ),
                    )
                  ]);
                }
                return Container();
              }));
    });
  }

  @override
  bool get wantKeepAlive => true;
}
