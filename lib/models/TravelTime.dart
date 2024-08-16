import 'dart:convert';

class TravelTime {
    String departure;
    String arrival;
    String timeTravel;
    String? timeScraping;
    String? file;

    TravelTime({
        required this.departure,
        required this.arrival,
        required this.timeTravel,
        this.timeScraping,
        this.file,
    });

    factory TravelTime.fromJson(Map<String, dynamic> json) => TravelTime(
        departure: json["departure"],
        arrival: json["arrival"],
        timeTravel: json["time_travel"],
        timeScraping: json["time_scraping"],
        file: json["file"],
    );

    factory TravelTime.fromData(dynamic data) => TravelTime(
        departure: data["departure"],
        arrival: data["arrival"],
        timeTravel: data["time_travel"],
        timeScraping: data["time_scraping"],
        file: data["file"],
    );

    Map<String, dynamic> toJson() => {
        "departure": departure,
        "arrival": arrival,
        "time_travel": timeTravel,
        "time_scraping": timeScraping,
        "file": file,
    };
}
