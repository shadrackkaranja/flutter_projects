import 'package:flutter/material.dart';
import 'package:movie_app/constants.dart';

class GenreCard extends StatelessWidget {
  final String genre;
  const GenreCard({super.key, required this.genre});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: kDefaultPadding),
      padding: EdgeInsets.symmetric(
        vertical: kDefaultPadding/4,
        horizontal: kDefaultPadding,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black26),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        genre,
        style: TextStyle(
            color: kTextColor.withOpacity(0.8),
            fontSize: 16
        ),
      ),
    );
  }
}