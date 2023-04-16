// To parse this JSON data, do
//
//     final diseaseModel = diseaseModelFromJson(jsonString);

import 'dart:convert';

DiseaseModel diseaseModelFromJson(String str) =>
    DiseaseModel.fromJson(json.decode(str));

String diseaseModelToJson(DiseaseModel data) => json.encode(data.toJson());

class DiseaseModel {
  DiseaseModel({
    required this.disease,
    required this.plant,
    required this.remedy,
  });

  String disease;
  String plant;
  String remedy;

  factory DiseaseModel.fromJson(Map<String, dynamic> json) => DiseaseModel(
        disease: json["disease"],
        plant: json["plant"],
        remedy: json["remedy"],
      );

  Map<String, dynamic> toJson() => {
        "disease": disease,
        "plant": plant,
        "remedy": remedy,
      };
}
