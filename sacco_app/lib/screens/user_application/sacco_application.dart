import 'package:flutter/material.dart';
import 'package:sacco_app/constants.dart';
import 'package:sacco_app/models/sacco_details_model.dart';
import 'package:sacco_app/screens/user_application/application_body.dart';
import 'package:sacco_app/screens/user_application/components/app_bar.dart';

class SaccoApplication extends StatelessWidget {
  final Result saccoList;
  final String accessToken;
  final String userId;
  const SaccoApplication(
      {super.key,
      required this.saccoList,
      required this.userId,
      required this.accessToken});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(35),
        child: GetAppBar(),
      ),
      body: ApplicationBody(
        saccoList: saccoList,
        userId: userId,
        accessToken: accessToken,
      ),
    );
  }
}
