import "package:flutter/material.dart";
import "package:mozc_flutter_bootcamp_23_showcase/app.dart";

void main() async {
  // await Hive.initFlutter();
  // Hive.registerAdapter(CityAdapter());
  // await Future.wait([
  //   Hive.openBox<City>("cities"),
  //   Hive.openBox("preferences"),
  // ]);

  runApp(const App());
}
