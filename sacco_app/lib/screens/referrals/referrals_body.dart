import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sacco_app/api_services.dart';
import 'package:sacco_app/constants.dart';
import 'package:sacco_app/models/my_referrals_model.dart';
import 'package:sacco_app/models/sacco_details_model.dart';
import 'package:sacco_app/models/user_referrals.dart';
import 'package:sacco_app/user_secure_storage.dart';
import 'package:share_plus/share_plus.dart';

class ReferralsBody extends StatefulWidget {
  const ReferralsBody({super.key});

  @override
  State<ReferralsBody> createState() => _ReferralsBodyState();
}

class _ReferralsBodyState extends State<ReferralsBody> {
  final List<String> items = [
    'Referral code',
    'Url link',
    // 'QR Code',
  ];

  String? selectedValue;
  String? selectedSaccoId;
  dynamic selectedSaccoValue;

  String accessToken = "accessToken";
  String userId = "userId";

  @override
  void initState() {
    super.initState();
    init();
  }

  Future init() async {
    final accessToken =
        await UserSecureStorage.getAccessToken() ?? "accessToken";
    final userId = await UserSecureStorage.getUserId() ?? "userId";

    setState(() {
      this.accessToken = accessToken;
      this.userId = userId;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(selectedSaccoValue);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: white,
        appBar: TabBar(
          indicatorColor: Colors.black,
          tabs: [
            Tab(
              child: Text(
                "Refer a Friend",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: black,
                ),
              ),
            ),
            Tab(
              child: Text(
                "My Referrals",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: black,
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: kDefaultPadding,
            horizontal: kDefaultPadding,
          ),
          child: TabBarView(
            children: [
              Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Choose Sacco",
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                FutureBuilder(
                                  future: ApiServices.getMemberSaccos(
                                      accessToken, userId),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.none) {
                                      return const Text('No data Found');
                                    } else if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                          child: CircularProgressIndicator
                                              .adaptive());
                                    }

                                    var data = snapshot.data;

                                    var jsonRes = json.decode(data![1]);

                                    var decodedSaccos =
                                        SaccoDetailsModel.fromJson(jsonRes);
                                    var memberSaccos = decodedSaccos.results;
                                    if (memberSaccos.isEmpty) {
                                      return Center(
                                        child: Text(
                                          "Not a member of any Sacco",
                                          style: GoogleFonts.poppins(
                                            fontSize: 13,
                                          ),
                                        ),
                                      );
                                    }

                                    return DropdownButtonHideUnderline(
                                      child: DropdownButton2(
                                        isExpanded: true,
                                        hint: Text(
                                          'Select Sacco',
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        items: memberSaccos
                                            .map((dynamic item) =>
                                                DropdownMenuItem<dynamic>(
                                                  value: item,
                                                  child: Text(
                                                    item.saccoName,
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 12,
                                                      color: black,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ))
                                            .toList(),
                                        value: selectedSaccoValue,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedSaccoId =
                                                value.saccoId.toString();
                                            selectedSaccoValue =
                                                value.saccoName.toString();
                                          });
                                        },
                                        buttonStyleData: ButtonStyleData(
                                          height: 50,
                                          width: 160,
                                          padding: const EdgeInsets.only(
                                              left: 14, right: 14),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(14),
                                            border: Border.all(
                                              color: Colors.black26
                                                  .withOpacity(.3),
                                            ),
                                            color: textFieldColor,
                                          ),
                                          elevation: 2,
                                        ),
                                        iconStyleData: const IconStyleData(
                                          icon: Icon(
                                            Icons.arrow_drop_down,
                                          ),
                                          iconSize: 24,
                                          iconEnabledColor: black,
                                          iconDisabledColor: Colors.grey,
                                        ),
                                        dropdownStyleData: DropdownStyleData(
                                          maxHeight: 200,
                                          width: 200,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(14),
                                            // color: Colors.redAccent,
                                          ),
                                          offset: const Offset(-20, 0),
                                          scrollbarTheme: ScrollbarThemeData(
                                            radius: const Radius.circular(40),
                                            thickness:
                                                MaterialStateProperty.all(6),
                                            thumbVisibility:
                                                MaterialStateProperty.all(true),
                                          ),
                                        ),
                                        menuItemStyleData:
                                            const MenuItemStyleData(
                                          height: 40,
                                          padding: EdgeInsets.only(
                                              left: 14, right: 14),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "Choose Referral Method",
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                DropdownButtonHideUnderline(
                                  child: DropdownButton2<String>(
                                    isExpanded: true,
                                    hint: Text(
                                      'Select referral method',
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    items: items
                                        .map((String item) =>
                                            DropdownMenuItem<String>(
                                              value: item,
                                              child: Text(
                                                item,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  color: black,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ))
                                        .toList(),
                                    value: selectedValue,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedValue = value!;
                                      });
                                      String newNormalisedString =
                                          value == "Referral Code"
                                              ? "code"
                                              : "link";
                                      ApiServices.createReferralCode(
                                          newNormalisedString,
                                          selectedSaccoId!,
                                          userId,
                                          accessToken);
                                    },
                                    buttonStyleData: ButtonStyleData(
                                      height: 50,
                                      width: 160,
                                      padding: const EdgeInsets.only(
                                          left: 14, right: 14),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        border: Border.all(
                                          color: Colors.black26.withOpacity(.3),
                                        ),
                                        color: textFieldColor,
                                      ),
                                      elevation: 2,
                                    ),
                                    iconStyleData: const IconStyleData(
                                      icon: Icon(
                                        Icons.arrow_drop_down,
                                      ),
                                      iconSize: 24,
                                      iconEnabledColor: black,
                                      iconDisabledColor: Colors.grey,
                                    ),
                                    dropdownStyleData: DropdownStyleData(
                                      maxHeight: 200,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        // color: Colors.redAccent,
                                      ),
                                      offset: const Offset(-20, 0),
                                      scrollbarTheme: ScrollbarThemeData(
                                        radius: const Radius.circular(40),
                                        thickness: MaterialStateProperty.all(6),
                                        thumbVisibility:
                                            MaterialStateProperty.all(true),
                                      ),
                                    ),
                                    menuItemStyleData: const MenuItemStyleData(
                                      height: 40,
                                      padding:
                                          EdgeInsets.only(left: 14, right: 14),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        selectedValue == "Referral code"
                            ? GestureDetector(
                                onTap: () {
                                  Clipboard.setData(ClipboardData(text: ""))
                                      .then((_) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Code Copied to your clipboard !',
                                          style: GoogleFonts.poppins(),
                                        ),
                                      ),
                                    );
                                  });
                                },
                                child: Container(
                                  height: 120,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        const Spacer(),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "AZSV123",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 28),
                                            ),
                                            Text(
                                              "Tap to copy",
                                              style: GoogleFonts.poppins(
                                                fontSize: 13,
                                                color: Colors.blue[300],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        const Icon(
                                          Icons.copy,
                                          size: 28,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : selectedValue == "Url link"
                                ? GestureDetector(
                                    onTap: () {
                                      Clipboard.setData(ClipboardData(text: ""))
                                          .then((_) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Link Copied to your clipboard !',
                                              style: GoogleFonts.poppins(),
                                            ),
                                          ),
                                        );
                                      });
                                    },
                                    child: Container(
                                      height: 120,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            const Spacer(),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.7,
                                                  child: Text(
                                                    "http://sacco.com/referral/AZSV123",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 18),
                                                    maxLines: 2,
                                                  ),
                                                ),
                                                Text(
                                                  "Tap to copy",
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 13,
                                                    color: Colors.blue[300],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Spacer(),
                                            const Icon(
                                              Icons.copy,
                                              size: 28,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                : Center(
                                    child: Text(
                                      "Kindly select a sacco and a method you want to use to send a referral",
                                      textAlign: TextAlign.center,
                                      style:
                                          GoogleFonts.poppins(fontSize: 12.5),
                                    ),
                                  ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      //share_plus requires iPad users to provide the sharePositionOrigin parameter
                      final box = context.findRenderObject() as RenderBox?;
                      Share.share(
                        "🎉 Join Our Sacco Community! 🤝\nHey there!\nI'm excited to invite you to join our Sacco - [Sacco Name]. It's an amazing platform where you can save, invest, and access financial services with ease.\nTo get started, use my referral code: [Your Referral Code]\n👉 [Link to Download the App or Register]\nHere's how to use the code:\n1. Download the [Sacco App/Visit Our Website]\n2. Sign up for a new account.\n3. During registration, enter my referral code: [Your Referral Code].\nThat's it! You're now part of our Sacco family and on your way to financial success. 🚀",
                        sharePositionOrigin:
                            box!.localToGlobal(Offset.zero) & box.size,
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 50.0,
                      width: size.width * 0.8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: black,
                      ),
                      padding: const EdgeInsets.all(0),
                      child: Text(
                        "SHARE",
                        style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: const Color.fromRGBO(255, 255, 255, 1)),
                      ),
                    ),
                  ),
                ],
              ),
              FutureBuilder(
                future: ApiServices.getMyReferrals(accessToken, userId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.none) {
                    return const Text('No data Found');
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator.adaptive());
                  }

                  var data = snapshot.data;

                  var jsonRes = json.decode(data![1]);

                  var decodedReferrals = MyReferralsModel.fromJson(jsonRes);
                  var memberSaccos = decodedReferrals.results;
                  if (memberSaccos.isEmpty) {
                    return Center(
                      child: Text(
                        "No referrals found",
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: decodedReferrals.results.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 8, right: 8, bottom: 20),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 8,
                                blurRadius: 8,
                                // changes position of shadow
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          color: black.withOpacity(0.3),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Center(
                                        child: Image.network(
                                          decodedReferrals.results[index]
                                              .referreeProfilePicture,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          decodedReferrals
                                              .results[index].referreeName,
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          decodedReferrals
                                              .results[index].referredSaccoName,
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                Text(
                                  decodedReferrals
                                      .results[index].referralMethod,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
