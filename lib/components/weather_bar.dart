import "package:flutter/material.dart";
import "package:mozc_flutter_bootcamp_23_showcase/models/weather.dart";
import "package:mozc_flutter_bootcamp_23_showcase/utils/date.dart";
import "package:mozc_flutter_bootcamp_23_showcase/utils/units.dart";

class WeatherBar extends StatelessWidget {
  final WeatherStatus status;
  final double temperature;
  final String location;
  final DateTime date;
  final String image;
  final double height;
  const WeatherBar({
    super.key,
    required this.temperature,
    required this.status,
    required this.location,
    required this.date,
    required this.image,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final text = theme.textTheme;
    final color = theme.colorScheme;

    final dateString = getFancyDate(date);

    final placeTextStyle = text.headlineLarge?.copyWith(
      color: color.primary,
      fontWeight: FontWeight.bold,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(location, style: placeTextStyle),
          Row(
            children: <Widget>[
              Image(
                height: height,
                width: height,
                fit: BoxFit.fitWidth,
                filterQuality: FilterQuality.high,
                image: AssetImage("assets/icons/$image.png"),
              ),
              _TempStatus(temperature: temperature, status: status),
            ],
          ),
        ]),
        Text(dateString,
            style: text.labelLarge
                ?.copyWith(color: color.primary.withOpacity(0.5))),
      ],
    );
  }
}

class _TempStatus extends StatelessWidget {
  final double temperature;
  final WeatherStatus status;

  const _TempStatus({required this.temperature, required this.status});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final text = theme.textTheme;
    final colors = theme.colorScheme;

    final temperature = convertKelvinToCelsius(this.temperature);

    final tempTextStyle = text.displayLarge?.copyWith(
      color: colors.primary,
      fontWeight: FontWeight.w900,
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(mainAxisSize: MainAxisSize.min, children: [
          Text(temperature.toStringAsFixed(1), style: tempTextStyle),
          Text(status.asHumanReadable(),
              style: text.titleMedium?.copyWith(color: colors.primary)),
        ]),
        Text("°C", style: text.labelLarge?.copyWith(color: colors.primary)),
      ],
    );
  }
}
