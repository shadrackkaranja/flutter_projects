import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sacco_app/api_services.dart';
import 'package:sacco_app/constants.dart';
import 'package:sacco_app/models/sacco_details_model.dart';
import 'package:sacco_app/screens/about/about_sacco.dart';
import 'package:sacco_app/screens/home/components/sacco_card.dart';
import 'package:sacco_app/user_secure_storage.dart';

class AllSaccos extends StatefulWidget {
  final String searchQuery;
  const AllSaccos({super.key, required this.searchQuery});

  @override
  State<AllSaccos> createState() => _AllSaccosState();
}

class _AllSaccosState extends State<AllSaccos> {
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
    return FutureBuilder(
      future: ApiServices.getAllSaccos(accessToken, userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none) {
          return const Text('No data Found');
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }

        var data = snapshot.data;

        var jsonRes = json.decode(data![1]);

        var decodedSaccos = SaccoDetailsModel.fromJson(jsonRes);
        var allSacco = decodedSaccos.results;
        if (allSacco.isEmpty) {
          return Center(
            child: Text(
              "No Saccos listed",
              style: GoogleFonts.poppins(
                fontSize: 13,
              ),
            ),
          );
        }

        // Create a filtered list of items based on the search query
        List<dynamic> filteredItems = allSacco.where((item) {
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
                  itemCount: allSacco.length,
                  itemBuilder: (context, index) {
                    return SaccoCard(
                      allSacco: allSacco[index],
                      press: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SaccoDetails(
                            saccoList: allSacco[index],
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
