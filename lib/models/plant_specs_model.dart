// To parse this JSON data, do
//
//     final plantSpecs = plantSpecsFromJson(jsonString);

import 'dart:convert';

PlantSpecs plantSpecsFromJson(String str) =>
    PlantSpecs.fromJson(json.decode(str));

String plantSpecsToJson(PlantSpecs data) => json.encode(data.toJson());

class PlantSpecs {
  PlantSpecs({
    required this.data,
    required this.whetherdata,
    required this.youtube,
  });

  Data data;
  Whetherdata whetherdata;
  List<Youtube> youtube;

  factory PlantSpecs.fromJson(Map<String, dynamic> json) => PlantSpecs(
        data: Data.fromJson(json["data"]),
        whetherdata: Whetherdata.fromJson(json["whetherdata"]),
        youtube:
            List<Youtube>.from(json["youtube"].map((x) => Youtube.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "whetherdata": whetherdata.toJson(),
        "youtube": List<dynamic>.from(youtube.map((x) => x.toJson())),
      };
}

class Data {
  Data({
    required this.id,
    required this.hour,
    required this.minute,
    required this.second,
    required this.status,
    required this.frequency,
    required this.plantbio,
    required this.name,
    required this.v,
  });

  String id;
  int hour;
  int minute;
  int second;
  String status;
  int frequency;
  String plantbio;
  String name;
  int v;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        hour: json["hour"],
        minute: json["minute"],
        second: json["second"],
        status: json["status"],
        frequency: json["Frequency"],
        plantbio: json["plantbio"],
        name: json["name"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "hour": hour,
        "minute": minute,
        "second": second,
        "status": status,
        "Frequency": frequency,
        "plantbio": plantbio,
        "name": name,
        "__v": v,
      };
}

class Whetherdata {
  Whetherdata({
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

  factory Whetherdata.fromJson(Map<String, dynamic> json) => Whetherdata(
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

class Youtube {
  Youtube({
    required this.title,
    required this.url,
    required this.thumbnail,
  });

  String title;
  String url;
  String thumbnail;

  factory Youtube.fromJson(Map<String, dynamic> json) => Youtube(
        title: json["title"],
        url: json["url"],
        thumbnail: json["thumbnail"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "url": url,
        "thumbnail": thumbnail,
      };
}
