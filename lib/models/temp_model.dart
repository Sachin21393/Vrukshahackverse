// To parse this JSON data, do
//
//     final tempRes = tempResFromJson(jsonString);

import 'dart:convert';

TempRes tempResFromJson(String str) => TempRes.fromJson(json.decode(str));

String tempResToJson(TempRes data) => json.encode(data.toJson());

class TempRes {
  TempRes({
    required this.humidity,
    required this.temperature,
    required this.weather,
    required this.ph,
    required this.wind,
  });

  int humidity;
  int temperature;
  String weather;
  double ph;
  double wind;

  factory TempRes.fromJson(Map<String, dynamic> json) => TempRes(
        humidity: json["humidity"],
        temperature: json["temperature"],
        weather: json["weather"],
        ph: json["ph"]?.toDouble(),
        wind: json["wind"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "humidity": humidity,
        "temperature": temperature,
        "weather": weather,
        "ph": ph,
        "wind": wind,
      };
}
