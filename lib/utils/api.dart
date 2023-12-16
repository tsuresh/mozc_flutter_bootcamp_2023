import "dart:convert";

import "package:flutter_dotenv/flutter_dotenv.dart";
import "package:http/http.dart" as http;
import "package:mozc_flutter_bootcamp_23_showcase/models/city.dart";
import "package:mozc_flutter_bootcamp_23_showcase/models/weather.dart";

const apiUrl = "api.openweathermap.org";
var apiKey = dotenv.env["MOZC_OPEN_WEATHER_API_KEY"] ?? "";

T handleDecode<T>(int statusCode, String body) {
  final data = json.decode(body);
  if (statusCode >= 300) throw StateError(data["message"] as String);

  return data as T;
}

Future<List<City>> searchCities(String query) async {
  final url = Uri.https(apiUrl, "/geo/1.0/direct", {"q": query, "apiKey": apiKey});
  final res = await http.get(url);
  final List<dynamic> data = handleDecode(res.statusCode, res.body);

  return data.map((e) => City.fromMap(e as Map<String, dynamic>)).toList();
}

Future<CurrentWeatherData> getCurrentWeather(City city) async {
  final url = Uri.https(apiUrl, "/data/2.5/weather", {
    "lat": city.latitude.toString(),
    "lon": city.longitude.toString(),
    "appid": apiKey,
  });

  final res = await http.get(url);
  final Map<String, dynamic> data = handleDecode(res.statusCode, res.body);

  return CurrentWeatherData.fromMap(data);
}

Future<List<ForecastWeatherData>> get5DayForecast(City city) async {
  final url = Uri.https(apiUrl, "/data/2.5/forecast", {
    "lat": city.latitude.toString(),
    "lon": city.longitude.toString(),
    "appid": apiKey,
  });

  final res = await http.get(url);
  final Map<String, dynamic> data = handleDecode(res.statusCode, res.body);

  return (data["list"] as List<dynamic>)
      .map((e) => ForecastWeatherData.fromMap(e as Map<String, dynamic>))
      .toList();
}
