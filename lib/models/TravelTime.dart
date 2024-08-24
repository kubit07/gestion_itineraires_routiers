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
