import 'package:flutter/material.dart';
import 'package:homie/src/module/dailyReport/updatePage/view/dailyReport.dart';

import '../../../home/views/home.dart';

class HomeBackButton extends StatelessWidget {
  const HomeBackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: ((context) => DailyReportStart())));
        // Navigator.of(context).pop();
      },
      child: Container(
        width: 50.0,
        height: 50.0,
        decoration: BoxDecoration(
          color: Color(0xff4d52b6),
          borderRadius: BorderRadius.circular(40),
        ),
        child: Icon(
          Icons.arrow_back_ios_new,
          size: 40,
          color: Colors.white,
        ),
      ),
    );
  }
}
