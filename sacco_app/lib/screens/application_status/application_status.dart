import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sacco_app/constants.dart';
import 'package:sacco_app/screens/application_status/components/application_status_body.dart';

class ApplicationStatus extends StatelessWidget {
  const ApplicationStatus({super.key});

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
            "Applications Status",
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: black,
            ),
          ),
        ),
      ),
      body: const ApplicationStatusBody(),
    );
  }
}
