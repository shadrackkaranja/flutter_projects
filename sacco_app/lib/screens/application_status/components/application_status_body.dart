import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sacco_app/api_services.dart';
import 'package:sacco_app/constants.dart';
import 'package:sacco_app/models/sacco_applications_model.dart';
import 'package:sacco_app/user_secure_storage.dart';

class ApplicationStatusBody extends StatefulWidget {
  const ApplicationStatusBody({super.key});

  @override
  State<ApplicationStatusBody> createState() => _ApplicationStatusBodyState();
}

class _ApplicationStatusBodyState extends State<ApplicationStatusBody> {
  String _dropDownValue = 'All Applications';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(245, 245, 245, 1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
                bottom: 5,
                top: 5,
              ),
              child: DropdownButton(
                hint: Text(
                  _dropDownValue,
                  style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      color: black,
                      fontWeight: FontWeight.w300),
                ),
                isExpanded: true,
                iconSize: 30.0,
                underline: const SizedBox(),
                style: GoogleFonts.poppins(
                    fontSize: 12.5, color: black, fontWeight: FontWeight.w300),
                items: [
                  'All Applications',
                  'Accepted Applications',
                  'Pending Applications',
                  'Rejected Applications'
                ].map(
                  (val) {
                    return DropdownMenuItem<String>(
                      value: val,
                      child: Text(val),
                    );
                  },
                ).toList(),
                onChanged: (val) {
                  setState(
                    () {
                      _dropDownValue = val!;
                    },
                  );
                },
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),

        FutureBuilder(
          future: ApiServices.getMemberApplications(
              accessToken, userId, "accepted"),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.none) {
              return const Text('No data Found');
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }

            var data = snapshot.data;

            var jsonRes = json.decode(data![1]);

            var decodedSaccos = SaccoApplicationsModel.fromJson(jsonRes);
            var allSacco = decodedSaccos.results;
            if (allSacco.isEmpty) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding / 2,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Accepted Applications",
                          style: GoogleFonts.poppins(
                            color: black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "View all",
                              style: GoogleFonts.poppins(
                                color: black,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 13,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(20),
                    child: Text(
                      "No accepted applications",
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              );
            }

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultPadding / 2,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Accepted Applications",
                        style: GoogleFonts.poppins(
                          color: black,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "View all",
                            style: GoogleFonts.poppins(
                              color: black,
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 13,
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultPadding / 2,
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: allSacco.length <= 3 ? allSacco.length : 3,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 65,
                                      height: 65,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.network(
                                            allSacco[index].saccoImage),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          allSacco[index].saccoName,
                                          style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              color: black,
                                              fontWeight: FontWeight.w300),
                                        ),
                                        Text(
                                          "Accepted",
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            color: Colors.green[800],
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Text(
                                  allSacco[index].joiningDate,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: black,
                                    fontWeight: FontWeight.w300,
                                  ),
                                )
                              ],
                            ),
                            const Divider()
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),

        // else if( _dropDownValue == 'All Applications' || _dropDownValue == 'Pending Applications')
        FutureBuilder(
          future:
              ApiServices.getMemberApplications(accessToken, userId, "pending"),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.none) {
              return const Text('No data Found');
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }

            var data = snapshot.data;

            var jsonRes = json.decode(data![1]);

            var decodedSaccos = SaccoApplicationsModel.fromJson(jsonRes);
            var allSacco = decodedSaccos.results;
            if (allSacco.isEmpty) {
              return Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: kDefaultPadding / 2,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Pending Applications",
                            style: GoogleFonts.poppins(
                              color: black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "View all",
                                style: GoogleFonts.poppins(
                                  color: black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 13,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(20),
                      child: Text(
                        "No pending applications",
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultPadding / 2,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Pending Applications",
                        style: GoogleFonts.poppins(
                          color: black,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "View all",
                            style: GoogleFonts.poppins(
                              color: black,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 13,
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultPadding / 2,
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: allSacco.length <= 3 ? allSacco.length : 3,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 65,
                                      height: 65,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.network(
                                            allSacco[index].saccoImage),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          allSacco[index].saccoName,
                                          style: GoogleFonts.poppins(
                                            fontSize: 15,
                                            color: black,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                        Text(
                                          "Pending",
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            color: Colors.yellow[800],
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Text(
                                  allSacco[index].joiningDate,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: black,
                                    fontWeight: FontWeight.w300,
                                  ),
                                )
                              ],
                            ),
                            const Divider()
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),

        // else if( _dropDownValue =='All Applications' || _dropDownValue=='Rejected Applications')
        FutureBuilder(
            future: ApiServices.getMemberApplications(
                accessToken, userId, "rejected"),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.none) {
                return const Text('No data Found');
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator.adaptive());
              }

              var data = snapshot.data;

              var jsonRes = json.decode(data![1]);

              var decodedSaccos = SaccoApplicationsModel.fromJson(jsonRes);
              var allSacco = decodedSaccos.results;
              if (allSacco.isEmpty) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: kDefaultPadding / 2,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Rejected Applications",
                            style: GoogleFonts.poppins(
                              color: black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "View all",
                                style: GoogleFonts.poppins(
                                  color: black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 13,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(20),
                      child: Text(
                        "No rejected applications",
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                );
              }

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding / 2,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Rejected Applications",
                          style: GoogleFonts.poppins(
                            color: black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "View all",
                              style: GoogleFonts.poppins(
                                color: black,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 13,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding / 2,
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: allSacco.length <= 3 ? allSacco.length : 3,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 65,
                                        height: 65,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: Image.network(
                                              allSacco[index].saccoImage),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            allSacco[index].saccoName,
                                            style: GoogleFonts.poppins(
                                                fontSize: 15,
                                                color: black,
                                                fontWeight: FontWeight.w300),
                                          ),
                                          Text(
                                            "Rejected",
                                            style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              color: Colors.red[800],
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Text(
                                    allSacco[index].joiningDate,
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: black,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  )
                                ],
                              ),
                              const Divider()
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            })
      ],
    );
  }
}
