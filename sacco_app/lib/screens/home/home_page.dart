import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sacco_app/constants.dart';
import 'package:sacco_app/screens/application_status/application_status.dart';
import 'package:sacco_app/screens/home/home_body.dart';
import 'package:sacco_app/screens/referrals/referrals.dart';
import 'package:sacco_app/screens/user_profile/user_profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeBody(),
    ApplicationStatus(),
    Referrals(),
    UserProfile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        selectedLabelStyle: GoogleFonts.poppins(
          color: black,
          fontSize: 12,
        ),
        unselectedLabelStyle: GoogleFonts.poppins(
          color: Colors.grey,
          fontSize: 12,
        ),
        backgroundColor: white,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            activeIcon: Image.asset(
              AppStyle.homeIcon,
              color: Colors.black,
              scale: 17,
            ),
            icon: Image.asset(
              AppStyle.homeIcon,
              scale: 17,
              color: Colors.grey,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            activeIcon: Image.asset(
              AppStyle.applicationIcon,
              color: Colors.black,
              scale: 17,
            ),
            icon: Image.asset(
              AppStyle.applicationIcon,
              scale: 17,
              color: Colors.grey,
            ),
            label: 'Application',
          ),
          BottomNavigationBarItem(
            activeIcon: Image.asset(
              AppStyle.referalIcon,
              color: Colors.black,
              scale: 17,
            ),
            icon: Image.asset(
              AppStyle.referalIcon,
              scale: 17,
              color: Colors.grey,
            ),
            label: 'Referrals',
          ),
          BottomNavigationBarItem(
            activeIcon: Image.asset(
              AppStyle.userIcon,
              color: Colors.black,
              scale: 17,
            ),
            icon: Image.asset(
              AppStyle.userIcon,
              scale: 17,
              color: Colors.grey,
            ),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppStyle.primarySwatch,
        onTap: _onItemTapped,
      ),
    );
  }
}
