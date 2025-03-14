// To parse this JSON data, do
//
//     final userProfileModel = userProfileModelFromJson(jsonString);

import 'dart:convert';

UserProfileModel userProfileModelFromJson(String str) =>
    UserProfileModel.fromJson(json.decode(str));

String userProfileModelToJson(UserProfileModel data) =>
    json.encode(data.toJson());

class UserProfileModel {
  dynamic count;
  dynamic next;
  dynamic previous;
  List<Result> results;

  UserProfileModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      UserProfileModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  int id;
  dynamic email;
  dynamic name;
  dynamic phoneNumber;
  dynamic country;
  dynamic city;
  dynamic dateOfBirth;
  dynamic gender;
  dynamic nationality;
  dynamic identificationNumber;
  dynamic maritalStatus;
  dynamic employmentStatus;
  dynamic employerName;
  dynamic employerPhone;
  dynamic employerEmail;
  dynamic normalizedUsername;
  dynamic profilePicture;
  DateTime createdAt;
  DateTime updatedAt;

  Result({
    required this.id,
    required this.email,
    required this.name,
    required this.phoneNumber,
    required this.country,
    required this.city,
    required this.dateOfBirth,
    required this.gender,
    required this.nationality,
    required this.identificationNumber,
    required this.maritalStatus,
    required this.employmentStatus,
    required this.employerName,
    required this.employerPhone,
    required this.employerEmail,
    required this.normalizedUsername,
    required this.profilePicture,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        email: json["email"],
        name: json["name"],
        phoneNumber: json["phone_number"],
        country: json["country"],
        city: json["city"],
        dateOfBirth: json["date_of_birth"] == null
            ? json["date_of_birth"]
            : DateTime.parse(json["date_of_birth"]),
        gender: json["gender"],
        nationality: json["nationality"],
        identificationNumber: json["identification_number"],
        maritalStatus: json["marital_status"],
        employmentStatus: json["employment_status"],
        employerName: json["employer_name"],
        employerPhone: json["employer_phone"],
        employerEmail: json["employer_email"],
        normalizedUsername: json["normalized_username"],
        profilePicture: json["profile_picture"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "name": name,
        "phone_number": phoneNumber,
        "country": country,
        "city": city,
        "date_of_birth":
            "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
        "gender": gender,
        "nationality": nationality,
        "identification_number": identificationNumber,
        "marital_status": maritalStatus,
        "employment_status": employmentStatus,
        "employer_name": employerName,
        "employer_phone": employerPhone,
        "employer_email": employerEmail,
        "normalized_username": normalizedUsername,
        "profile_picture": profilePicture,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
