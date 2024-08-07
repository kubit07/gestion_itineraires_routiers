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
  final departureFocusNode = FocusNode();
  final arrivalFocusNode = FocusNode();

  int _screen = 0;

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
    departureFocusNode.dispose();
    arrivalFocusNode.dispose();
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
          .where((element) => element
              .toString()
              .trim()
              .toLowerCase()
              .contains(itemName.trim().toLowerCase()))
          .toList();
    }
    setState(() {
      _items = result;
    });
  }


    // Function to find travel time between two cities
  int? findTravelTime(String city1, String city2, String jsonString) {
    // Decode the JSON string into a Map
    Map<String, dynamic> data = json.decode(jsonString);

    // Create the key for the cities in both possible orders
    String key1 = "('$city1', '$city2')";
    String key2 = "('$city2', '$city1')";

    // Check if either key exists in the map and return the corresponding time
    if (data.containsKey(key1)) {
      return data[key1];
    } else if (data.containsKey(key2)) {
      return data[key2];
    } else {
      // Return null if no match is found
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "France Itinéraires",
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
                    focusNode: departureFocusNode,
                    onChanged: (value) => filterItem(value),
                    textInputAction: TextInputAction.search,
                    decoration: const InputDecoration(
                      hintText: "Départ",
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.trim().isEmpty) {
                        return "vous devez choisir une ville de départ";
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
                    focusNode: arrivalFocusNode,
                    onChanged: (value) => filterItem(value),
                    textInputAction: TextInputAction.search,
                    decoration: const InputDecoration(
                      hintText: "Destination",
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.trim().isEmpty) {
                        return "vous devez choisir une ville d'arrivée";
                      }
                      return null;
                    },
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
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  FocusScope.of(context).unfocus();
                  setState(() {
                    _screen = 1;
                  });
                }
              },
              icon: SvgPicture.asset(
                "assets/icons/location.svg",
                height: 16,
              ),
              label: const Text("Valider"),
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
          _screen == 0
              ? Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: SizedBox(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: _items.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                if (departureFocusNode.hasFocus) {
                                  departureController.text = _items[index];
                                } else if (arrivalFocusNode.hasFocus) {
                                  arrivalController.text = _items[index];
                                }
                              },
                              child: ListTile(
                                title: Text(_items[index]),
                              ),
                            );
                          }),
                    ),
                  ),
                )
              : const Expanded(
                  child: Center(
                    child: Padding(
                        padding: EdgeInsets.all(defaultPadding),
                        child: CircularProgressIndicator()),
                  ),
                )
        ],
      ),
    );
  }
}
