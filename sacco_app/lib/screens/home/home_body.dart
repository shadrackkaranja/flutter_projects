import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sacco_app/constants.dart';
import 'package:sacco_app/screens/home/components/all_sacco.dart';
import 'package:sacco_app/screens/home/components/my_saccos.dart';
import 'package:sacco_app/user_secure_storage.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody>
    with SingleTickerProviderStateMixin {
  String accessToken = "accessToken";
  String userId = "userId";
  String name = "name";
  String searchQuery = "";
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    init();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  Future init() async {
    final username = await UserSecureStorage.getName() ?? "username";
    final accessToken =
        await UserSecureStorage.getAccessToken() ?? "accessToken";
    final userId = await UserSecureStorage.getUserId() ?? "userId";

    setState(() {
      this.accessToken = accessToken;
      this.userId = userId;

      name = username;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: size.width,
            decoration: const BoxDecoration(
              color: white,
            ),
            child: Column(
              children: [
                SafeArea(
                  child: UserHeader(
                    username: name,
                  ),
                ),
                TabSelection(
                  tabController: _tabController,
                ),
                SearchBar(callback: (val) => setState(() => searchQuery = val)),
                SizedBox(height: size.height * 0.02),
              ],
            ),
          ),
          ListofSaccos(
              accessToken: accessToken,
              userId: userId,
              tabController: _tabController,
              searchQuery: searchQuery),
        ],
      ),
    );
  }
}

class UserHeader extends StatelessWidget {
  final String username;
  const UserHeader({
    super.key,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: kDefaultPadding / 2,
        left: kDefaultPadding,
        right: kDefaultPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Hi, $username",
                style: GoogleFonts.poppins(
                    fontSize: 18,
                    foreground: Paint()
                      ..shader = const LinearGradient(
                        colors: <Color>[
                          Color.fromRGBO(241, 162, 162, 1),
                          Color.fromRGBO(145, 61, 159, 1),
                        ],
                      ).createShader(
                          const Rect.fromLTWH(0.0, 0.0, 200.0, 100.0))),
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Image.asset("assets/icons/notification.png")),
                  IconButton(
                      onPressed: () {},
                      icon: Image.asset("assets/icons/sign.png")),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ListofSaccos extends StatelessWidget {
  final String accessToken;

  final String userId;
  final TabController tabController;
  final String searchQuery;
  const ListofSaccos({
    super.key,
    required this.accessToken,
    required this.userId,
    required this.tabController,
    required this.searchQuery,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TabBarView(
        controller: tabController,
        children: [
          // first tab bar view widget
          AllSaccos(searchQuery: searchQuery),

          // second tab bar view widget
          MySaccos(
              accessToken: accessToken,
              userId: userId,
              searchQuery: searchQuery),
        ],
      ),
    );
  }
}

// Function callback Implementation
typedef StringCallback = void Function(String val);

class SearchBar extends StatelessWidget {
  final StringCallback callback;
  const SearchBar({
    super.key,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
      ),
      child: StatefulBuilder(builder: (context, setState) {
        return TextFormField(
          onChanged: (value) {
            setState(() {
              callback(value.toString());
            });
          },
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(10),
            hintText: "Search",
            fillColor: const Color.fromRGBO(245, 245, 245, 1),
            filled: true,
            prefixIcon: Image.asset("assets/icons/search.png"),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(18),
            ),
          ),
        );
      }),
    );
  }
}

class TabSelection extends StatelessWidget {
  final TabController tabController;
  const TabSelection({
    super.key,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: kDefaultPadding,
        right: kDefaultPadding,
        bottom: kDefaultPadding / 2,
      ),
      child: TabBar(
        controller: tabController,
        // give the indicator a decoration (color and border radius)
        indicatorColor: Colors.black,
        labelColor: Colors.black,
        unselectedLabelColor: Colors.grey.withOpacity(.9),
        tabs: const [
          // first tab [you can add an icon using the icon property]
          Tab(
            text: 'All Saccos',
          ),

          // second tab [you can add an icon using the icon property]
          Tab(
            text: 'My Saccos',
          ),
        ],
      ),
    );
  }
}
