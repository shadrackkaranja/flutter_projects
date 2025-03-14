
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_app/components/bottom_nav_bar.dart';
import 'package:my_app/components/sacco_list.dart';
import 'package:my_app/utils/colors.dart';

import '../../components/search_box.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Image(
                            image: AssetImage("assets/images/logo-4.PNG"),
                          width: 200,
                        ),
                        IconButton(
                          icon: SvgPicture.asset(
                            "assets/icons/menu.svg",
                          ),
                            onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.accessibility_new,
                        ),
                        Text(
                          "Information SACCO",
                          style: TextStyle(
                            color: kHeadingFontColor,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 40, horizontal: 30),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'SACCO APP Made\n',
                            style: TextStyle(
                              fontFamily: 'RobotoMono',
                              fontSize: 34,
                              fontWeight: FontWeight.w900,
                            ),

                          ),
                          TextSpan(
                            text: 'By Users',
                            style: TextStyle(
                              fontFamily: 'RobotoMono',
                              fontSize: 38,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          WidgetSpan(
                            child: SizedBox(width: 10),
                          ),
                          WidgetSpan(
                            child: Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                image: const DecorationImage(
                                    image: AssetImage(
                                        "assets/images/pexels-2.jpg"),
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ),
                          WidgetSpan(
                            child: Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/pexels-1.jpg"),
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ),
                          TextSpan(
                            text: '\nFor the People',
                            style: TextStyle(
                              fontFamily: 'RobotoMono',
                              fontSize: 38,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  LookupSaccos(),
                  SearchBox(
                    onChanged: (value) {},
                  ),
                  FeaturedSaccos(),
                  SaccoList()
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

class LookupSaccos extends StatelessWidget {
  const LookupSaccos({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        children: [
          Text(
            "Search Saccos",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}

class FeaturedSaccos extends StatelessWidget {
  const FeaturedSaccos({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        children: [
          Text(
            "Featured Saccos",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
