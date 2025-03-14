import 'package:flutter/material.dart';
import 'package:sacco_app/constants.dart';

class Accordion extends StatefulWidget {
  final String title;
  final String content;

  const Accordion({Key? key, required this.title, required this.content})
      : super(key: key);
  @override
  State<Accordion> createState() => _AccordionState();
}

class _AccordionState extends State<Accordion> {
  // Show or hide the content
  bool _showContent = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding / 5,
        vertical: kDefaultPadding / 4,
      ),
      child: Column(
          children: [
        // The title
        ListTile(
          tileColor: kBackgroundColor,
          title: Text(widget.title),
          trailing: IconButton(
            icon: Icon(
                _showContent ? Icons.arrow_drop_up : Icons.arrow_drop_down),
            onPressed: () {
              setState(() {
                _showContent = !_showContent;
              });
            },
          ),
        ),
        // Show or hide the content based on the state
        _showContent
            ? Container(
          padding:
          const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: Text(widget.content),
        )
            : Container()
      ]),
    );
  }
}