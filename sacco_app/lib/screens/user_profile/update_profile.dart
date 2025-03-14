import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sacco_app/api_services.dart';
import 'package:sacco_app/constants.dart';
import 'package:sacco_app/models/user_profile.dart';
import 'package:sacco_app/user_secure_storage.dart';
import 'package:intl/intl.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  String accessToken = "accessToken";
  String userId = "userId";
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final dobController = TextEditingController();
  final idNumberController = TextEditingController();
  final countryController = TextEditingController();
  final cityController = TextEditingController();
  final maritalStatusController = TextEditingController();
  final employmentStatusController = TextEditingController();
  final employmentNameController = TextEditingController();
  final employmentPhoneController = TextEditingController();
  final employmentEmailController = TextEditingController();
  String? profilePicFile;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future init() async {
    final accessToken =
        await UserSecureStorage.getAccessToken() ?? "accessToken";
    final userId = await UserSecureStorage.getUserId() ?? "userId";

    setState(() {
      this.accessToken = accessToken;
      this.userId = userId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Edit Profile",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context, true);
          },
          child: const Icon(Icons.arrow_back_ios_rounded),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: ApiServices.getUserProfile(accessToken, userId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.none) {
                  return const Text('No data Found');
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }

                var data = snapshot.data;

                var jsonRes = json.decode(data![1]);

                var decodedProfile = UserProfileModel.fromJson(jsonRes);
                var profile = decodedProfile.results;

                return Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.21,
                      child: Stack(
                        children: [
                          ClipPath(
                            clipper: CustomShape(),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.17,
                              color: kPrimaryColor,
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles(
                                type: FileType.image,
                              );

                              if (result != null) {
                                File file = File(result.files.first.path!);

                                setState(() {
                                  profilePicFile = file.path.toString();
                                });
                              } else {
                                // User canceled the picker
                              }
                            },
                            child: Center(
                              child: Stack(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                      bottom: kDefaultPadding / 2,
                                    ),
                                    height: MediaQuery.of(context).size.height *
                                        0.15,
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    decoration: profilePicFile == null ||
                                            profilePicFile == "null"
                                        ? BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: white,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.015,
                                            ),
                                            image: DecorationImage(
                                                image: NetworkImage(profile
                                                    .first.profilePicture),
                                                fit: BoxFit.cover),
                                          )
                                        : BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: white,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.015,
                                            ),
                                            image: DecorationImage(
                                              image: FileImage(
                                                  File(profilePicFile!)),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                  ),
                                  Positioned(
                                    bottom: 23,
                                    right: 0,
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: kPrimaryColor,
                                      ),
                                      child: const Icon(
                                        Icons.edit,
                                        color: white,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                        ),
                        child: ListView(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Name",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14.5,
                                  ),
                                ),
                                Stack(
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      decoration: BoxDecoration(
                                        color: kBackgroundColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    Positioned.fill(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: TextFormField(
                                          controller: nameController,
                                          keyboardType: TextInputType.text,
                                          style: GoogleFonts.poppins(
                                            fontSize: 13,
                                            color: black,
                                          ),
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                              horizontal: 10,
                                            ),
                                            hintText: profile.first.name,
                                            hintStyle: GoogleFonts.poppins(
                                              fontSize: 13,
                                              color: black,
                                            ),
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                            labelStyle: GoogleFonts.poppins(
                                              fontSize: 13,
                                              color: black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Email",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14.5,
                                  ),
                                ),
                                Stack(
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      decoration: BoxDecoration(
                                        color: kBackgroundColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    Positioned.fill(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: TextFormField(
                                          controller: emailController,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          style: GoogleFonts.poppins(
                                            fontSize: 13,
                                            color: black,
                                          ),
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                              horizontal: 10,
                                            ),
                                            hintText: profile.first.email,
                                            hintStyle: GoogleFonts.poppins(
                                              fontSize: 13,
                                              color: black,
                                            ),
                                            labelStyle: GoogleFonts.poppins(
                                              fontSize: 13,
                                              color: black,
                                            ),
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Phone Number",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14.5,
                                  ),
                                ),
                                Stack(
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      decoration: BoxDecoration(
                                        color: kBackgroundColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    Positioned.fill(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: TextFormField(
                                          controller: phoneController,
                                          keyboardType: TextInputType.number,
                                          style: GoogleFonts.poppins(
                                            fontSize: 13,
                                            color: black,
                                          ),
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                              horizontal: 10,
                                            ),
                                            hintText: profile.first.phoneNumber,
                                            hintStyle: GoogleFonts.poppins(
                                              fontSize: 13,
                                              color: black,
                                            ),
                                            labelStyle: GoogleFonts.poppins(
                                              fontSize: 13,
                                              color: black,
                                            ),
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Date of Birth",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14.5,
                                  ),
                                ),
                                Stack(
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      decoration: BoxDecoration(
                                        color: kBackgroundColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    Positioned.fill(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: TextFormField(
                                          controller: dobController,
                                          keyboardType: TextInputType.datetime,
                                          style: GoogleFonts.poppins(
                                            fontSize: 13,
                                            color: black,
                                          ),
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                              horizontal: 10,
                                            ),
                                            hintText: DateFormat("MM/dd/yyyy")
                                                .format(
                                                    profile.first.dateOfBirth)
                                                .toString(),
                                            hintStyle: GoogleFonts.poppins(
                                              fontSize: 13,
                                              color: black,
                                            ),
                                            labelStyle: GoogleFonts.poppins(
                                              fontSize: 13,
                                              color: black,
                                            ),
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Identification Number/Alien Number",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14.5,
                                  ),
                                ),
                                Stack(
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      decoration: BoxDecoration(
                                        color: kBackgroundColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    Positioned.fill(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: TextFormField(
                                          controller: idNumberController,
                                          keyboardType: TextInputType.text,
                                          style: GoogleFonts.poppins(
                                              fontSize: 13, color: black),
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                              horizontal: 10,
                                            ),
                                            hintText: profile
                                                .first.identificationNumber,
                                            hintStyle: GoogleFonts.poppins(
                                                fontSize: 13, color: black),
                                            labelStyle: GoogleFonts.poppins(
                                                fontSize: 13, color: black),
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Country",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14.5,
                                  ),
                                ),
                                Stack(
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      decoration: BoxDecoration(
                                        color: kBackgroundColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    Positioned.fill(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: TextFormField(
                                          controller: countryController,
                                          keyboardType: TextInputType.text,
                                          style: GoogleFonts.poppins(
                                            fontSize: 13,
                                            color: black,
                                          ),
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                              horizontal: 10,
                                            ),
                                            hintText: profile.first.country,
                                            hintStyle: GoogleFonts.poppins(
                                              fontSize: 13,
                                              color: black,
                                            ),
                                            labelStyle: GoogleFonts.poppins(
                                              fontSize: 13,
                                              color: black,
                                            ),
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "City",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14.5,
                                  ),
                                ),
                                Stack(
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      decoration: BoxDecoration(
                                        color: kBackgroundColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    Positioned.fill(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: TextFormField(
                                          controller: cityController,
                                          keyboardType: TextInputType.text,
                                          style: GoogleFonts.poppins(
                                            fontSize: 13,
                                            color: black,
                                          ),
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                              horizontal: 10,
                                            ),
                                            hintText: profile.first.city,
                                            hintStyle: GoogleFonts.poppins(
                                              fontSize: 13,
                                              color: black,
                                            ),
                                            labelStyle: GoogleFonts.poppins(
                                              fontSize: 13,
                                              color: black,
                                            ),
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Marital Status",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14.5,
                                  ),
                                ),
                                Stack(
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      decoration: BoxDecoration(
                                        color: kBackgroundColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    Positioned.fill(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: TextFormField(
                                          controller: maritalStatusController,
                                          keyboardType: TextInputType.text,
                                          style: GoogleFonts.poppins(
                                            fontSize: 13,
                                            color: black,
                                          ),
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                              horizontal: 10,
                                            ),
                                            hintText:
                                                profile.first.maritalStatus,
                                            hintStyle: GoogleFonts.poppins(
                                              fontSize: 13,
                                              color: black,
                                            ),
                                            labelStyle: GoogleFonts.poppins(
                                              fontSize: 13,
                                              color: black,
                                            ),
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Employment Status",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14.5,
                                  ),
                                ),
                                Stack(
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      decoration: BoxDecoration(
                                        color: kBackgroundColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    Positioned.fill(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: TextFormField(
                                          controller:
                                              employmentStatusController,
                                          keyboardType: TextInputType.text,
                                          style: GoogleFonts.poppins(
                                            fontSize: 13,
                                            color: black,
                                          ),
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                              horizontal: 10,
                                            ),
                                            hintText:
                                                profile.first.employmentStatus,
                                            hintStyle: GoogleFonts.poppins(
                                              fontSize: 13,
                                              color: black,
                                            ),
                                            labelStyle: GoogleFonts.poppins(
                                              fontSize: 13,
                                              color: black,
                                            ),
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Employer Name",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14.5,
                                  ),
                                ),
                                Stack(
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      padding: const EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                        color: kBackgroundColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    Positioned.fill(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: TextFormField(
                                          controller: employmentNameController,
                                          keyboardType: TextInputType.text,
                                          style: GoogleFonts.poppins(
                                            fontSize: 13,
                                            color: black,
                                          ),
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                              horizontal: 10,
                                            ),
                                            hintText:
                                                profile.first.employerName,
                                            hintStyle: GoogleFonts.poppins(
                                              fontSize: 13,
                                              color: black,
                                            ),
                                            labelStyle: GoogleFonts.poppins(
                                              fontSize: 13,
                                              color: black,
                                            ),
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Employer Phone",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14.5,
                                  ),
                                ),
                                Stack(
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      decoration: BoxDecoration(
                                        color: kBackgroundColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    Positioned.fill(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: TextFormField(
                                          controller: employmentPhoneController,
                                          keyboardType: TextInputType.phone,
                                          style: GoogleFonts.poppins(
                                            fontSize: 13,
                                            color: black,
                                          ),
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                              horizontal: 10,
                                            ),
                                            hintText:
                                                profile.first.employerPhone,
                                            hintStyle: GoogleFonts.poppins(
                                              fontSize: 13,
                                              color: black,
                                            ),
                                            labelStyle: GoogleFonts.poppins(
                                              fontSize: 13,
                                              color: black,
                                            ),
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Employer Email",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14.5,
                                  ),
                                ),
                                Stack(
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      decoration: BoxDecoration(
                                        color: kBackgroundColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    Positioned.fill(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: TextFormField(
                                          controller: employmentEmailController,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          style: GoogleFonts.poppins(
                                            fontSize: 13,
                                            color: black,
                                          ),
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                              horizontal: 10,
                                            ),
                                            hintText:
                                                profile.first.employerEmail,
                                            hintStyle: GoogleFonts.poppins(
                                              fontSize: 13,
                                              color: black,
                                            ),
                                            labelStyle: GoogleFonts.poppins(
                                              fontSize: 13,
                                              color: black,
                                            ),
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.07,
            child: ElevatedButton(
              onPressed: () {
                ApiServices.updateProfileDetails(
                  accessToken,
                  userId,
                  emailController.text,
                  nameController.text,
                  phoneController.text,
                  countryController.text,
                  cityController.text,
                  dobController.text,
                  idNumberController.text,
                  maritalStatusController.text,
                  employmentStatusController.text,
                  employmentNameController.text,
                  employmentPhoneController.text,
                  employmentEmailController.text,
                  profilePicFile,
                );
                Navigator.pop(context, true);
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
                'UPDATE',
                style: GoogleFonts.poppins(
                  color: white,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CustomShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    double height = size.height;
    double width = size.width;
    path.lineTo(0, height - 100);
    path.quadraticBezierTo(width / 2, height, width, height - 100);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
