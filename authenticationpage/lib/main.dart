import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json, base64, ascii;

import 'credentials.dart';

const SERVER_IP = 'http://167.71.105.115:8000/api';
final storage = FlutterSecureStorage();

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  Future<String> get jwtOrEmpty async {
    var jwt = await storage.read(key: "jwt");
    var full_name = await storage.read(key: "full_name");

    if(jwt == null) return "";
    return jwt;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Authentication Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
          future: jwtOrEmpty,
          builder: (context, snapshot) {
            if(!snapshot.hasData) return const CircularProgressIndicator();
            if(snapshot.data != "") {
              var str = snapshot.data;
              var jwt = str?.toString().split(".");
              if(jwt?.length !=3) {
                return LoginPage();
              } else {
                var payload = json.decode(ascii.decode(base64.decode(base64.normalize(jwt![1]))));
                if(DateTime.fromMillisecondsSinceEpoch(payload["exp"]*1000).isAfter(DateTime.now())) {
                  return HomePage(str.toString(), payload);
                } else {
                  return LoginPage();
                }
              }
            } else {
              return LoginPage();
            }
          }
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  void displayDialog(context, title, text) => showDialog(
    context: context,
    builder: (context) =>
        AlertDialog(
            title: Text(title),
            content: Text(text)
        ),
  );

  Future<String?> attemptLogIn(String email, String password) async {
    var res = await http.post(
        Uri.parse("$SERVER_IP/user/login/"),
        body: {
          "email": email,
          "password": password
        }
    );
    if(res.statusCode == 200) return res.body;
    return null;
  }

  Future<int> attemptSignUp(String fullName, String email, String phoneNumber, String password) async {
    var res = await http.post(
        Uri.parse('$SERVER_IP/user/register/'),
        body: {
          "full_name": fullName,
          "phone_number": phoneNumber,
          "email": email,
          "password": password
        }
    );
    return res.statusCode;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Log In"),),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _fullnameController,
                decoration: InputDecoration(
                    labelText: 'Full Name'
                ),
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                    labelText: 'Email'
                ),
              ),
              TextField(
                controller: _phoneNumberController,
                decoration: InputDecoration(
                    labelText: 'Phone Number'
                ),
              ),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    labelText: 'Password'
                ),
              ),
              FlatButton(
                  onPressed: () async {
                    var email = _emailController.text;
                    var password = _passwordController.text;
                    var jwt = await attemptLogIn(email, password);
                    final jsonResponse = json.decode(jwt!);
                    Credentials credentials = Credentials.fromJson(jsonResponse);

                    if (kDebugMode) {
                      //print(jwt);
                      print(credentials.data.tokens.access);
                    }
                    var accessToken = credentials.data.tokens.access;
                    var full_name = credentials.data.full_name;
                    if(accessToken != null) {
                      storage.write(key: "jwt", value: accessToken);
                      storage.write(key: "full_name", value: full_name);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomePage.fromBase64(accessToken)
                          )
                      );
                    } else {
                      displayDialog(context, "An Error Occurred", "No account was found matching that fullName and password");
                    }
                  },
                  child: Text("Log In")
              ),
              FlatButton(
                  onPressed: () async {
                    var fullName = _fullnameController.text;
                    var email = _emailController.text;
                    var phoneNumber = _phoneNumberController.text;
                    var password = _passwordController.text;

                    if(fullName.length < 4)
                      displayDialog(context, "Invalid Username", "The fullName should be at least 4 characters long");
                    else if(password.length < 4)
                      displayDialog(context, "Invalid Password", "The password should be at least 4 characters long");
                    else{
                      var res = await attemptSignUp(fullName,email,phoneNumber, password);
                      if(res == 201)
                        displayDialog(context, "Success", "The user was created. Log in now.");
                      else if(res == 409)
                        displayDialog(context, "That fullName is already registered", "Please try to sign up using another fullName or log in if you already have an account.");
                      else {
                        displayDialog(context, "Error", "An unknown error occurred.");
                      }
                    }
                  },
                  child: Text("Sign Up")
              )
            ],
          ),
        )
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage(this.jwt, this.payload);

  factory HomePage.fromBase64(String jwt) =>
      HomePage(
          jwt,
          json.decode(
              ascii.decode(
                  base64.decode(base64.normalize(jwt.split(".")[1]))
              )
          )
      );

  final String jwt;
  final Map<String, dynamic> payload;

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        appBar: AppBar(title: const Text("Secret Data Screen")),
        body: Center(
          child: FutureBuilder(
              future: http.read(Uri.parse('$SERVER_IP/churches/?page=1'), headers: {"Authorization": "JWT "+jwt}),
              builder: (context, snapshot) =>
              snapshot.hasData ?
              Column(children: <Widget>[
                Text("${payload['full_name']}, here's the data:"),
                Text(snapshot.data.toString(), style: Theme.of(context).textTheme.headline4)
              ],)
                  :
              snapshot.hasError ? const Text("An error occurred") : const CircularProgressIndicator()
          ),
        ),
      );
}
