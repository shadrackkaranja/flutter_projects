import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sacco_app/constants.dart';
import 'package:sacco_app/screens/referrals/referrals_body.dart';

class Referrals extends StatelessWidget {
  const Referrals({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Refferals",
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: black,
            ),
          ),
        ),
      ),
      body: const ReferralsBody(),
    );
  }
}
