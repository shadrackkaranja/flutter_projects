import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_app/utils/colors.dart';

class SearchBox extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const SearchBox({
    super.key,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: ksecondaryColor.withOpacity(0.7)),
        borderRadius: BorderRadius.circular(
          20,
        ),
      ),
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: SvgPicture.asset("assets/icons/search.svg"),
          hintText: "Search Here",
          hintStyle: TextStyle(color: ksecondaryColor),
        ),
      ),
    );
  }
}
