import "package:flutter/material.dart";
import "package:flutter_dotenv/flutter_dotenv.dart";
import "package:hive_flutter/adapters.dart";
import "package:mozc_flutter_bootcamp_23_showcase/app.dart";
import "package:mozc_flutter_bootcamp_23_showcase/models/city.dart";

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CityAdapter());
  await Future.wait([
    Hive.openBox<City>("cities"),
    Hive.openBox("preferences"),
  ]);
  await dotenv.load(fileName: "assets/.env");
  runApp(const App());
}
