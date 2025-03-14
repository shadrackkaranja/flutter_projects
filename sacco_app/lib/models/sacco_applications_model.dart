// To parse this JSON data, do
//
//     final saccoApplicationsModel = saccoApplicationsModelFromJson(jsonString);

import 'dart:convert';

SaccoApplicationsModel saccoApplicationsModelFromJson(String str) =>
    SaccoApplicationsModel.fromJson(json.decode(str));

String saccoApplicationsModelToJson(SaccoApplicationsModel data) =>
    json.encode(data.toJson());

class SaccoApplicationsModel {
  int count;
  List<Result> results;

  SaccoApplicationsModel({
    required this.count,
    required this.results,
  });

  factory SaccoApplicationsModel.fromJson(Map<String, dynamic> json) =>
      SaccoApplicationsModel(
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
  dynamic applicationId;
  dynamic userId;
  dynamic memberName;
  dynamic memberPhoneNumber;
  dynamic memberCountry;
  dynamic memberCity;
  DateTime memberDateOfBirth;
  dynamic memberGender;
  dynamic memberNationality;
  dynamic memberPassport;
  dynamic memberNationalId;
  dynamic memberMaritalStatus;
  dynamic memberEmail;
  dynamic employmentStatus;
  dynamic employerName;
  dynamic employerPhone;
  dynamic employerEmail;
  dynamic profilePicture;
  dynamic accountPurpose;
  dynamic saccoId;
  dynamic saccoImage;
  dynamic saccoName;
  dynamic saccoMotto;
  dynamic saccoEmail;
  dynamic saccoAbout;
  dynamic saccoAddress;
  dynamic saccoPhoneNumber;
  dynamic joiningDate;
  dynamic referal;
  dynamic applicationStatus;

  Result({
    required this.applicationId,
    required this.userId,
    required this.memberName,
    required this.memberPhoneNumber,
    required this.memberCountry,
    required this.memberCity,
    required this.memberDateOfBirth,
    required this.memberGender,
    required this.memberNationality,
    required this.memberPassport,
    required this.memberNationalId,
    required this.memberMaritalStatus,
    required this.memberEmail,
    required this.employmentStatus,
    required this.employerName,
    required this.employerPhone,
    required this.employerEmail,
    required this.profilePicture,
    required this.accountPurpose,
    required this.saccoId,
    required this.saccoImage,
    required this.saccoName,
    required this.saccoMotto,
    required this.saccoEmail,
    required this.saccoAbout,
    required this.saccoAddress,
    required this.saccoPhoneNumber,
    required this.joiningDate,
    required this.referal,
    required this.applicationStatus,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        applicationId: json["application_id"],
        userId: json["user_id"],
        memberName: json["member_name"],
        memberPhoneNumber: json["member_phone_number"],
        memberCountry: json["member_country"],
        memberCity: json["member_city"],
        memberDateOfBirth: DateTime.parse(json["member_date_of_birth"]),
        memberGender: json["member_gender"],
        memberNationality: json["member_nationality"],
        memberPassport: json["member_passport"],
        memberNationalId: json["member_national_id"],
        memberMaritalStatus: json["member_marital_status"],
        memberEmail: json["member_email"],
        employmentStatus: json["employment_status"],
        employerName: json["employer_name"],
        employerPhone: json["employer_phone"],
        employerEmail: json["employer_email"],
        profilePicture: json["profile_picture"],
        accountPurpose: json["account_purpose"],
        saccoId: json["sacco_id"],
        saccoImage: json["sacco_image"],
        saccoName: json["sacco_name"],
        saccoMotto: json["sacco_motto"],
        saccoEmail: json["sacco_email"],
        saccoAbout: json["sacco_about"],
        saccoAddress: json["sacco_address"],
        saccoPhoneNumber: json["sacco_phone_number"],
        joiningDate: json["joining_date"],
        referal: json["referal"],
        applicationStatus: json["application_status"],
      );

  Map<String, dynamic> toJson() => {
        "application_id": applicationId,
        "user_id": userId,
        "member_name": memberName,
        "member_phone_number": memberPhoneNumber,
        "member_country": memberCountry,
        "member_city": memberCity,
        "member_date_of_birth":
            "${memberDateOfBirth.year.toString().padLeft(4, '0')}-${memberDateOfBirth.month.toString().padLeft(2, '0')}-${memberDateOfBirth.day.toString().padLeft(2, '0')}",
        "member_gender": memberGender,
        "member_nationality": memberNationality,
        "member_passport": memberPassport,
        "member_national_id": memberNationalId,
        "member_marital_status": memberMaritalStatus,
        "member_email": memberEmail,
        "employment_status": employmentStatus,
        "employer_name": employerName,
        "employer_phone": employerPhone,
        "employer_email": employerEmail,
        "profile_picture": profilePicture,
        "account_purpose": accountPurpose,
        "sacco_id": saccoId,
        "sacco_image": saccoImage,
        "sacco_name": saccoName,
        "sacco_motto": saccoMotto,
        "sacco_email": saccoEmail,
        "sacco_about": saccoAbout,
        "sacco_address": saccoAddress,
        "sacco_phone_number": saccoPhoneNumber,
        "joining_date": joiningDate,
        "referal": referal,
        "application_status": applicationStatus,
      };
}
