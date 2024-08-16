import 'package:flutter/material.dart';
import 'package:france_itineraire/core/constants.dart';

class CityTravelCard extends StatelessWidget {
  final String departure;
  final String arrival;
  final String travelTime;

  const CityTravelCard(
      {super.key,
      required this.departure,
      required this.arrival,
      required this.travelTime});

  @override
  Widget build(BuildContext context) {

    // Récupérer la largeur et la hauteur de l'écran
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    
    return SizedBox(
      width: screenWidth * 0.94,
      height: screenHeight * 0.14,
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
                'Temps du Trajet: $travelTime min',
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
    );
  }
}
