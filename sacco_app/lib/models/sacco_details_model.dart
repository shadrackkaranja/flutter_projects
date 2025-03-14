// To parse this JSON data, do
//
//     final saccoDetailsModel = saccoDetailsModelFromJson(jsonString);

import 'dart:convert';

SaccoDetailsModel saccoDetailsModelFromJson(String str) =>
    SaccoDetailsModel.fromJson(json.decode(str));

String saccoDetailsModelToJson(SaccoDetailsModel data) =>
    json.encode(data.toJson());

class SaccoDetailsModel {
  int count;
  List<Result> results;

  SaccoDetailsModel({
    required this.count,
    required this.results,
  });

  factory SaccoDetailsModel.fromJson(Map<String, dynamic> json) =>
      SaccoDetailsModel(
        count: json["count"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  dynamic saccoId;
  dynamic saccoName;
  dynamic saccoMotto;
  dynamic saccoEmail;
  dynamic saccoAbout;
  dynamic saccoAddress;
  dynamic saccoPhoneNumber;
  dynamic saccoProfilePicture;
  List<Feature> features;
  List<Requirement> requirements;

  Result({
    required this.saccoId,
    required this.saccoName,
    required this.saccoMotto,
    required this.saccoEmail,
    required this.saccoAbout,
    required this.saccoAddress,
    required this.saccoPhoneNumber,
    required this.saccoProfilePicture,
    required this.features,
    required this.requirements,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        saccoId: json["sacco_id"],
        saccoName: json["sacco_name"],
        saccoMotto: json["sacco_motto"],
        saccoEmail: json["sacco_email"],
        saccoAbout: json["sacco_about"],
        saccoAddress: json["sacco_address"],
        saccoPhoneNumber: json["sacco_phone_number"],
        saccoProfilePicture: json["sacco_profile_picture"],
        features: List<Feature>.from(
            json["features"].map((x) => Feature.fromJson(x))),
        requirements: List<Requirement>.from(
            json["requirements"].map((x) => Requirement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "sacco_id": saccoId,
        "sacco_name": saccoName,
        "sacco_motto": saccoMotto,
        "sacco_email": saccoEmail,
        "sacco_about": saccoAbout,
        "sacco_address": saccoAddress,
        "sacco_phone_number": saccoPhoneNumber,
        "sacco_profile_picture": saccoProfilePicture,
        "features": List<dynamic>.from(features.map((x) => x.toJson())),
        "requirements": List<dynamic>.from(requirements.map((x) => x.toJson())),
      };
}

class Feature {
  dynamic title;
  dynamic description;

  Feature({
    required this.title,
    required this.description,
  });

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        title: json["title"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
      };
}

class Requirement {
  dynamic description;

  Requirement({
    required this.description,
  });

  factory Requirement.fromJson(Map<String, dynamic> json) => Requirement(
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
      };
}
