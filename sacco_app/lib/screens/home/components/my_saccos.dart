import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sacco_app/api_services.dart';
import 'package:sacco_app/constants.dart';
import 'package:sacco_app/models/sacco_details_model.dart';
import 'package:sacco_app/screens/about/about_sacco.dart';
import 'package:sacco_app/screens/home/components/sacco_card.dart';

class MySaccos extends StatefulWidget {
  final String searchQuery;
  final String accessToken;
  final String userId;
  const MySaccos(
      {super.key,
      required this.accessToken,
      required this.userId,
      required this.searchQuery});

  @override
  State<MySaccos> createState() => _MySaccosState();
}

class _MySaccosState extends State<MySaccos> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiServices.getMemberSaccos(widget.accessToken, widget.userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none) {
          return const Text('No data Found');
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }

        var data = snapshot.data;

        var jsonRes = json.decode(data![1]);

        var decodedSaccos = SaccoDetailsModel.fromJson(jsonRes);
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

        List<dynamic> filteredItems = memberSaccos.where((item) {
          return item.saccoName.toLowerCase().contains(widget.searchQuery);
        }).toList();
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding / 2,
          ),
          child: widget.searchQuery == ""
              ? GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 280,
                    childAspectRatio: 1,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 2,
                  ),
                  itemCount: memberSaccos.length,
                  itemBuilder: (context, index) {
                    return SaccoCard(
                      allSacco: memberSaccos[index],
                      press: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SaccoDetails(
                            saccoList: memberSaccos[index],
                            isMySacco: true,
                          ),
                        ),
                      ),
                    );
                  },
                )
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 280,
                    childAspectRatio: 1,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 2,
                  ),
                  itemCount: filteredItems.length,
                  itemBuilder: (context, index) {
                    return SaccoCard(
                      allSacco: filteredItems[index],
                      press: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SaccoDetails(
                            saccoList: filteredItems[index],
                            isMySacco: true,
                          ),
                        ),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
