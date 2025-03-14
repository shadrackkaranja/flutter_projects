import 'package:flutter/material.dart';
import 'package:movie_app/components/genre_card.dart';
import 'package:movie_app/constants.dart';

class Genres extends StatelessWidget {
  const Genres({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> genres = [
      "Action",
      "Crime",
      "Comedy",
      "Drama",
      "Horror",
      "Animation"
    ];
    return Container(
      height: 36,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: genres.length,
        itemBuilder: (context, index) => GenreCard(genre: genres[index]),
      ),
    );
  }
}