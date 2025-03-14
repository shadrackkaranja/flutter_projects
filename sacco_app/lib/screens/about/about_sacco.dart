import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sacco_app/constants.dart';
import 'package:sacco_app/models/sacco_details_model.dart';
import 'package:sacco_app/screens/user_application/sacco_application.dart';
import 'package:sacco_app/user_secure_storage.dart';

class SaccoDetails extends StatefulWidget {
  final bool isMySacco;
  final Result saccoList;

  const SaccoDetails({
    super.key,
    required this.saccoList,
    this.isMySacco = false,
  });

  @override
  State<SaccoDetails> createState() => _SaccoDetailsState();
}

class _SaccoDetailsState extends State<SaccoDetails> {
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
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(35),
        child: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context, true);
            },
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                SaccoHeader(
                    size: size,
                    saccoList: widget.saccoList,
                    userId: userId,
                    accessToken: accessToken,
                    isMySacco: widget.isMySacco),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Features(
                  features: widget.saccoList,
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                MembershipRequirements(size: size, saccoList: widget.saccoList),
                SizedBox(
                  height: size.height * 0.02,
                ),
                // ContactDetails(size: size, saccoList: saccoList),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: size.height * 0.07,
            child: ElevatedButton(
              onPressed: () {
                widget.isMySacco
                    ? null
                    : Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SaccoApplication(
                            saccoList: widget.saccoList,
                            userId: userId,
                            accessToken: accessToken,
                          ),
                        ),
                      );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    0,
                  ),
                ),
              ),
              child: Text(
                widget.isMySacco ? 'DEACTIVATE MEMBERSHIP' : 'APPLY NOW',
                style: GoogleFonts.poppins(
                  color: white,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  letterSpacing: 1.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SaccoHeader extends StatelessWidget {
  const SaccoHeader({
    super.key,
    required this.size,
    required this.saccoList,
    required this.userId,
    required this.accessToken,
    this.isMySacco = false,
  });

  final Size size;
  final Result saccoList;
  final String userId;
  final String accessToken;
  final bool isMySacco;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      decoration: const BoxDecoration(
        color: white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding,
          vertical: kDefaultPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    saccoList.saccoProfilePicture,
                    width: 80,
                    height: 80,
                  ),
                ),
                SizedBox(
                  width: size.width * 0.04,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        saccoList.saccoName,
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                        saccoList.saccoMotto,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Row(
                        children: [
                          const Image(
                            image: AssetImage(
                              "assets/images/user.png",
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.015,
                          ),
                          // Text(
                          //   saccoList.membersJoined.toString(),
                          //   style: GoogleFonts.poppins(
                          //     fontSize: 11,
                          //     fontWeight: FontWeight.w700,
                          //     color: const Color.fromRGBO(77, 65, 215, 1),
                          //   ),
                          // ),
                          SizedBox(
                            width: size.width * 0.1,
                          ),
                          SizedBox(
                            width: size.width * 0.3,
                            height: size.height * 0.04,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: black,
                              ),
                              onPressed: () {
                                isMySacco
                                    ? null
                                    : Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              SaccoApplication(
                                            saccoList: saccoList,
                                            userId: userId,
                                            accessToken: accessToken,
                                          ),
                                        ),
                                      );
                              },
                              child: Text(
                                isMySacco ? 'DEACTIVATE' : 'APPLY NOW',
                                style: GoogleFonts.poppins(
                                  color: white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Text(
              "About Us",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: Colors.black38,
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Text(
              saccoList.saccoAbout,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Features extends StatelessWidget {
  final Result features;
  const Features({
    super.key,
    required this.features,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Features",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: Colors.black38,
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          features.features.isEmpty
              ? const SizedBox(
                  height: 100,
                  child: Center(
                    child: Text(
                      "No Specified Features",
                    ),
                  ),
                )
              : SizedBox(
                  height: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: features.features.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: kDefaultPadding / 3),
                        width: 150,
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.grey.withOpacity(
                              .3,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: kDefaultPadding / 2,
                            vertical: kDefaultPadding / 2,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 35,
                                height: 35,
                                child: Image.asset(
                                  "assets/icons/bank.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              Text(
                                features.features[index].title,
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  features.features[index].description,
                                  overflow: TextOverflow.visible,
                                  style: const TextStyle(
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}

class MembershipRequirements extends StatelessWidget {
  const MembershipRequirements({
    super.key,
    required this.size,
    required this.saccoList,
  });

  final Size size;
  final Result saccoList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 5,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Membership Requirements",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: Colors.black38,
            ),
          ),
          SizedBox(
            height: size.height * 0.015,
          ),
          Container(
            width: double.infinity,
            height: 130,
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: saccoList.requirements.isEmpty
                ? const Center(
                    child: Text(
                      "No Specified Requirements",
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding,
                      vertical: kDefaultPadding,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: saccoList.requirements.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Row(
                                children: [
                                  Text(
                                    "\u2022",
                                    style: GoogleFonts.poppins(fontSize: 24),
                                  ),
                                  SizedBox(
                                    width: size.width * 0.02,
                                  ),
                                  Flexible(
                                    child: Text(
                                      saccoList.requirements[index].description,
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

// class ContactDetails extends StatelessWidget {
//   const ContactDetails({
//     super.key,
//     required this.size,
//     required this.saccoList,
//   });

//   final Size size;
//   final Result saccoList;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(
//         horizontal: kDefaultPadding,
//         vertical: kDefaultPadding / 5,
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Contact Details",
//             style: GoogleFonts.poppins(
//               fontWeight: FontWeight.w700,
//               fontSize: 14,
//               color: Colors.black38,
//             ),
//           ),
//           SizedBox(height: size.height * 0.02,),
//           Container(
//             width: double.infinity,
//             height: size.height * 0.15,
//             decoration: BoxDecoration(
//               color: white,
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.symmetric(
//                 horizontal: kDefaultPadding,
//                 vertical: kDefaultPadding,
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     child: ListView.builder(
//                       itemCount: saccoList.contacts.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         return Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               children: [
//                                 Text("Address:", style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w700),),
//                                 SizedBox(width: size.width * 0.02,),
//                                 Flexible(
//                                   child: Text(
//                                     saccoList.contacts[index]['address'],
//                                     style: GoogleFonts.poppins(
//                                       fontWeight: FontWeight.w400,
//                                       fontSize: 12,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: size.height * 0.01,),
//                             Row(
//                               children: [
//                                 Text("Email:", style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w700),),
//                                 SizedBox(width: size.width * 0.02,),
//                                 Flexible(
//                                   child: Text(
//                                     saccoList.contacts[index]['emailAddress'],
//                                     style: GoogleFonts.poppins(
//                                       fontWeight: FontWeight.w400,
//                                       fontSize: 12,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: size.height * 0.01,),
//                             Row(
//                               children: [
//                                 Text("Phone Number:", style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w700),),
//                                 SizedBox(width: size.width * 0.02,),
//                                 Flexible(
//                                   child: Text(
//                                     saccoList.contacts[index]['phoneNumber'],
//                                     style: GoogleFonts.poppins(
//                                       fontWeight: FontWeight.w400,
//                                       fontSize: 12,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           SizedBox(height: size.height * 0.04,),
//         ],
//       ),
//     );
//   }
// }
