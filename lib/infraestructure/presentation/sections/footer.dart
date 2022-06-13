import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weather_app/app/config/style.dart';
import 'package:weather_app/infraestructure/presentation/components/horizontal_divider.dart';
import 'package:weather_app/infraestructure/presentation/components/horizontal_padding.dart';

class Footer extends StatelessWidget {
  final String _cityName;

  const Footer(this._cityName, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const HorizontalDivider(),
        const HorizontalPadding(),
        p("Weather in: $_cityName", color: Colors.white),
        p("Data obtained of", color: const Color.fromARGB(255, 182, 182, 182)),
        RichText(
            text: TextSpan(
                text: "openweathermap.org",
                style: const TextStyle(
                    color: Color.fromARGB(255, 182, 182, 182), fontSize: 18),
                recognizer: TapGestureRecognizer()
                  // ignore: deprecated_member_use
                  ..onTap = () => launch('https://openweathermap.org/'))),
      ],
    );
  }
}
