import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sacco_app/constants.dart';

class GetAppBar extends StatelessWidget {
  const GetAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: white,
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context, true);
        },
        icon: const Icon(
          Icons.arrow_back_ios_rounded,
          size: 22,
          color: black,
        ),
      ),
      title: Text(
        "Make Application",
        style: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: black,
        ),
      ),
    );
  }
}
