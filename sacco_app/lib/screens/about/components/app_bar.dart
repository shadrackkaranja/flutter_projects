import 'package:flutter/material.dart';
import 'package:sacco_app/constants.dart';

class getAppBar extends StatelessWidget {
  const getAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: white,
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back,
          size: 22,
          color: black,
        ),
      ),
    );
  }
}