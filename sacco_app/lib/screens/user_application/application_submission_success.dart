import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sacco_app/constants.dart';
import 'package:sacco_app/models/sacco_details_model.dart';
import 'package:sacco_app/screens/home/home_page.dart';

class ApplicationSubmissionSuccess extends StatelessWidget {
  final Result saccoList;
  final String applicationCode;
  const ApplicationSubmissionSuccess(
      {super.key, required this.saccoList, required this.applicationCode});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil<void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const HomePage(),
          ),
          (Route<dynamic> route) => false,
        );

        // Return false to prevent the default back button behavior
        // Return true if you want to allow the default back button behavior
        return false;
      },
      child: Scaffold(
        backgroundColor: white,
        body: ApplicationSubmissionSuccessBody(
          saccoList: saccoList,
          applicationCode: applicationCode,
        ),
        bottomNavigationBar: const BottomBarToHome(),
      ),
    );
  }
}

class ApplicationSubmissionSuccessBody extends StatelessWidget {
  final Result saccoList;
  final String applicationCode;
  const ApplicationSubmissionSuccessBody(
      {super.key, required this.saccoList, required this.applicationCode});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: kDefaultPadding * 2,
        horizontal: kDefaultPadding / 2,
      ),
      child: ListView(
        children: [
          const Center(
            child: Image(
              width: 200,
              height: 200,
              image: AssetImage(
                "assets/images/success.png",
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.07,
          ),
          Text(
            "Application Submitted Successfully!",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.w400,
              foreground: Paint()
                ..shader = const LinearGradient(
                  colors: <Color>[
                    Color.fromRGBO(241, 162, 162, 1),
                    Color.fromRGBO(145, 61, 159, 1),
                  ],
                ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 100.0)),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.06,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding * 2,
            ),
            child: Text(
              textAlign: TextAlign.center,
              "Your application is under review. We'll notify you via email about the next steps within 7-10 business days.",
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          // SizedBox(
          //   height: size.height * 0.04,
          // ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(
          //     horizontal: kDefaultPadding * 2,
          //   ),
          //   child: Text(
          //     textAlign: TextAlign.center,
          //     "A confirmation email with your submitted details has been sent to your registered email address.",
          //     style: GoogleFonts.poppins(
          //       fontSize: 12,
          //       fontWeight: FontWeight.w400,
          //     ),
          //   ),
          // ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding * 2,
            ),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'Your Application Reference Number is: ',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700,
                  color: black,
                  fontSize: 12,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: applicationCode,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class BottomBarToHome extends StatelessWidget {
  const BottomBarToHome({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      height: size.height * 0.07,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil<void>(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => const HomePage(),
            ),
            (Route<dynamic> route) => false,
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
          'BACK HOME',
          style: GoogleFonts.poppins(
            color: white,
            fontWeight: FontWeight.w700,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
