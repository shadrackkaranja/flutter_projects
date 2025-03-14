import 'package:flutter/material.dart';
import 'package:my_app/components/item_card.dart';

class SaccoList extends StatelessWidget {
  const SaccoList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          ItemCard(
            imageSrc: 'assets/images/safcom.png',
            press: () {},
          ),
          ItemCard(
            imageSrc: 'assets/images/MhasibuNewLogo.png',
            press: () {},
          ),
          ItemCard(
            imageSrc: 'assets/images/un-sacco.png',
            press: () {},
          ),
          ItemCard(
            imageSrc: 'assets/images/stima-sacco.png',
            press: () {},
          ),
        ],
      ),
    );
  }
}
