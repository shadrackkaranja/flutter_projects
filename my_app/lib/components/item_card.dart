import 'package:flutter/material.dart';

import '../utils/colors.dart';

class ItemCard extends StatelessWidget {
  final String imageSrc;
  final Function press;
  const ItemCard({
    super.key,
    required this.imageSrc,
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
        left: 20,
        right: 15,
        top: 20,
        bottom: 20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 20,
            color: Color(0xFFB0CCE1).withOpacity(0.32),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 15),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: kBackgroundColor.withOpacity(0.13),
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    imageSrc,
                    width: size.width * 0.35,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
