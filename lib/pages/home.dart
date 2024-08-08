import 'dart:convert';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
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
  var _time;
  late String departure;
  late String arrival;

  List<dynamic> _items = [];
  Map<String, dynamic> _items_times = {};

  var jsonResponse_1;
  var jsonResponse_2;

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
    // Charger le fichier JSON des villes de France
    String jsonString_1 =
        await rootBundle.loadString('assets/files/villes_france.json');

    // Charger le fichier JSON du temps entre les villes
    String jsonString_2 = await rootBundle.loadString('assets/files/13.json');

    // Décoder le JSON 1
    jsonResponse_1 = json.decode(jsonString_1);
    setState(() {
      _items = jsonResponse_1;
    });

    // Décoder le JSON 2
    jsonResponse_2 = json.decode(jsonString_2);
    setState(() {
      _items_times = jsonResponse_2;
    });
  }

  void filterItem(String itemName) {
    List result = [];

    if (itemName.trim().isEmpty) {
      result = jsonResponse_1;
    } else {
      result = jsonResponse_1
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
  findTravelTime(String city1, String city2) {
    // Create the key for the cities in both possible orders
    String key1 = "('$city1', '$city2')";

    // Check if either key exists in the map and return the corresponding time
    if (_items_times.containsKey(key1)) {
      return _items_times[key1];
    } else {
      // Return null if no match is found
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Récupérer la largeur et la hauteur de l'écran
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    final bool isKeyboardVisible =
        KeyboardVisibilityProvider.isKeyboardVisible(context);

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

                  _time = findTravelTime(
                      departureController.text, arrivalController.text);
                  if (_time != null) {
                    departure = departureController.text;
                    arrival = arrivalController.text;
                    setState(() {
                      _screen = 2;
                    });
                  } else {
                    setState(() {
                      _screen = 3;
                    });
                  }
                } else {
                  setState(() {
                    _screen = 0;
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
          (isKeyboardVisible == true) || (_screen == 0)
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
              : (_screen == 1)
                  ? const Expanded(
                      child: Center(
                          child: Padding(
                              padding: EdgeInsets.all(defaultPadding),
                              child: CircularProgressIndicator())))
                  : (_screen == 2)
                      ? SizedBox(
                          width: screenWidth * 0.94,
                          height: screenHeight * 0.14,
                          child: Card(
                            color: const Color.fromARGB(255, 222, 224, 207),
                            child: Padding(
                              padding: const EdgeInsets.all(defaultPadding),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        departure,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Text(
                                        '->',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        arrival,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    'Temps du Trajet: $_time min',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : const Expanded(
                          child: Center(
                              child:
                                  Text("Aucune Données sur le temps de Trajet",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      )))),
        ],
      ),
    );
  }
}
