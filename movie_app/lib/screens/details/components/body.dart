import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/components/genre_card.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/screens/details/components/backdrop_rating.dart';
import 'package:movie_app/screens/details/components/cast_and_crew.dart';
import 'package:movie_app/screens/details/components/genres.dart';
import 'package:movie_app/screens/details/components/title_duration_and_fav_btn.dart';

class Body extends StatelessWidget {
  final Movie movie;
  const Body({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          BackDropAndRating(size: size, movie: movie),
          SizedBox(height: kDefaultPadding/2),
          TitleDurationAndFabBtn(movie: movie),
          Genres(movie: movie),
          Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding,
                  vertical: kDefaultPadding / 2
              ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Plot Summary",
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Text(
              movie.plot,
              style: TextStyle(
                color: Color(0xFF727599),
              ),
            ),
          ),
          CastAndCrew(casts: movie.cast),
        ],
      ),
    );
  }
}












