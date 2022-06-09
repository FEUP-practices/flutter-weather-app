import 'dart:ui';

import 'package:animated_widgets/widgets/translation_animated.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/app/config/style.dart';
import 'package:weather_app/core/domain.dart';
import 'package:weather_app/infraestructure/presentation/components/card_info.dart';
import 'package:weather_app/infraestructure/presentation/components/horizontal_divider.dart';
import 'package:weather_app/infraestructure/presentation/components/horizontal_padding.dart';
import 'package:weather_app/infraestructure/presentation/sections/day_forecast_card.dart';
import 'package:weather_app/infraestructure/presentation/sections/footer.dart';
import 'package:weather_app/infraestructure/presentation/sections/week_forecast_card.dart';

class WeatherTab extends StatefulWidget {
  final City city;

  const WeatherTab({Key? key, required this.city}) : super(key: key);

  @override
  State<WeatherTab> createState() => _WeatherTabState();
}

class _WeatherTabState extends State<WeatherTab> {
  ScrollController? _controller;
  bool _silverCollapsed = false;
  String title = "--";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _controller = ScrollController();
      _controller!.addListener(() {
        if (_controller!.offset > 168) {
          setState(() {
            _silverCollapsed = true;
            title = "${widget.city.description}\n22° Sunny";
          });
        } else {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(alignment: Alignment.topCenter, children: [
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
                          child: h3(title, color: Colors.white))))
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
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              h1(" 22°", color: Colors.white),
                              h2("Sunny", color: Colors.white),
                            ])),
                  ),
                ),
                SliverList(
                    delegate: SliverChildListDelegate([
                  Container(
                      margin: mh20,
                      child: Column(children: [
                        CardInfo(child: DayForecastCard()),
                        const HorizontalPadding(),
                        CardInfo(child: WeekForecastCard()),
                        const HorizontalPadding(),
                        CardInfo(
                          child: Footer(widget.city.description),
                        )
                      ]))
                ])),
              ],
            ),
          )
        ]));
  }
}
