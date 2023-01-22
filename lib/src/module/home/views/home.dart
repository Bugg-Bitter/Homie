import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_close_app/flutter_close_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:homie/src/utils/date_utils.dart' as date_util;

import '../../../config/config.dart';
import '../../search/config/search_config.dart';

class HomeStart extends StatelessWidget {
  const HomeStart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeUI(),
    );
  }
}

class HomeUI extends StatefulWidget {
  const HomeUI({Key? key}) : super(key: key);

  @override
  State<HomeUI> createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  late ScrollController scrollController;
  double width = 0;
  double height = 0;
  List<DateTime> currentMonthList = List.empty();
  DateTime currentDateTime = DateTime.now();

  String? loggedInUserMail = '';
  String? userName = '';
  String? userDOB = '';
  String? userPhone = '';
  int healthScrore = 0;

  retriveHealthInfo() async {
    SharedPreferences _ = await SharedPreferences.getInstance();
    setState(() {
      healthScrore = _.getInt(hsKey) ?? 0;
    });
  }

  @override
  void initState() {
    super.initState();
    currentMonthList = date_util.DateUtilss.daysInMonth(currentDateTime);
    currentMonthList.sort((a, b) => a.day.compareTo(b.day));
    currentMonthList = currentMonthList.toSet().toList();
    scrollController =
        ScrollController(initialScrollOffset: 80.0 * currentDateTime.day);
    getEmail();
    getOtherInfo();
    retriveHealthInfo();
  }

  @override
  Widget build(BuildContext context) {
    double ScreenHeight = MediaQuery.of(context).size.height;
    double ScreenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: FlutterCloseAppPage(
          interval: 2,
          condition: true,
          onCloseFailed: () {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Press again to exit 🎉'),
            ));
          },
          child: Scaffold(
            backgroundColor: Color(0xff4E52B6).withOpacity(0.3),
            body: Container(
              height: double.infinity,
              width: double.infinity,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FutureBuilder<User?>(
                        future: readUserInfo(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasError) {
                            return Padding(
                              padding:
                                  EdgeInsets.only(left: ScreenHeight / 30.0),
                              child: Text(
                                'Unable to load data',
                                style: TextStyle(
                                    fontSize: 14.0, color: Colors.black),
                              ),
                            );
                          } else if (snapshot.hasData) {
                            final user = snapshot.data;
                            return user == null
                                ? Center(
                                    child: Text('No User Found'),
                                  )
                                : Padding(
                                    padding: EdgeInsets.only(
                                        top: 40.0, bottom: 10.0, left: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          " Hi, ${user.name}",
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontFamily: 'rubik',
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  );
                          } else {
                            return Center(
                              child: Text('Loading ...',
                                  style: TextStyle(color: Colors.black)),
                            );
                          }
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 13.0, top: 10.0),
                        child: FutureBuilder(
                            future: storage.userProfilePicDownloadURL(
                                '${loggedInUserMail}'),
                            builder: (BuildContext context,
                                AsyncSnapshot<String> snapshot) {
                              if (snapshot.connectionState ==
                                      ConnectionState.done &&
                                  snapshot.hasData) {
                                return SizedBox(
                                  height: 60.0,
                                  width: 60.0,
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      snapshot.data!,
                                    ),
                                  ),
                                );
                              }
                              if (snapshot.connectionState ==
                                      ConnectionState.waiting ||
                                  !snapshot.hasData) {
                                return Center(
                                    child: Padding(
                                  padding:
                                      EdgeInsets.only(left: 8.0, right: 8.0),
                                  child: Container(
                                      height: 20,
                                      width: 20,
                                      child: Text(
                                        ' No\nImg',
                                        style: TextStyle(
                                            fontSize: 8.0, color: Colors.black),
                                      )),
                                ));
                              } else {
                                return Container();
                              }
                            }),
                      ),
                    ],
                  ),
                  Text(
                    date_util.DateUtilss.months[currentDateTime.month - 1] +
                        ' ' +
                        currentDateTime.year.toString(),
                    style: TextStyle(
                        fontFamily: 'rubik',
                        fontSize: 24.0,
                        color: Colors.black),
                  ),
                  Text(
                    " ${currentDateTime.day.toString()}, ${date_util.DateUtilss.weekdays[currentMonthList[DateTime.now().weekday].weekday - 1]}day",
                    style: TextStyle(
                      fontFamily: 'rubik',
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: ScreenHeight / 14.0),
                    child: Container(
                      width: double.infinity,
                      height: ScreenHeight / 12.0,
                      color: Colors.white,
                      child: horizontalCapsuleView(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: ScreenHeight / 20.0),
                    child: CircleAvatar(
                      radius: 100.0,
                      backgroundColor: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Health scores',
                            style: TextStyle(
                                color: Color(0xff4E52B6), fontSize: 20.0),
                          ),
                          Text(
                            '${healthScrore}%',
                            style: TextStyle(
                                fontSize: 80.0,
                                color: Color(0xff4E52B6),
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      healthScrore < 41
                          ? "Visit doctor as soon as possible"
                          : healthScrore < 61
                              ? "Take a basic health check up"
                              : "Just keep a healthy diet",
                      style:
                          TextStyle(color: Color(0xff6f6f6f), fontSize: 18.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget horizontalCapsuleView() {
    return Container(
      width: width,
      height: 110,
      child: ListView.builder(
          itemCount: currentMonthList.length,
          controller: scrollController,
          scrollDirection: Axis.horizontal,
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return capsuleView(index);
          }),
    );
  }

  Widget capsuleView(int index) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8.0, 2.0, 0, 2.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            currentDateTime = currentMonthList[index];
          });
        },
        child: Container(
          width: 44.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: (currentMonthList[index].day != currentDateTime.day)
                    ? [
                        Color(0xffDFDFDF),
                        Color(0xffDFDFDF),
                        Color(0xffDFDFDF),
                      ]
                    : [
                        Color(0xff4E52B6),
                        Color(0xff4E52B6),
                        Color(0xff4E52B6),
                      ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(0.0, 1.0),
                stops: const [0.0, 0.5, 1.0],
                tileMode: TileMode.clamp),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  currentMonthList[index].day.toString(),
                  style: TextStyle(
                    fontSize: 24.0,
                    color: (currentMonthList[index].day != currentDateTime.day)
                        ? Color(0xff465876)
                        : Colors.white,
                  ),
                ),
                Text(
                  date_util
                      .DateUtilss.weekdays[currentMonthList[index].weekday - 1],
                  style: TextStyle(
                    fontSize: 14,
                    color: (currentMonthList[index].day != currentDateTime.day)
                        ? Color(0xff465876)
                        : Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getOtherInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('updatedName');
      userDOB = prefs.getString('updatedBirth');
      userPhone = prefs.getString('updatedPhone');
    });
  }

  Future<User?> readUserInfo() async {
    final onlyDocUser =
        FirebaseFirestore.instance.collection('newUser').doc(loggedInUserMail);
    final snapshot = await onlyDocUser.get();
    if (snapshot.exists) return User.fromJson(snapshot.data()!);
  }

  Future<String?> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      loggedInUserMail = prefs.getString('userEmail');
      print(loggedInUserMail);
    });
    return loggedInUserMail;
  }
}

class User {
  final String name;
  final String dob;
  final String phoneNo;

  User({
    required this.phoneNo,
    required this.name,
    required this.dob,
  });

  toJson() => {
        'name': name,
        'dateOfBirth': dob,
        'phone': phoneNo,
      };

  static User fromJson(Map<String, dynamic> json) => User(
        name: json['name'],
        dob: json['dateOfBirth'],
        phoneNo: json['phone'],
      );
}
