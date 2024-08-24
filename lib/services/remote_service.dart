import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:france_itineraire/core/configs_api.dart';
import 'package:france_itineraire/models/TravelTime.dart';

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
