import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    Key? key,
    required this.ScreenWidth,
    required this.ScreenHeight,
  }) : super(key: key);

  final double ScreenWidth;
  final double ScreenHeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(ScreenWidth / 7.0, ScreenHeight / 6.0,
          ScreenWidth / 7.0, ScreenHeight / 50.0),
      child: TextField(
        mouseCursor: MouseCursor.defer,
        // controller: email,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.search_rounded),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            filled: true,
            hintStyle: TextStyle(color: Colors.grey[800]),
            hintText: " Search",
            fillColor: Colors.white),
      ),
    );
  }
}
