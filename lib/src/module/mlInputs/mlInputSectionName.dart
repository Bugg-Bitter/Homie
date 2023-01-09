import 'package:flutter/material.dart';

class MlInputsSection extends StatelessWidget {
  const MlInputsSection({
    Key? key,
    required this.section,
  }) : super(key: key);

  final String section;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 16.0,
      ),
      child: Text(
        "$section",
        style: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.w500,
          color: Color(0xff4d52b6),
        ),
      ),
    );
  }
}
