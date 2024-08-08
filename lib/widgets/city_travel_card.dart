import 'package:flutter/material.dart';

class CityTravelCard extends StatelessWidget {
  final String city1;
  final String city2;
  final int travelTime;

  const CityTravelCard({super.key, required this.city1, required this.city2, required this.travelTime});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              '$city1 -> $city2',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Travel Time: $travelTime minutes',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}