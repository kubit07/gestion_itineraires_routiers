import 'dart:convert';
import 'dart:async';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:france_itineraire/core/constants.dart';
import 'package:france_itineraire/models/TravelTime.dart';
import 'package:france_itineraire/services/remote_service.dart';

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

  late String departure;
  late String arrival;
  late Future<TravelTime> travelTimeFuture;
  int _screen = 0; // permet de switcher les écrans
  List<dynamic> _items = [];

  var jsonResponse_1;

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
  /// Méthode asynchrone pour charger et décoder un fichier JSON contenant 
  /// les villes de France.
  ///
  /// - `rootBundle.loadString('assets/files/villes_france.json')` charge le contenu 
  ///   du fichier JSON situé dans les assets de l'application.
  /// - Le contenu JSON est ensuite décodé en un objet Dart à l'aide de `json.decode`.
  /// - Le résultat est stocké dans `_items` via `setState` pour mettre à jour 
  ///   l'interface utilisateur avec les données chargées.

    String jsonString_1 =
        await rootBundle.loadString('assets/files/villes_france.json');

    // Décoder le JSON 1
    jsonResponse_1 = json.decode(jsonString_1);
    setState(() {
      _items = jsonResponse_1;
    });
  }

  void filterItem(String itemName) {
    /// Fonction pour filtrer la recherche de ville de départ et d'arrivé 
    /// dans les saisies de zones de départ et d'arrivé
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

  @override
  Widget build(BuildContext context) {
    // construction de l'interface graphique principale de l'application
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
                // validation des champs  (villes de départ et d'arrivé)
                if (_formKey.currentState!.validate()) {
                  FocusScope.of(context).unfocus();
                  setState(() {
                    travelTimeFuture = getDepartureTimeArrival(
                        departureController.text, arrivalController.text);
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
              : FutureBuilder<TravelTime>(
                  future: getDepartureTimeArrival(
                      departureController.text, arrivalController.text),
                  builder: (context, snapshot) {
                    // builder pour recevoir la données de l'Api
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // until data is fetched, show loader
                      return const Expanded(
                          child: Center(child: CircularProgressIndicator()));
                    } else if (snapshot.hasData) {
                      // once data is fetched, display it on screen (call buildPosts())
                      final post = snapshot.data!;
                      return CityTravelCard(context, post.departure,
                          post.arrival, post.travel, post.timeTravel);
                    } else {
                      // if no data, show simple Text
                      return const Expanded(
                        child: Center(
                            child: Text("Aucune Données sur le temps de Trajet",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ))),
                      );
                    }
                  },
                )
        ],
      ),
    );
  }
}

String convertirMinutesEnHeuresEtMinutes(String minutesString) {
  // fonctions permettant de convertir un temps en chaine de carctères
  // en Heures et Minutes
  int totalMinutes = int.parse(minutesString);

  // Calcul des heures et des minutes restantes
  int heures = totalMinutes ~/ 60;
  int minutes = totalMinutes % 60;

  // Construction de la chaîne de résultat
  if (heures > 0 && minutes > 0) {
    return '$heures heures et $minutes minutes';
  } else if (heures > 0) {
    return '$heures heures';
  } else {
    return '$minutes minutes';
  }
}

Widget CityTravelCard(
  // Card peremettant d'afficher le temps de trajet entre la ville de départ et d'arrivé
  // 
  BuildContext context, departure, arrival, travel, timeTravel) {
  // Récupérer la largeur et la hauteur de l'écran
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  String villesString = "";

  if (travel != '') {
    // Suppression des crochets au début et à la fin de la chaîne
    villesString = travel.substring(1, travel.length - 1);
    villesString = villesString.replaceAll(",", "->");
  }

  String time = convertirMinutesEnHeuresEtMinutes(timeTravel);
  double heightWidth =
      (travel != '') ? screenHeight * 0.285 : screenHeight * 0.14;

  return SizedBox(
    width: screenWidth * 0.94,
    height: heightWidth,
    child: Card(
      color: const Color.fromARGB(255, 222, 224, 207),
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  departure,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.arrow_forward_outlined, // The icon to display
                      color: Colors.black, // The color of the icon
                      size: 30.0, // The size of the icon
                    ),
                    Icon(
                      Icons.directions_car, // The icon to display
                      color: Colors.black, // The color of the icon
                      size: 20.0, // The size of the icon
                    ),
                  ],
                ),
                Text(
                  arrival,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            (travel != '')
                ? Text(
                    villesString,
                    softWrap: true,
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : const SizedBox(height: 10.0),
            Text(
              'Temps du Trajet: $time',
              softWrap: true,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
