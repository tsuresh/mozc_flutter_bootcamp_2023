import "package:flutter/material.dart";
import "package:mozc_flutter_bootcamp_23_showcase/components/city_list_item.dart";
import "package:mozc_flutter_bootcamp_23_showcase/models/weather.dart";
import "package:mozc_flutter_bootcamp_23_showcase/routes/add_city.dart";

class MyCities extends StatefulWidget {
  const MyCities({super.key});

  @override
  State<MyCities> createState() => _MyCitiesState();
}

class _MyCitiesState extends State<MyCities> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      SliverAppBar(
        title: const Text("My Cities"),
        floating: true,
        actions: [IconButton(onPressed: onAddPressed, icon: const Icon(Icons.add_rounded))],
      ),
      SliverList.builder(
        itemCount: 5,
        itemBuilder: (context, i) {
          return CityListItem(
            location: "Colombo, Sri Lanka",
            temperature: 270,
            status: WeatherStatus.rain,
            iconId: "01d",
            cityIdentifier: "Test",
            preferredCityIdentifier: "Test",
            onPress: onListItemPressed,
          );
        },
      )
    ]);
  }

  Future<void> onAddPressed() async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) => const AddCity()));
    if (context.mounted) setState(() => {});
  }

  Future onListItemPressed(String? cityIdentifier) async {}
}
