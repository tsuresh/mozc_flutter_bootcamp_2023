import "package:flutter/material.dart";
import "package:mozc_flutter_bootcamp_23_showcase/components/weather_forecast_card.dart";
import "package:mozc_flutter_bootcamp_23_showcase/models/city.dart";
import "package:mozc_flutter_bootcamp_23_showcase/models/weather.dart";
import "package:mozc_flutter_bootcamp_23_showcase/utils/hive.dart";

class Forecast extends StatefulWidget {
  const Forecast({super.key});

  @override
  State<Forecast> createState() => _ForecastState();
}

class _ForecastState extends State<Forecast> {
  City? get preferredCity => getPreferredCity();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaPadding = MediaQuery.paddingOf(context);
    var padding = EdgeInsets.only(
      left: 8,
      right: 8,
      top: mediaPadding.top,
      bottom: mediaPadding.bottom + 8,
    );

    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      removeBottom: true,
      child: ListView.separated(
        itemCount: 5,
        padding: padding,
        separatorBuilder: (context, index) => const SizedBox(height: 4),
        itemBuilder: (context, i) => WeatherForecastCard(
            data: ForecastWeatherDaySummary(
          timeRange: (DateTime.now(), DateTime.now()),
          chanceOfRainRange: (0.0, 0.0),
          humidityRange: (0, 0),
          windSpeedRange: (0.0, 0.0),
          temperatureRange: (300, 350),
          weather: const WeatherConditionData(
            id: 1,
            status: WeatherStatus.rain,
            iconId: "01d",
          ),
        )),
      ),
    );
  }
}
