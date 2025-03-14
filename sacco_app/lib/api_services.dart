import 'package:flutter/foundation.dart';
import 'package:sacco_app/environment.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static Future<List<dynamic>> attemptLogIn(
      String email, String password) async {
    var res = await http.post(Uri.parse("${Environment.serverIp}/users/login/"),
        body: {"email": email, "password": password});
    var list = [res.body, res.statusCode];
    return list;
  }

  static Future<List<dynamic>> attemptSignUp(
      String name, String nationalId, String email, String password) async {
    var res = await http.post(
      Uri.parse("${Environment.serverIp}/users/register/"),
      body: {
        "name": name,
        "national_id": nationalId,
        "email": email,
        "password": password
      },
    );
    var list = [res.body, res.statusCode];
    return list;
  }

  static Future<List<dynamic>> makeApplication(
      String accountPurpose, String saccoId, String userId, String accessToken,
      {referralCode}) async {
    Map<String, dynamic> body;

    if (referralCode == null) {
      body = {
        "account_purpose": accountPurpose,
        "sacco_id": saccoId,
        "user_id": userId,
      };
    } else {
      body = {
        "account_purpose": accountPurpose,
        "sacco_id": saccoId,
        "user_id": userId,
        "access_token": accessToken,
        "referral_code": referralCode
      };
    }

    var res = await http.post(
        Uri.parse("${Environment.serverIp}/sacco/sacco-member-applications/"),
        body: body,
        headers: {"Authorization": "JWT $accessToken"});
    var list = [res.body, res.statusCode];
    return list;
  }

  static Future<List<dynamic>> createReferralCode(
    String referralMethod,
    String saccoId,
    String userId,
    String accessToken,
  ) async {
    Map<String, dynamic> body;

    body = {"referral_type": referralMethod, "sacco": saccoId, "user": userId};

    var res = await http.post(
        Uri.parse("${Environment.serverIp}/sacco/referrals/"),
        body: body,
        headers: {"Authorization": "JWT $accessToken"});
    var list = [res.body, res.statusCode];
    return list;
  }

  static Future<List<dynamic>> getUserProfile(accessToken, userId) async {
    var res = await http.get(
        Uri.parse("${Environment.serverIp}/users/user-profile/?id=$userId"),
        headers: {"Authorization": "JWT $accessToken"});
    var list = [res.statusCode, res.body];

    return list;
  }

  static Future<List<dynamic>> validateReferalCode(
      accessToken, saccoId, referralCode) async {
    var res = await http.get(
        Uri.parse(
            "${Environment.serverIp}/sacco/validate-referral-code/?sacco_id=$saccoId&referral_code=$referralCode"),
        headers: {"Authorization": "JWT $accessToken"});
    var list = [res.statusCode, res.body];

    return list;
  }

  static Future<List<dynamic>> getMemberSaccos(accessToken, userId) async {
    var res = await http.get(
        Uri.parse(
            "${Environment.serverIp}/sacco/get-member-saccos/?user_id=$userId"),
        headers: {"Authorization": "JWT $accessToken"});
    var list = [res.statusCode, res.body];
    return list;
  }

  static Future<List<dynamic>> getMyReferrals(accessToken, userId) async {
    var res = await http.get(
        Uri.parse("${Environment.serverIp}/sacco/my-referrals?user_id=$userId"),
        headers: {"Authorization": "JWT $accessToken"});
    var list = [res.statusCode, res.body];
    return list;
  }

  static Future<List<dynamic>> getAllSaccos(accessToken, userId) async {
    var res = await http.get(
        Uri.parse(
            "${Environment.serverIp}/sacco/get-all-sacco-am-no-member/?user_id=$userId"),
        headers: {"Authorization": "JWT $accessToken"});
    var list = [res.statusCode, res.body];
    return list;
  }

  static Future<List<dynamic>> getMemberApplications(
      accessToken, userId, statusPassed) async {
    var res = await http.get(
        Uri.parse(
            "${Environment.serverIp}/sacco/get-sacco-member-applications-info/?user_id=$userId&status_passed=$statusPassed"),
        headers: {"Authorization": "JWT $accessToken"});
    var list = [res.statusCode, res.body];
    return list;
  }

  static Future<List<dynamic>> getFullSaccoInfo(accessToken, saccoId) async {
    var res = await http.get(
        Uri.parse(
            "${Environment.serverIp}/sacco/view-full-sacco_info/?sacco_id=$saccoId"),
        headers: {"Authorization": "JWT $accessToken"});
    var list = [res.statusCode, res.body];
    return list;
  }

  static Future<List<dynamic>> updateProfileDetails(
      accessToken,
      userId,
      email,
      name,
      phoneNumber,
      country,
      city,
      dateOfBirth,
      identificationNumber,
      maritalStatus,
      emplStatus,
      emplyName,
      emplyPhone,
      emplyEmail,
      profilePicture) async {
    Map<String, String> body = {
      "email": email,
      "name": name,
      "phone_number": phoneNumber,
      "country": country,
      "city": city,
      "date_of_birth": dateOfBirth,
      "national_id": identificationNumber,
      "marital_status": maritalStatus,
      "employment_status": emplStatus,
      "employer_name": emplyName,
      "employer_phone": emplyPhone,
      "employer_email": emplyEmail,
    };

    Map<String, String> headers = {"Authorization": "JWT $accessToken"};

    var request = http.MultipartRequest('PATCH',
        Uri.parse('${Environment.serverIp}/users/edit-user-profile/$userId/'))
      ..fields.addAll(body)
      ..headers.addAll(headers);

    if (profilePicture != null) {
      request.files.add(
        await http.MultipartFile.fromPath('profile_picture', profilePicture),
      );
    }

    var response = await request.send();
    var responseString = await response.stream.bytesToString();

    if (kDebugMode) {
      print(responseString);
    }
    var list = [responseString, response.statusCode];

    return list;
  }
}
