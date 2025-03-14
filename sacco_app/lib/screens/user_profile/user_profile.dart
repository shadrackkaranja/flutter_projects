import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sacco_app/constants.dart';
import 'package:sacco_app/screens/user_profile/update_profile.dart';
import 'package:sacco_app/screens/user_profile/user_profile_body.dart';
import 'package:sacco_app/user_secure_storage.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  String accessToken = "accessToken";
  String userId = "userId";

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
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Profile",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UpdateProfile(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: kPrimaryColor,
            ),
            child: Text(
              "Edit",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
      body: const UserProfileBody(),
    );
  }
}
