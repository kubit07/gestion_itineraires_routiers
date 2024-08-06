import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:france_itineraire/constants.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();

  final departureController = TextEditingController();
  final arrivalController = TextEditingController();

  List<dynamic> _items = [];
  var jsonResponse;

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  @override
  void dispose() {
    super.dispose();
    departureController.dispose();
    arrivalController.dispose();
  }

  Future<void> loadJsonData() async {
    // Charger le fichier JSON
    String jsonString =
        await rootBundle.loadString('assets/files/villes_france.json');
    // Décoder le JSON
    jsonResponse = json.decode(jsonString);
    setState(() {
      _items = jsonResponse;
    });
  }

  void filterItem(String itemName) {
    List result = [];

    if (itemName.trim().isEmpty) {
      result = jsonResponse;
    } else {
      result = jsonResponse
          .where((element) =>
              element.toString().toLowerCase().contains(itemName.toLowerCase()))
          .toList();
    }
    setState(() {
      _items = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Itinéraires",
          style: TextStyle(color: textColorLightTheme),
        ),
      ),
      body: Column(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: defaultPadding,
                      right: defaultPadding,
                      top: defaultPadding),
                  child: TextFormField(
                    controller: departureController,
                    onChanged: (value) => filterItem(value),
                    textInputAction: TextInputAction.search,
                    decoration: const InputDecoration(
                      hintText: "Départ",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Tu dois remplir ce texte";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 2.0),
                Padding(
                  padding: const EdgeInsets.only(
                      left: defaultPadding,
                      right: defaultPadding,
                      top: 8.0,
                      bottom: defaultPadding),
                  child: TextFormField(
                    controller: arrivalController,
                    onChanged: (value) => filterItem(value),
                    textInputAction: TextInputAction.search,
                    decoration: const InputDecoration(
                      hintText: "Destination",
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            height: 4,
            thickness: 4,
            color: secondaryColor5LightTheme,
          ),
          Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: SvgPicture.asset(
                "assets/icons/location.svg",
                height: 16,
              ),
              label: const Text("Use my Current Location"),
              style: ElevatedButton.styleFrom(
                backgroundColor: secondaryColor10LightTheme,
                foregroundColor: textColorLightTheme,
                elevation: 0,
                fixedSize: const Size(double.infinity, 40),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
          ),
          const Divider(
            height: 4,
            thickness: 4,
            color: secondaryColor5LightTheme,
          ),
          /*   LocationListTile(
            press: () {},
            location: "Banasree, Dhaka, Bangladesh",
          ), 
          */
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: SizedBox(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _items.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          print("ok");
                          setState(() {});
                        },
                        child: ListTile(
                          title: Text(_items[index]),
                        ),
                      );
                    }),
              ),
            ),
          )
        ],
      ),
    );
  }
}
