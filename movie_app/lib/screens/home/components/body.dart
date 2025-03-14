import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_app/components/genre_card.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/screens/home/components/categories.dart';
import 'package:movie_app/screens/home/components/genres.dart';
import 'package:movie_app/screens/home/components/movie_card.dart';
import 'dart:math' as math;

import 'package:movie_app/screens/home/components/movie_carousel.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CategoryList(),
        Genres(),
        SizedBox(height: kDefaultPadding),
        MovieCarousel(),
      ],
    );
  }
}














