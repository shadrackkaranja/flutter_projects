// To parse this JSON data, do
//
//     final myReferralsModel = myReferralsModelFromJson(jsonString);

import 'dart:convert';

MyReferralsModel myReferralsModelFromJson(String str) =>
    MyReferralsModel.fromJson(json.decode(str));

String myReferralsModelToJson(MyReferralsModel data) =>
    json.encode(data.toJson());

class MyReferralsModel {
  int count;
  List<Result> results;

  MyReferralsModel({
    required this.count,
    required this.results,
  });

  factory MyReferralsModel.fromJson(Map<String, dynamic> json) =>
      MyReferralsModel(
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
  dynamic referreeName;
  dynamic referreeProfilePicture;
  dynamic referralMethod;
  dynamic referredSaccoName;

  Result({
    required this.referreeName,
    required this.referreeProfilePicture,
    required this.referralMethod,
    required this.referredSaccoName,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        referreeName: json["referree_name"],
        referreeProfilePicture: json["referree_profile_picture"],
        referralMethod: json["referral_method"],
        referredSaccoName: json["referred_sacco_name"],
      );

  Map<String, dynamic> toJson() => {
        "referree_name": referreeName,
        "referree_profile_picture": referreeProfilePicture,
        "referral_method": referralMethod,
        "referred_sacco_name": referredSaccoName,
      };
}
