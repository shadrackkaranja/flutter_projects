import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sacco_app/environment.dart';
import 'package:sacco_app/screens/authentication/login.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: Environment.fileName);
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print("${Environment.fileName}");
     SystemChrome.setSystemUIOverlayStyle(
      // ignore: prefer_const_constructors
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sacco App',
      theme: ThemeData(
        fontFamily: 'Axiforma'
      ),
      home: Login(),
    );
  }
}
