import 'package:flutter/material.dart';
import 'package:homie/src/module/dailyReport/views/dailyReport.dart';
import 'package:homie/src/module/home/views/home.dart';
import 'package:homie/src/module/profile/personProfile/views/profile.dart';
import 'package:homie/src/module/search/views/search_UI.dart';

class NavigationStart extends StatelessWidget {
  const NavigationStart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NavigationUI(),
    );
  }
}

class NavigationUI extends StatefulWidget {
  const NavigationUI({Key? key}) : super(key: key);

  @override
  State<NavigationUI> createState() => _NavigationUIState();
}

class _NavigationUIState extends State<NavigationUI> {
  int c_index = 0;
  final pages = [
    HomeStart(),
    SearchStart(),
    DailyReportStart(),
    ProfileStart(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[c_index],
      backgroundColor: Color(0xFFFAFAFE),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: BottomNavigationBar(
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Color(0xFF1648CE),
            unselectedItemColor: Color(0xFF929CAD),
            backgroundColor: Color(0xFFFFFFFF),
            currentIndex: c_index,
            onTap: (index) => setState(() => c_index = index),
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_rounded,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.search_rounded,
                ),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.list_alt_rounded,
                ),
                label: 'Daily Report',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person_rounded,
                ),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
