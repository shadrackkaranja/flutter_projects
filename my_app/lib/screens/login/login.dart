// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:my_app/components/background.dart';
import 'package:my_app/screens/home/home_screen.dart';
import 'package:my_app/screens/login/sign_up.dart';
import 'package:my_app/utils/colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "LOGIN",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kHeadingFontColor,
                    fontSize: 36),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Username",
                ),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Password",
                ),
                obscureText: true,
              ),
            ),
            Row(
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: Text(
                    "Forgot your password?",
                    style: TextStyle(fontSize: 12, color: Color(0XFF2661FA)),
                  ),
                ),
                InkWell(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 12, color: Color(0XFF2661FA)),
                    ),
                  ),
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUp()),
                    )
                  },
                ),
              ],
            ),
            SizedBox(height: size.height * 0.05),
            Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 10,
              ),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        80.0,
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
                  width: size.width * 0.5,
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(80.0),
                    gradient: new LinearGradient(
                      colors: [
                        Color.fromARGB(255, 255, 136, 34),
                        Color.fromARGB(255, 255, 177, 41)
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.all(0),
                  child: Text(
                    "LOGIN",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
