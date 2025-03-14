import 'package:budget_app/json/activity_json.dart';
import 'package:budget_app/pages/your_balance_page.dart';
import 'package:budget_app/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: getBody(),
    );
  }
  Widget getBody (){
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 350,
            child: Stack(
              children: [
                appBarCurve(),
                appBarBalance(),
              ],
            ),
          ),
          const SizedBox(height: 35,),
          getActivity(),
          SizedBox(height: 35,),
          getVerification(),
          SizedBox(height: 35,),
          getNewsPromo(),
          SizedBox(height: 100,),
        ],
      ),

    );
  }
  Widget appBarCurve() {
    Size size = MediaQuery.of(context).size;
    return ClipPath(
      clipper: OvalBottomBorderClipper(),
        child: Container(
          width: size.width,
          height: size.height * 0.25,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  primary,
                  secondary
                ],
            ),
            boxShadow: [
              BoxShadow(
                color: bgColor.withOpacity(0.1),
                spreadRadius: 10,
                blurRadius: 10,
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
            child: SafeArea(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_) => YourBalancePage()));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "\$",
                              style: TextStyle(
                                fontSize: 22,
                                color: white,
                              ),
                            ),
                            Text(
                              "1,752",
                              style: TextStyle(
                                fontSize: 30,
                                color: white,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          "Available Balance",
                          style: TextStyle(
                            color: white.withOpacity(0.8)
                          ),
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(image: NetworkImage("https://plus.unsplash.com/premium_photo-1675034393497-86e6970d2f49?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=500&q=60",
                           ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 35,
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: white,
                            border: Border.all(color: primary)
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),

        )
    );

  }

  Widget appBarBalance() {
    var size = MediaQuery.of(context).size;
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Container(
          width: size.width,
          height: 200,
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: black.withOpacity(0.01),
                  spreadRadius: 10,
                  blurRadius: 10,
                )
              ]
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 15,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Spent",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: black.withOpacity(0.5),
                                ),
                              ),
                              Text(
                                "\$1,460",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Flexible(
                      child: Row(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 15,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Earned",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: black.withOpacity(0.5),
                                ),
                              ),
                              Text(
                                "\$3,850",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15,),
                Divider(),
                SizedBox(height: 5,),
                Text(
                  "You Spent \$1,230 on dining out this month. Let's try to make it lower",
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.6,
                  ),
                ),
                SizedBox(height: 15,),
                Text(
                  "Tell me More",
                  style: TextStyle(
                    fontSize: 15,
                    color: primary,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getActivity() {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Activity",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 15,),
          Wrap(
            spacing: 25,
            children: List.generate(items.length, (index) {
              return Container(
                width: (size.width/3) -30,
                height: (size.width/3) -25,
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: black.withOpacity(0.015),
                      spreadRadius: 10,
                      blurRadius: 10,
                    ),
                  ]
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                            colors: [primary, secondary]
                        ),
                      ),
                      child: Center(
                          child: Icon(
                              items[index]['icon'],
                            color: white,
                            size: 20,
                          ),
                      ),
                    ),
                    const SizedBox(height: 15,),
                    Text(
                        items[index]['title'],
                      style: TextStyle(
                        fontSize: 13,
                        color: black.withOpacity(0.5),
                      ),
                    )
                  ],
                ),
              );
            }),
          )
        ],
      ),
    );
  }

  Widget getVerification() {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Complete Verification",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 15,),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: black.withOpacity(0.15),
                  spreadRadius: 10,
                  blurRadius: 10,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "60%",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "3 of 10 completed",
                        style: TextStyle(
                          fontSize: 13,
                          color: black.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15,),
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: black.withOpacity(0.04),
                        ),
                      ),
                      Container(
                        width: size.width * 0.5,
                        height: 8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: primary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15,),
                  Divider(),
                  SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        MaterialCommunityIcons.account,
                        color: primary,
                      ),
                      SizedBox(width: 20,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Personal Information",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 8,),
                          Text(
                            "We collect personal information",
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 12,),
                          Text("Continue", style: TextStyle(
                            fontSize: 15,
                            color: primary,
                            fontWeight: FontWeight.w600,
                           ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 10,),
                  Divider(),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Icon(
                        MaterialCommunityIcons.account_badge,
                        color: primary,
                      ),
                      SizedBox(width: 20,),
                      Text(
                        "Verification",
                        style: TextStyle(
                        fontSize: 15,
                        color: black,
                       ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Divider(),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Icon(
                        MaterialCommunityIcons.email,
                        color: primary,
                      ),
                      SizedBox(width: 20,),
                      Text(
                        "Confirm Email",
                        style: TextStyle(
                          fontSize: 15,
                          color: black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getNewsPromo() {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "News and Promo",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 15,),
          Container(
            width: size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: white,
              boxShadow: [
                BoxShadow(
                  color: black.withOpacity(0.015),
                  spreadRadius: 10,
                  blurRadius: 10,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 130,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage("assets/images/promo_news.png"),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Share and invite your friends",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 5,),
                      Text(
                        "Invite friends to register on our app. For every user you invite,you will earn up to \$10.",
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.6,
                        ),
                      ),
                      SizedBox(height: 12,),
                      Text(
                        "Invite Now",
                        style: TextStyle(
                          fontSize: 15,
                          color: primary,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
