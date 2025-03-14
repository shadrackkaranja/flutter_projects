import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sacco_app/api_services.dart';
import 'package:sacco_app/constants.dart';

import 'package:sacco_app/models/login_credentials.dart';
import 'package:sacco_app/screens/authentication/login.dart';
import 'package:email_validator/email_validator.dart';
import 'package:sacco_app/screens/home/home_page.dart';
import 'package:sacco_app/user_secure_storage.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController nationalIdController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var isDeviceConnected = false;
  var subscription;

  bool isLoading = false;

  bool isChecked = false;

  final textFieldFocusNode = FocusNode();
  bool _obscured = true;

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus) {
        return; // If focus is on text field, dont unfocus
      }
      textFieldFocusNode.canRequestFocus =
      false; // Prevents focus if tap on eye
    });
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      isLoading = false;
    });
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: size.height * 0.15),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  "Sign Up",
                  style: GoogleFonts.poppins(
                      fontSize: 40,
                      fontWeight: FontWeight.w400,
                      foreground: Paint()
                        ..shader = const LinearGradient(
                          colors: <Color>[
                            Color.fromRGBO(241, 162, 162, 1),
                            Color.fromRGBO(145, 61, 159, 1),
                          ],
                        ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 100.0))),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: size.height * 0.1),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Full name cannot be empty';
                    }
                    return null;
                  },
                  controller: fullNameController,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    color: black,
                  ),
                  decoration: InputDecoration(
                    labelStyle: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(0, 0, 0, 1),
                      fontSize: 12,
                    ),
                    labelText: "Full Name",
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'National Id or Alien ID cannot be empty';
                    }
                    return null;
                  },
                  controller: nationalIdController,
                  keyboardType: TextInputType.number,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    color: black,
                  ),
                  decoration: InputDecoration(
                    labelStyle: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(0, 0, 0, 1),
                      fontSize: 12,
                    ),
                    labelText: "National ID / Alien ID",
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  validator: (value) {
                    if (value.toString().trim().isEmpty) {
                      return 'Email cannot be empty';
                    }
                    if (!EmailValidator.validate(value.toString().trim())) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  controller: emailAddressController,
                  keyboardType: TextInputType.emailAddress,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    color: black,
                  ),
                  decoration: InputDecoration(
                    labelStyle: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(0, 0, 0, 1),
                      fontSize: 12,
                    ),
                    labelText: "Email",
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password cannot be empty';
                    }
                    if (value.length < 8) {
                      return 'Password has to have at least 8 characters';
                    }
                    return null;
                  },
                  controller: passwordController,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    color: black,
                  ),
                  decoration: InputDecoration(
                    labelStyle: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(0, 0, 0, 1),
                      fontSize: 12,
                    ),
                    labelText: "Password",
                  ),
                  focusNode: textFieldFocusNode,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: _obscured,
                ),
              ),
              SizedBox(
                height: size.height * 0.15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding,
                ),
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            if (kIsWeb) {
                              setState(() {
                                isLoading = true;
                              });
                              signUp();
                            } else {
                              setState(() {
                                isLoading = true;
                              });
                              signUp();
                              // bool result = await InternetConnectionChecker()
                              //     .hasConnection;
                              // if (result == true) {
                              //   setState(() {
                              //     isLoading = true;
                              //   });
                              //   signUp();
                              // } else {
                              //   ScaffoldMessenger.of(context)
                              //       .showSnackBar(const SnackBar(
                              //     backgroundColor: kErrorColor,
                              //     content: Text(
                              //       "No internet connection ;(",
                              //       style: TextStyle(
                              //         fontFamily: 'Axiforma',
                              //         fontWeight: FontWeight.bold,
                              //         color: Colors.white,
                              //       ),
                              //     ),
                              //     duration: Duration(seconds: 3),
                              //   ));
                              // }
                            }
                          }
                        },
                        style: ButtonStyle(
                          shape:
                          MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                5.0,
                              ),
                            ),
                          ),
                          padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.all(0),
                          ),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          height: 50.0,
                          width: size.width * 0.7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: black,
                          ),
                          padding: const EdgeInsets.all(0),
                          child: isLoading
                              ? const Center(
                            child: CircularProgressIndicator.adaptive(),
                          )
                              : Text(
                                  "SIGN UP",
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                  ),
                                ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.02,
                    ),
                    Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        border: Border.all(color: black),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Image(image: AssetImage("assets/images/g.png")),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: "Already have an account?",
                    style: GoogleFonts.poppins(
                      color: black,
                      fontSize: 12,
                    ),
                    children: [
                      TextSpan(
                          text: " LOG IN",
                          style: GoogleFonts.poppins(
                            color: Color.fromRGBO(189, 123, 123, 1),
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()),
                              );
                            }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  signUp() async {
    var name = fullNameController.text;
    var nationalId = nationalIdController.text;
    var email = emailAddressController.text;
    var password = passwordController.text;
    var response =
    await ApiServices.attemptSignUp(name, nationalId, email, password);
    var statusCode = response[1]!;

    if (statusCode == 201) {
      var response = await ApiServices.attemptLogIn(email, password);
      var statusCode = response[1]!;

      if (statusCode == 200) {
        setState(() {
          isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: kErrorColor,
            content: Text(
              'Login Successful.',
              style: TextStyle(
                fontFamily: 'Axiforma',
                fontWeight: FontWeight.bold,
                color: black,
              ),
            ),
            duration: Duration(seconds: 2),
          ),
        );

        final jsonResponse = json.decode(response[0]!);
        LoginCredentials credentials = LoginCredentials.fromJson(jsonResponse);

        await UserSecureStorage.setName(credentials.name);
        await UserSecureStorage.setAccessToken(credentials.tokens.access);
        await UserSecureStorage.setRefreshToken(credentials.tokens.refresh);
        await UserSecureStorage.setEmail(credentials.email);
        await UserSecureStorage.setUserId(credentials.id);

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
                (Route<dynamic> route) => false);
      } else if (statusCode == 500) {
        setState(() {
          isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: kErrorColor,
            content: Text(
              'Something went wrong.',
              style: TextStyle(
                fontFamily: 'Axiforma',
                fontWeight: FontWeight.bold,
                color: black,
              ),
            ),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } else if (statusCode == 401) {
      setState(() {
        isLoading = false;
      });
    } else if (statusCode == 500) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: kErrorColor,
          content: Text(
            'Something went wrong.',
            style: TextStyle(
              fontFamily: 'Axiforma',
              fontWeight: FontWeight.bold,
              color: black,
            ),
          ),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }
}
