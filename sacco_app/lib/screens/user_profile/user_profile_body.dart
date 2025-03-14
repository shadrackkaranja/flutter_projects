import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sacco_app/api_services.dart';
import 'package:sacco_app/constants.dart';
import 'package:sacco_app/models/user_profile.dart';
import 'package:sacco_app/screens/authentication/login.dart';
import 'package:sacco_app/screens/user_profile/components/profile_menu.dart';
import 'package:sacco_app/screens/user_profile/my_account.dart';
import 'package:sacco_app/user_secure_storage.dart';

class UserProfileBody extends StatefulWidget {
  const UserProfileBody({super.key});

  @override
  State<UserProfileBody> createState() => _UserProfileBodyState();
}

class _UserProfileBodyState extends State<UserProfileBody> {
  String accessToken = "accessToken";
  String userId = "userId";
  String name = "name";

  @override
  void initState() {
    super.initState();
    init();
  }

  Future init() async {
    final username = await UserSecureStorage.getName() ?? "username";
    final accessToken =
        await UserSecureStorage.getAccessToken() ?? "accessToken";
    final userId = await UserSecureStorage.getUserId() ?? "userId";

    setState(() {
      this.accessToken = accessToken;
      this.userId = userId;

      name = username;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.25,
            child: Stack(
              children: [
                ClipPath(
                  clipper: CustomShape(),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.18,
                    color: kPrimaryColor,
                  ),
                ),
                FutureBuilder(
                    future: ApiServices.getUserProfile(accessToken, userId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.none) {
                        return const Text('No data Found');
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                            child: CircularProgressIndicator.adaptive());
                      }

                      var data = snapshot.data;

                      var jsonRes = json.decode(data![1]);

                      var decodedProfile = UserProfileModel.fromJson(jsonRes);
                      var profile = decodedProfile.results;

                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                bottom: kDefaultPadding / 2,
                              ),
                              height: MediaQuery.of(context).size.height * 0.15,
                              width: MediaQuery.of(context).size.width * 0.3,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: white,
                                  width:
                                      MediaQuery.of(context).size.width * 0.015,
                                ),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    profile.first.profilePicture,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Text(
                              profile.first.name,
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                color: black,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              profile.first.email,
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                color: black,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ],
            ),
          ),
        ),
        ProfileMenu(
          text: "My Account",
          icon: "assets/icons/User Icon.svg",
          press: () => {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyAccount(
                    accessToken: accessToken,
                    userId: userId,
                  ),
                ))
          },
        ),
        ProfileMenu(
          text: "Notifications",
          icon: "assets/icons/Bell.svg",
          press: () {},
        ),
        ProfileMenu(
          text: "Settings",
          icon: "assets/icons/Settings.svg",
          press: () {},
        ),
        ProfileMenu(
          text: "Help Center",
          icon: "assets/icons/Question mark.svg",
          press: () {},
        ),
        ProfileMenu(
          text: "Log Out",
          icon: "assets/icons/Log out.svg",
          press: () {
            Navigator.pushAndRemoveUntil<void>(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const Login(),
              ),
              (Route<dynamic> route) => false,
            );
          },
        ),
      ],
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
