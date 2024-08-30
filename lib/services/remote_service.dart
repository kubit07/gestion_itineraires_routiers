import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:france_itineraire/core/configs_api.dart';
import 'package:france_itineraire/models/TravelTime.dart';

/// Récupère les horaires de trajet entre deux lieux.
///
/// Envoie une requête POST à l'API pour obtenir les horaires basés sur les
/// lieux `departure` et `arrival`. La réponse est décodée et convertie
/// en un objet `TravelTime`.
///
/// Le `Bearer token` utilisé dans les en-têtes de la requête est crucial pour 
/// l'authentification. Ce token est obtenu lors de la création d'un utilisateur 
/// via l'API et est nécessaire pour accéder aux services protégés par l'API.
/// 
/// ### Paramètres:
/// - `departure` (String): Lieu de départ.
/// - `arrival` (String): Lieu d'arrivée.
///
/// ### Retourne:
/// - `Future<TravelTime>`: Contient les horaires de départ et d'arrivée.

Future<TravelTime> getDepartureTimeArrival(
    String departure, String arrival) async {
  String url = ServerConfigs.api_get_departure_time_arrival_url;
  var body_request = jsonEncode({'departure': departure, 'arrival': arrival});
  final response = await http.post(Uri.parse(url),
      headers: {
        "Accept": 'application/json',
        "content-type": "application/json",
        "Authorization": "Bearer ${ServerConfigs.bearer_token}"
      },
      body: body_request);
  final body = json.decode(response.body);

  return TravelTime.fromJson(body);
}
