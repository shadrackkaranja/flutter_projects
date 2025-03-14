import 'dart:convert';

import 'package:dob_input_field/dob_input_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:sacco_app/api_services.dart';
import 'package:sacco_app/constants.dart';

import 'package:intl/intl.dart';
import 'package:sacco_app/models/sacco_details_model.dart';
import 'package:sacco_app/models/user_profile.dart' as user_profile;
import 'package:sacco_app/screens/user_application/application_submission_success.dart';
import 'package:sacco_app/screens/user_profile/update_profile.dart';

class ApplicationBody extends StatefulWidget {
  final Result saccoList;
  final String accessToken;
  final String userId;
  const ApplicationBody(
      {super.key,
      required this.saccoList,
      required this.userId,
      required this.accessToken});

  @override
  State<ApplicationBody> createState() => _ApplicationBodyState();
}

class _ApplicationBodyState extends State<ApplicationBody> {
  final TextEditingController referralCode = TextEditingController();
  String accountPurpose = "Savings";
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ApiServices.getUserProfile(widget.accessToken, widget.userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none) {
            return const Text('No data Found');
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          var data = snapshot.data;

          var jsonRes = json.decode(data![1]);

          var decodedProfile = user_profile.UserProfileModel.fromJson(jsonRes);
          var profile = decodedProfile.results;

          String fullName = profile.first.name;
          String dateOfBirth = profile.first.dateOfBirth.toString();
          String gender = profile.first.gender;
          String nationality = profile.first.nationality ?? '';
          String maritalStatus = profile.first.maritalStatus ?? '';
          String residentialAddress = profile.first.city ?? '';
          String emailAddress = profile.first.email;
          String phoneNumber = profile.first.phoneNumber ?? '';

          bool isFieldFilled(String field) {
            return field.isNotEmpty;
          }

          int personalInfoProgress = [
            isFieldFilled(fullName),
            isFieldFilled(dateOfBirth),
            isFieldFilled(gender),
            isFieldFilled(nationality),
            isFieldFilled(maritalStatus),
          ].where((filled) => filled).length;

          int contactInfoProgress = [
            isFieldFilled(residentialAddress),
            isFieldFilled(emailAddress),
            isFieldFilled(phoneNumber),
          ].where((filled) => filled).length;

          int nationalIDProgress = [
            isFieldFilled(profile.first.identificationNumber ?? ''),
          ].where((filled) => filled).length;

          int employmentInfoProgress = [
            isFieldFilled(profile.first.employmentStatus),
            isFieldFilled(profile.first.employerName ?? ''),
            isFieldFilled(profile.first.employerPhone ?? ''),
            // isFieldFilled(profile.first.employerEmail ?? ''),
          ].where((filled) => filled).length;

          // Calculate the total progress across all sections
          int totalProgress = personalInfoProgress +
              contactInfoProgress +
              nationalIDProgress +
              employmentInfoProgress;

          return Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultPadding,
                    vertical: kDefaultPadding,
                  ),
                  child: ListView(
                    children: [
                      LinearPercentIndicator(
                        //leaner progress bar
                        animation: true,
                        animationDuration: 1000,
                        lineHeight: 20.0,
                        percent: (totalProgress / 12 * 100) / 100,
                        center: Text(
                          "${(totalProgress / 12 * 100).toStringAsFixed(0)}%",
                          style: const TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                        barRadius: const Radius.circular(10),

                        progressColor: Colors.blue[400],
                        backgroundColor: Colors.grey.withOpacity(.3),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              widget.saccoList.saccoProfilePicture,
                              width: 80,
                              height: 80,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.04,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.saccoList.saccoName,
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                Text(
                                  widget.saccoList.saccoMotto,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      ExpansionList(
                        profile: profile,
                        personalInfoProgress: personalInfoProgress,
                        contactInfoProgress: contactInfoProgress,
                        nationalIDProgress: nationalIDProgress,
                        employmentInfoProgress: employmentInfoProgress,
                        referralCode: referralCode,
                        accountPurpose: accountPurpose,
                        accessToken: widget.accessToken,
                        saccoId: widget.saccoList.saccoId.toString(),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.07,
                child: ElevatedButton(
                  onPressed: () async {
                    var res = await ApiServices.makeApplication(
                      accountPurpose.toLowerCase(),
                      widget.saccoList.saccoId.toString(),
                      widget.userId,
                      widget.accessToken,
                    );

                    var decodedJson = json.decode(res[0]);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ApplicationSubmissionSuccess(
                          saccoList: widget.saccoList,
                          applicationCode:
                              decodedJson['application_reference_number'],
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        0,
                      ),
                    ),
                  ),
                  child: Text(
                    'SUBMIT',
                    style: GoogleFonts.poppins(
                      color: white,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }
}

class ExpansionList extends StatefulWidget {
  final List<user_profile.Result> profile;
  final String saccoId;
  final String accessToken;
  final int personalInfoProgress;
  final int contactInfoProgress;
  final int nationalIDProgress;
  final int employmentInfoProgress;
  final TextEditingController referralCode;
  String accountPurpose;

  ExpansionList({
    super.key,
    required this.profile,
    required this.personalInfoProgress,
    required this.contactInfoProgress,
    required this.nationalIDProgress,
    required this.employmentInfoProgress,
    required this.referralCode,
    required this.accountPurpose,
    required this.saccoId,
    required this.accessToken,
  });

  @override
  State<ExpansionList> createState() => _ExpansionListState();
}

class _ExpansionListState extends State<ExpansionList> {
  Map<String, dynamic> message = {};

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          color: kBackgroundColor,
          child: ExpansionTile(
            title: Text(
              "Personal Information ( ${widget.personalInfoProgress}/5 )",
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.black38,
                fontWeight: FontWeight.w700,
              ),
            ),
            trailing: widget.personalInfoProgress == 5
                ? const Icon(
                    Icons.check, // Green tick icon
                    color: Colors.green,
                  )
                : const Icon(
                    Icons.close, // Red X icon
                    color: Colors.red,
                  ),
            children: [
              Container(
                color: Colors.white,
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 20,
                  left: 10,
                  right: 10,
                ),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Full Legal Name: ",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          widget.profile.first.name,
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Text(
                          "Date of Birth:",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          widget.profile.first.dateOfBirth == null
                              ? ""
                              : DateFormat("MM/dd/yyyy")
                                  .format(widget.profile.first.dateOfBirth!)
                                  .toString(),
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Text(
                          "Gender:",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          widget.profile.first.gender,
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Text(
                          "Nationality:",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          widget.profile.first.nationality ?? '',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Text(
                          "Marital Status: ",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          widget.profile.first.maritalStatus ?? '',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        final res = Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const UpdateProfile(),
                          ),
                        );

                        if (res == true) {
                          setState(() {});
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: black),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 4.0),
                          child: Text(
                            "Edit",
                            style: GoogleFonts.poppins(color: white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
        Card(
          color: kBackgroundColor,
          child: ExpansionTile(
            title: Text(
              "Contact Information ( ${widget.contactInfoProgress}/3 )",
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.black38,
                fontWeight: FontWeight.w700,
              ),
            ),
            trailing: widget.contactInfoProgress == 3
                ? const Icon(
                    Icons.check, // Green tick icon
                    color: Colors.green,
                  )
                : const Icon(
                    Icons.close, // Red X icon
                    color: Colors.red,
                  ),
            children: [
              Container(
                color: Colors.white,
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 20,
                  left: 10,
                  right: 10,
                ),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Residential Location: ",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          widget.profile.first.city ?? "",
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Text(
                          "Email Address: ",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          widget.profile.first.email ?? "",
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Text(
                          "Phone Number: ",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          widget.profile.first.phoneNumber ?? "",
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        final res = Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const UpdateProfile(),
                          ),
                        );

                        if (res == true) {
                          setState(() {});
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: black),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 4.0),
                          child: Text(
                            "Edit",
                            style: GoogleFonts.poppins(color: white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
        Card(
          color: kBackgroundColor,
          child: ExpansionTile(
            title: Text(
              "Identification Details ( ${widget.nationalIDProgress}/1 )",
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.black38,
                fontWeight: FontWeight.w700,
              ),
            ),
            trailing: widget.nationalIDProgress == 1
                ? const Icon(
                    Icons.check, // Green tick icon
                    color: Colors.green,
                  )
                : const Icon(
                    Icons.close, // Red X icon
                    color: Colors.red,
                  ),
            children: [
              Container(
                color: Colors.white,
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 20,
                  left: 10,
                  right: 10,
                ),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Passport/Identification Number: ",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          widget.profile.first.identificationNumber ?? "",
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        final res = Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const UpdateProfile(),
                          ),
                        );

                        if (res == true) {
                          setState(() {});
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: black),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 4.0),
                          child: Text(
                            "Edit",
                            style: GoogleFonts.poppins(color: white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
        Card(
          color: kBackgroundColor,
          child: ExpansionTile(
            title: Text(
              "Employment Information  ( ${widget.employmentInfoProgress}/3 )",
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.black38,
                fontWeight: FontWeight.w700,
              ),
            ),
            trailing: widget.employmentInfoProgress == 3
                ? const Icon(
                    Icons.check, // Green tick icon
                    color: Colors.green,
                  )
                : const Icon(
                    Icons.close, // Red X icon
                    color: Colors.red,
                  ),
            children: [
              Container(
                color: Colors.white,
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 20,
                  left: 10,
                  right: 10,
                ),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Employment Status: ",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          widget.profile.first.employmentStatus,
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Text(
                          "Employer's Name: ",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          widget.profile.first.employerName ?? '',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Text(
                          "Employer's Contact: ",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          widget.profile.first.employerPhone ?? '',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        final res = Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const UpdateProfile(),
                          ),
                        );

                        if (res == true) {
                          setState(() {});
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: black),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 4.0),
                          child: Text(
                            "Edit",
                            style: GoogleFonts.poppins(color: white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
        Card(
          color: kBackgroundColor,
          child: ExpansionTile(
            title: Text(
              "Information about the source of funds being deposited or invested in the SACCO",
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.black38,
                fontWeight: FontWeight.w700,
              ),
            ),
            children: [
              Container(
                color: white,
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 20,
                  left: 10,
                  right: 10,
                ),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Purpose of Account",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: black,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: DropdownButton<String>(
                              isExpanded: true,
                              value: widget.accountPurpose,
                              underline: Container(
                                height: 1,
                                color: black.withOpacity(.3),
                              ),
                              items: <String>['Savings', 'Investments', 'Loans']
                                  .map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: GoogleFonts.poppins(
                                      fontSize: 13,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  widget.accountPurpose = newValue!;
                                });
                              }),
                        )
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    TextField(
                      controller: widget.referralCode,
                      onChanged: (value) async {
                        if (value.isEmpty) {
                          setState(() {
                            message = {};
                          });
                        } else {
                          var res = await ApiServices.validateReferalCode(
                            widget.accessToken,
                            widget.saccoId,
                            value.trim().toString(),
                          );
                          var decodedJson = json.decode(res[1]);

                          setState(() {
                            message = decodedJson;
                          });
                        }
                      },
                      decoration: InputDecoration(
                        labelText: "Referral Code",
                        labelStyle: GoogleFonts.poppins(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w400,
                          color: black,
                        ),
                      ),
                    ),
                    message.isNotEmpty
                        ? message.containsKey("error")
                            ? Text(
                                message['error'],
                                style: GoogleFonts.poppins(
                                  color: Colors.red[700],
                                  fontSize: 12,
                                ),
                              )
                            : Text(
                                message['message'],
                                style: GoogleFonts.poppins(
                                  color: Colors.green[700],
                                  fontSize: 12,
                                ),
                              )
                        : const SizedBox.shrink()
                  ],
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
      ],
    );
  }
}
