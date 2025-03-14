import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sacco_app/api_services.dart';
import 'package:sacco_app/constants.dart';
import 'package:sacco_app/models/user_profile.dart';

class MyAccount extends StatefulWidget {
  final String accessToken;
  final String userId;
  const MyAccount({
    super.key,
    required this.accessToken,
    required this.userId,
  });

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: kPrimaryColor,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "My Account",
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: white,
            ),
          ),
        ),
      ),
      body: MyAccountBody(
        accessToken: widget.accessToken,
        userId: widget.userId,
      ),
    );
  }
}

class MyAccountBody extends StatelessWidget {
  final String accessToken;
  final String userId;
  const MyAccountBody(
      {super.key, required this.accessToken, required this.userId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.delayed(const Duration(seconds: 2))
            .then((value) => ApiServices.getUserProfile(accessToken, userId)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none) {
            return const Text('No data Found');
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          var data = snapshot.data;

          var jsonRes = json.decode(data![1]);

          var decodedProfile = UserProfileModel.fromJson(jsonRes);
          var profile = decodedProfile.results;

          int filledFieldsCount = 0;
          int totalFieldsCount = profile.first.toJson().length;

          bool isFieldFilled(dynamic fieldValue) {
            return fieldValue != null && fieldValue != "";
          }

          profile.first.toJson().forEach((key, value) {
            if (isFieldFilled(value)) {
              filledFieldsCount++;
            }
          });

          double percentageFilled =
              (filledFieldsCount / totalFieldsCount) * 100;

          // Determine the color based on the percentage
          Color progressBarColor;
          if (percentageFilled >= 80) {
            progressBarColor = Colors.green;
          } else if (percentageFilled >= 65) {
            progressBarColor = Colors.yellow;
          } else {
            progressBarColor = Colors.red;
          }
          return Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.20,
                child: Stack(
                  children: [
                    ClipPath(
                      clipper: CustomShape(),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.17,
                        color: kPrimaryColor,
                      ),
                    ),
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                              bottom: kDefaultPadding / 2,
                            ),
                            height: MediaQuery.of(context).size.height * 0.15,
                            width: MediaQuery.of(context).size.width * 0.25,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: white,
                                width:
                                    MediaQuery.of(context).size.width * 0.015,
                              ),
                              image: DecorationImage(
                                image:
                                    NetworkImage(profile.first.profilePicture),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: LinearProgressIndicator(
                  value: percentageFilled / 100,
                  backgroundColor: Colors.grey,
                  valueColor: AlwaysStoppedAnimation<Color>(progressBarColor),
                ),
              ),
              // Text showing the percentage
              Text(
                "${percentageFilled.toStringAsFixed(0)}% Complete",
                style: TextStyle(
                  color: progressBarColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 1.6,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultPadding * 1.5,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        buildText("Full Name", profile.first.name,
                            MediaQuery.of(context).size),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        buildText("Email Address", profile.first.email,
                            MediaQuery.of(context).size),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        buildText(
                            "Phone Number",
                            profile.first.phoneNumber.toString(),
                            MediaQuery.of(context).size),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        buildText(
                            "Passport/Identification Number",
                            profile.first.identificationNumber ??
                                'Not provided',
                            MediaQuery.of(context).size),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        buildText(
                            "Country",
                            profile.first.country ?? 'Not provided',
                            MediaQuery.of(context).size),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        buildText("City", profile.first.city ?? 'Not provided',
                            MediaQuery.of(context).size),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        buildText(
                            "Date of Birth",
                            DateFormat("MM/dd/yyyy")
                                .format(profile.first.dateOfBirth)
                                .toString(),
                            MediaQuery.of(context).size),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        buildText("Gender", profile.first.gender,
                            MediaQuery.of(context).size),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        buildText(
                            "Nationality",
                            profile.first.nationality ?? 'Not provided',
                            MediaQuery.of(context).size),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        buildText(
                            "Marital Status",
                            profile.first.maritalStatus ?? 'Not provided',
                            MediaQuery.of(context).size),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        buildText(
                            "Employment Status",
                            profile.first.employmentStatus,
                            MediaQuery.of(context).size),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        buildText(
                            "Employer Name",
                            profile.first.employerName ?? 'Not provided',
                            MediaQuery.of(context).size),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        buildText(
                            "Employer Phone",
                            profile.first.employerPhone ?? 'Not provided',
                            MediaQuery.of(context).size),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        buildText(
                            "Employer Email",
                            profile.first.employerEmail ?? 'Not provided',
                            MediaQuery.of(context).size),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }
}

Widget buildText(String label, String value, size) {
  return Container(
    height: size.height * 0.08,
    padding: EdgeInsets.all(15),
    decoration: BoxDecoration(
      color: kBackgroundColor,
      borderRadius: BorderRadius.circular(5),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w400,
            color: Color.fromRGBO(0, 0, 0, 1),
            fontSize: 12,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w400,
            color: black,
          ),
        ),
      ],
    ),
  );
}

class CustomShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    double height = size.height;
    double width = size.width;
    path.lineTo(0, height - 120);
    path.quadraticBezierTo(width / 2, height, width, height - 120);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
