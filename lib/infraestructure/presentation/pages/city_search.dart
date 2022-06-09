import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:weather_app/app/config/style.dart';
import 'package:weather_app/core/domain.dart';
import 'package:weather_app/core/usecases/cities_use_case.dart';
import 'package:weather_app/infraestructure/presentation/components/horizontal_padding.dart';
import 'package:weather_app/infraestructure/presentation/sections/modal_add_city.dart';

class CitySearch extends StatefulWidget {
  const CitySearch({Key? key}) : super(key: key);

  @override
  State<CitySearch> createState() => _CitySearchState();
}

class _CitySearchState extends State<CitySearch> {
  TextEditingController? _inputController;
  bool canCallPlacesAPI = true;
  bool wantToSearch = false;
  Timer? timer;
  List<City> _citiesList = [];

  @override
  void initState() {
    super.initState();
    _inputController = TextEditingController();
  }

  @override
  void dispose() {
    _inputController?.dispose();
    timer?.cancel();
    super.dispose();
  }

  void onTextChanged(String text) {
    wantToSearch = true;
    fetchCities(text);
  }

  void fetchCities(String text) {
    if (!canCallPlacesAPI) return;
    canCallPlacesAPI = false;
    GetIt.I.get<CitiesUseCase>().getCities(text).then((list) => setState(() {
          _citiesList = [...list];
        }));
    timer = Timer(
        const Duration(milliseconds: 2000),
        (() => {
              canCallPlacesAPI = true,
              if (wantToSearch)
                {wantToSearch = false, fetchCities(_inputController!.text)}
            }));
  }

  void onTapCity(String description) {
    showCupertinoModalBottomSheet(
        duration: const Duration(milliseconds: 300),
        context: context,
        builder: (_) => ModalAddCity(City(description: description)));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            body: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/search-wp.png"),
                        fit: BoxFit.cover)),
                child: SafeArea(
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconButton(
                              icon: const Icon(
                                CupertinoIcons.left_chevron,
                                size: 35,
                                color: Color.fromARGB(255, 178, 178, 178),
                              ),
                              onPressed: () => Navigator.pop(context),
                            ),
                            const HorizontalPadding(),
                            TextField(
                                onChanged: onTextChanged,
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 178, 178, 178)),
                                controller: _inputController,
                                decoration: inputStyle(_inputController)),
                            const HorizontalPadding(),
                            Expanded(
                                child: ListView.builder(
                                    itemCount: _citiesList.length,
                                    itemBuilder: (_, index) {
                                      return ListTile(
                                        onTap: () => onTapCity(
                                            _citiesList[index].description),
                                        title: p(_citiesList[index].description,
                                            color: Colors.white),
                                      );
                                    })),
                          ],
                        ))))));
  }
}
