import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sacco_app/api_services.dart';
import 'package:sacco_app/constants.dart';
import 'package:sacco_app/environment.dart';
import 'package:sacco_app/models/login_credentials.dart';
import 'package:sacco_app/screens/authentication/sign_up.dart';
import 'package:sacco_app/screens/home/home_page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../user_secure_storage.dart';

const storage = FlutterSecureStorage();

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  var isDeviceConnected = false;
  var subscription;

  bool isChecked = false;

  bool isLoading = false;
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

    init();

    setState(() {
      isLoading = false;
    });
  }

  Future init() async {
    await UserSecureStorage.setAccessToken("");
    await UserSecureStorage.setRefreshToken("");
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.black26;
    }

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBackgroundColor,
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
                  "Login",
                  style: GoogleFonts.poppins(
                    fontSize: 40,
                    fontWeight: FontWeight.w400,
                    foreground: Paint()
                      ..shader = const LinearGradient(
                        colors: <Color>[
                          Color.fromRGBO(241, 162, 162, 1),
                          Color.fromRGBO(145, 61, 159, 1),
                        ],
                      ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 100.0)),
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: size.height * 0.13),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 40),
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
                  controller: _emailController,
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
                    labelText: "Email Address",
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
                  controller: _passwordController,
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
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
                height: size.height * 0.05,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding * 1.4,
                ),
                child: Row(
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      fillColor: MaterialStateProperty.resolveWith(getColor),
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                    ),
                    Text(
                      "Remember Me",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        color: Color.fromRGBO(0, 0, 0, 1).withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.07,
              ),
              Center(
                child: Text(
                  "FORGOT PASSWORD?",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.08,
              ),
              Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          5.0,
                        ),
                      ),
                    ),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.all(0),
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (kIsWeb) {
                        setState(() {
                          isLoading = true;
                        });
                        saveData();
                      } else {
                        setState(() {
                          isLoading = true;
                        });
                        saveData();
                        // bool result =
                        //     await InternetConnectionChecker().hasConnection;
                        // if (result == true) {
                        //   setState(() {
                        //     isLoading = true;
                        //   });
                        //   saveData();
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
                  child: Container(
                    alignment: Alignment.center,
                    height: 50.0,
                    width: size.width * 0.8,
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

                            "LOGIN",
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: const Color.fromRGBO(255, 255, 255, 1)),
                          ),

                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.06,
              ),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: "Don't have an account?",
                    style: GoogleFonts.poppins(
                      color: black,
                      fontSize: 12,
                    ),
                    children: [
                      TextSpan(
                          text: " SIGN UP",
                          style: GoogleFonts.poppins(
                            color: const Color.fromRGBO(189, 123, 123, 1),
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignUp(),
                                ),
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

  saveData() async {
    var email = _emailController.text.trim();
    var password = _passwordController.text.trim();
    var response = await ApiServices.attemptLogIn(email, password);
    var statusCode = response[1]!;

    if (statusCode == 200) {
      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green[300],
          behavior: SnackBarBehavior.floating,
          content: Text(
            'Login Successful.',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              color: black,
            ),
          ),
          duration: const Duration(seconds: 2),
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
    } else if (statusCode == 401) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red[200],
          content: Text(
            'Invalid username or password.',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              color: black,
            ),
          ),
          duration: const Duration(seconds: 3),
        ),
      );
    } else if (statusCode == 500) {
      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red[200],
          content: Text(
            'Something went wrong.',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              color: black,
            ),
          ),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }
}
