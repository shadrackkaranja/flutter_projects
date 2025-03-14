// To parse this JSON data, do
//
//     final memberSaccos = memberSaccosFromJson(jsonString);

import 'dart:convert';

MemberSaccos memberSaccosFromJson(String str) => MemberSaccos.fromJson(json.decode(str));

String memberSaccosToJson(MemberSaccos data) => json.encode(data.toJson());

class MemberSaccos {
    int count;
    List<Result> results;

    MemberSaccos({
        required this.count,
        required this.results,
    });

    factory MemberSaccos.fromJson(Map<String, dynamic> json) => MemberSaccos(
        count: json["count"],
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class Result {
    int saccoId;
    SaccoInfo saccoInfo;

    Result({
        required this.saccoId,
        required this.saccoInfo,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        saccoId: json["sacco_id"],
        saccoInfo: SaccoInfo.fromJson(json["sacco_info"]),
    );

    Map<String, dynamic> toJson() => {
        "sacco_id": saccoId,
        "sacco_info": saccoInfo.toJson(),
    };
}

class SaccoInfo {
    int id;
    String name;
    String motto;
    String email;
    String about;
    String phoneNumber;
    String profilePicture;
    String address;

    SaccoInfo({
        required this.id,
        required this.name,
        required this.motto,
        required this.email,
        required this.about,
        required this.phoneNumber,
        required this.profilePicture,
        required this.address,
    });

    factory SaccoInfo.fromJson(Map<String, dynamic> json) => SaccoInfo(
        id: json["id"],
        name: json["name"],
        motto: json["motto"],
        email: json["email"],
        about: json["about"],
        phoneNumber: json["phone_number"],
        profilePicture: json["profile_picture"],
        address: json["address"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "motto": motto,
        "email": email,
        "about": about,
        "phone_number": phoneNumber,
        "profile_picture": profilePicture,
        "address": address,
    };
}
