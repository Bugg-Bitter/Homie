import 'package:flutter/material.dart';

class BackButtonTitle extends StatelessWidget {
  final String title;
  const BackButtonTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8.0),
      child: Text(
        "$title",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
      ),
    );
  }
}
