import "package:flutter/material.dart";
import "package:mozc_flutter_bootcamp_23_showcase/components/metrics.dart";
import "package:mozc_flutter_bootcamp_23_showcase/components/weather_bar.dart";
import "package:mozc_flutter_bootcamp_23_showcase/models/weather.dart";

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //City? get preferredCity => getPreferredCity();

  //Future<CurrentWeatherData>? weatherFuture;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(32, 32, 32, 56),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            WeatherBar(
              date: DateTime.now(),
              temperature: 300,
              location: "Colombo,\nSri Lanka",
              status: WeatherStatus.rain,
            ),
            const Center(
              child: Image(
                height: 256,
                width: 256,
                fit: BoxFit.fitWidth,
                filterQuality: FilterQuality.high,
                image: AssetImage("assets/icons/01d.png"),
              ),
            ),
            const MetricsBar(humidity: 5, wind: 10, pressure: 15)
          ],
        ),
      ),
    );
  }
}
