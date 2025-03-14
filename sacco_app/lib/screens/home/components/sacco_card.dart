import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sacco_app/constants.dart';
import 'package:sacco_app/models/sacco_details_model.dart';

class SaccoCard extends StatelessWidget {
  final Result allSacco;
  final VoidCallback press;

  const SaccoCard({
    super.key,
    required this.press,
    required this.allSacco,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: press,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            width: 1,
            color: black.withOpacity(0.1),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(
            kDefaultPadding / 2.5,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      "${allSacco.saccoProfilePicture}",
                      width: 75,
                      height: 75,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: Text(
                      allSacco.saccoName,
                      style: GoogleFonts.poppins(
                          fontSize: 15,
                          color: black,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.009,
              ),
              Text(
                "Motto: ${allSacco.saccoMotto}",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
              SizedBox(
                height: size.height * 0.0010,
              ),
              Flexible(
                child: Text(
                  "Address: ${allSacco.saccoAddress}",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    color: const Color.fromRGBO(77, 65, 215, 1),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
