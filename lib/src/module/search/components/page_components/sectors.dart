import 'package:flutter/material.dart';

class Sectors extends StatefulWidget {
  const Sectors({
    required this.searchResult,
    required this.searchResultIcon,
    required this.searchResultColor,
    Key? key,
  }) : super(key: key);

  final String searchResult;
  final IconData searchResultIcon;
  final Color searchResultColor;

  @override
  State<Sectors> createState() => _SectorsState();
}

class _SectorsState extends State<Sectors> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      width: 80.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Color(0xFFFAE9E9),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            widget.searchResultIcon,
            color: widget.searchResultColor,
          ),
          Text('${widget.searchResult}'),
        ],
      ),
    );
  }
}
