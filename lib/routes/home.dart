import "package:flutter/material.dart";
import "package:mozc_flutter_bootcamp_23_showcase/components/error_screen.dart";
import "package:mozc_flutter_bootcamp_23_showcase/components/metrics.dart";
import "package:mozc_flutter_bootcamp_23_showcase/components/no_preferred_city_screen.dart";
import "package:mozc_flutter_bootcamp_23_showcase/components/weather_bar.dart";
import "package:mozc_flutter_bootcamp_23_showcase/models/city.dart";
import "package:mozc_flutter_bootcamp_23_showcase/models/weather.dart";
import "package:mozc_flutter_bootcamp_23_showcase/utils/api.dart";
import "package:mozc_flutter_bootcamp_23_showcase/utils/hive.dart";

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  City? get preferredCity => getPreferredCity();

  Future<CurrentWeatherData>? weatherFuture;

  @override
  void initState() {
    super.initState();
    setWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    final city = preferredCity;
    if (city == null) {
      return NoPreferredCityScreen(onCityAdded: setWeatherData);
    }

    return FutureBuilder(
      future: weatherFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.connectionState == ConnectionState.none) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: ErrorScreen(error: snapshot.error!));
        }

        final data = snapshot.requireData;

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(32, 32, 32, 32),
            child: OrientationBuilder(
              builder: (context, orientation) {
                double imageHeight =
                    orientation == Orientation.portrait ? 256.0 : 0.0;
                double imageHeight2 =
                    orientation == Orientation.portrait ? 0.0 : 100.0;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    WeatherBar(
                      date: DateTime.now(),
                      temperature: data.temperature,
                      location: "${city.name},\n${city.country}",
                      status: WeatherStatus.rain,
                      image: data.weather.iconId,
                      height: imageHeight2!,
                    ),
                    Center(
                      child: Image(
                        height: imageHeight,
                        width: 256,
                        fit: BoxFit.fitWidth,
                        filterQuality: FilterQuality.high,
                        image: AssetImage(
                            "assets/icons/${data.weather.iconId}.png"),
                      ),
                    ),
                    MetricsBar(
                      humidity: data.humidity,
                      wind: data.windSpeed,
                      pressure: data.pressure,
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  void setWeatherData() {
    final city = preferredCity;
    if (city == null) return;

    setState(() {
      weatherFuture = getCurrentWeather(city);
    });
  }
}
