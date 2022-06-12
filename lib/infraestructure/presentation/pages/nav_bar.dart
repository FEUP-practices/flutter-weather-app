import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:get_it/get_it.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:redux/redux.dart';
import 'package:weather_app/app/config/context/app_actions.dart';
import 'package:weather_app/app/config/context/app_state.dart';
import 'package:weather_app/core/domain.dart';
import 'package:weather_app/core/usecases/weather_use_case.dart';
import 'package:weather_app/core/utils.dart';
import 'package:weather_app/infraestructure/presentation/components/nav_bar_dot.dart';
import 'package:weather_app/infraestructure/presentation/pages/city_search.dart';
import 'package:weather_app/infraestructure/presentation/pages/empty_nav_bar.dart';
import 'package:weather_app/infraestructure/presentation/pages/weather_tab.dart';
import 'package:weather_app/infraestructure/presentation/sections/modal_city_options.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  //Índice inicial del NavigationBar
  int _currentIndex = 0;
  PageController? _tabController;
  final GlobalKey _key = GlobalKey();
  double _size = 150;

  @override
  void initState() {
    super.initState();
    _tabController = PageController();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _getTabBarSize();
    });
  }

  _getTabBarSize() {
    setState(() {
      _size = (_key.currentState?.context.size?.height ?? 90) + 10;
    });
  }

  List<Widget> _pageTabs(List<City> cities) {
    if (cities.isEmpty) {
      return [const EmptyNavBar()];
    }
    return cities
        .map((city) => WeatherTab(
              city: city,
            ))
        .toList();
  }

  List<BottomNavigationBarItem> buildItems(List<City> cities) {
    return List.generate(
        cities.length == 1 ? 2 : cities.length,
        (index) => BottomNavigationBarItem(
              icon: const NavBarDot(color: Color.fromARGB(255, 90, 90, 90)),
              activeIcon:
                  NavBarDot(color: Theme.of(context).colorScheme.primary),
              label: '',
            ));
  }

  Widget buildPageView(List<City> cities) {
    return PageView(
        controller: _tabController,
        children: _pageTabs(cities),
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(builder: (context, store) {
      final _citiesList = store.state.cities ?? [];
      return Scaffold(
          extendBody: true,
          body: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(getWallpaper(_citiesList.isEmpty
                          ? 'Clear'
                          : _citiesList[_currentIndex].background)),
                      fit: BoxFit.cover)),
              child: Container(
                  padding: EdgeInsets.only(bottom: _size),
                  child: buildPageView(_citiesList))),
          bottomNavigationBar: Stack(children: [
            Positioned(
                right: 20,
                bottom: _citiesList.isEmpty ? 15 : null,
                child: IconButton(
                    icon: const Icon(
                      CupertinoIcons.search,
                      size: 30,
                      color: Color.fromARGB(255, 41, 41, 41),
                    ),
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const CitySearch())))),
            _citiesList.isEmpty
                ? Container()
                : Positioned(
                    left: 10,
                    bottom: null,
                    child: IconButton(
                        icon: const Icon(
                          Icons.menu,
                          size: 30,
                          color: Color.fromARGB(255, 41, 41, 41),
                        ),
                        onPressed: () => showCupertinoModalBottomSheet(
                            duration: const Duration(milliseconds: 300),
                            context: context,
                            builder: (context) => Padding(
                                  padding: const EdgeInsets.only(bottom: 15.0),
                                  child: ModalCityOptions(
                                      _citiesList[_currentIndex]),
                                )))),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 125),
                child: _citiesList.isEmpty
                    ? Container()
                    : BottomNavigationBar(
                        key: _key,
                        currentIndex: _currentIndex,
                        type: BottomNavigationBarType.fixed,
                        items: buildItems(_citiesList),
                        onTap: (index) => setState(() {
                          _tabController?.animateToPage(index,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn);
                        }),
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                      )),
          ]));
    });
  }
}
