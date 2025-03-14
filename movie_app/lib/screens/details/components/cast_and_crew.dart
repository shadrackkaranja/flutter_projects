import 'package:flutter/material.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/screens/details/components/body.dart';
import 'package:movie_app/screens/details/components/cast_card.dart';

class CastAndCrew extends StatelessWidget {
  final List casts;
  const CastAndCrew({super.key, required this.casts});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Cast and Crew",
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          SizedBox(height: kDefaultPadding / 2),
          SizedBox(
            height: 160,
            child: ListView.builder(
                itemCount: casts.length,
                itemBuilder: (context, index) => CastCard(cast: casts[index])),
          ),
        ],
      ),
    );
  }
}