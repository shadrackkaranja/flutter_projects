// To parse this JSON data, do
//
//     final saccoInfoModel = saccoInfoModelFromJson(jsonString);

import 'dart:convert';

SaccoInfoModel saccoInfoModelFromJson(String str) => SaccoInfoModel.fromJson(json.decode(str));

String saccoInfoModelToJson(SaccoInfoModel data) => json.encode(data.toJson());

class SaccoInfoModel {
    List<Result> results;

    SaccoInfoModel({
        required this.results,
    });

    factory SaccoInfoModel.fromJson(Map<String, dynamic> json) => SaccoInfoModel(
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class Result {
    String profilePicture;
    int membersJoined;
    String saccoName;
    String saccoMotto;
    String saccoEmail;
    String saccoAbout;
    String saccoAddress;
    String saccoPhoneNumber;
    List<List<Feature>> features;
    List<List<Requirement>> requirements;

    Result({
        required this.profilePicture,
        required this.membersJoined,
        required this.saccoName,
        required this.saccoMotto,
        required this.saccoEmail,
        required this.saccoAbout,
        required this.saccoAddress,
        required this.saccoPhoneNumber,
        required this.features,
        required this.requirements,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        profilePicture: json["profile_picture"],
        membersJoined: json["members_joined"],
        saccoName: json["sacco_name"],
        saccoMotto: json["sacco_motto"],
        saccoEmail: json["sacco_email"],
        saccoAbout: json["sacco_about"],
        saccoAddress: json["sacco_address"],
        saccoPhoneNumber: json["sacco_phone_number"],
        features: List<List<Feature>>.from(json["features"].map((x) => List<Feature>.from(x.map((x) => Feature.fromJson(x))))),
        requirements: List<List<Requirement>>.from(json["requirements"].map((x) => List<Requirement>.from(x.map((x) => Requirement.fromJson(x))))),
    );

    Map<String, dynamic> toJson() => {
        "profile_picture": profilePicture,
        "members_joined": membersJoined,
        "sacco_name": saccoName,
        "sacco_motto": saccoMotto,
        "sacco_email": saccoEmail,
        "sacco_about": saccoAbout,
        "sacco_address": saccoAddress,
        "sacco_phone_number": saccoPhoneNumber,
        "features": List<dynamic>.from(features.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
        "requirements": List<dynamic>.from(requirements.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
    };
}

class Feature {
    String title;
    String description;

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
    String description;

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
