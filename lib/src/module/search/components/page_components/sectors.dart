import 'package:flutter/material.dart';

class Sectors extends StatefulWidget {
  const Sectors({
    required this.searchResult,
    required this.searchResultIcon,
    required this.searchResultColor,
    Key? key,
  }) : super(key: key);

  final String searchResult;
  final Image searchResultIcon;
  final Color searchResultColor;

  @override
  State<Sectors> createState() => _SectorsState();
}

class _SectorsState extends State<Sectors> {
  @override
  Widget build(BuildContext context) {
    double ScreenWidth = MediaQuery.of(context).size.width;
    double ScreenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: 80.0,
      width: 80.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            child: widget.searchResultIcon,
            height: ScreenWidth / 8.0,
          ),
          Padding(
            padding: EdgeInsets.only(top: 2.0),
            child: Text(
              '${widget.searchResult}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
