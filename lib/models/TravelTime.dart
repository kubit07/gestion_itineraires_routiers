/// La classe `TravelTime` représente les informations liées à un trajet, 
/// comprenant la ville de départ, la ville d'arrivée, l'itinéraire du trajet, 
/// et la durée du trajet.
///
/// Attributs :
/// - `departure` : Ville de départ.
/// - `arrival` : Ville d'arrivée.
/// - `travel` : Itinéraire du trajet.
/// - `timeTravel` : Durée du trajet en temps sous forme de chaîne de caractères.
///
/// Constructeur :
/// - Le constructeur `TravelTime` est utilisé pour créer une instance de la classe 
///   avec des valeurs requises pour chaque attribut.
///
/// Méthodes :
/// - `fromJson` : Méthode factory qui permet de créer une instance de `TravelTime` à partir d'un 
///   objet JSON.
/// - `toJson` : Convertit une instance de `TravelTime` en un objet JSON.

// ignore_for_file: file_names

import 'dart:convert';

class TravelTime {
    final String departure;
    final String arrival;
    final String travel;
    final String timeTravel;

    TravelTime({
        required this.departure,
        required this.arrival,
        required this.travel,
        required this.timeTravel,
    });

    factory TravelTime.fromJson(Map<String, dynamic> json) => TravelTime(
        departure: json["departure"],
        arrival: json["arrival"],
        travel: json["travel"] ?? '',
        timeTravel: json["time_travel"],
    );

    Map<String, dynamic> toJson() => {
        "departure": departure,
        "arrival": arrival,
        "travel": travel,
        "time_travel": timeTravel,
    };
}
