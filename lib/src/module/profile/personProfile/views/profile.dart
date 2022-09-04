import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homie/src/config/config.dart';
import 'package:homie/src/module/profile/resetPassword/view/resetPassword.dart';
import 'package:homie/src/module/profile/updateProfile/views/updateProfileUI.dart';
import 'package:homie/src/module/search/config/search_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../dailyReport/viewPage/view/viewPage.dart';
import '../../../medicalReport/views/medical_reports.dart';

class ProfileStart extends StatelessWidget {
  const ProfileStart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfileUI(),
    );
  }
}

class ProfileUI extends StatefulWidget {
  const ProfileUI({Key? key}) : super(key: key);

  @override
  State<ProfileUI> createState() => _ProfileUIState();
}

class _ProfileUIState extends State<ProfileUI> {
  String? loggedInUserMail = '';
  String? userName = '';
  String? userDOB = '';
  String? userPhone = '';
  @override
  void initState() {
    super.initState();
    getEmail();
    getOtherInfo();
  }

  @override
  Widget build(BuildContext context) {
    double ScreenHeight = MediaQuery.of(context).size.height;
    double ScreenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: ScreenWidth / 10.0,
                        right: ScreenWidth / 10.0,
                        top: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 35.0,
                          width: 35.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Color(0xFF1648CE),
                          ),
                        ),
                        Text(
                          'Profile',
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 18.0,
                              fontFamily: 'montserrat',
                              fontWeight: FontWeight.w800),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                              height: 35.0,
                              width: 35.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Icon(
                                Icons.mail_rounded,
                                color: Color(0xFF1648CE),
                              )),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 40.0,
                      right: 40.0,
                      top: 20.0,
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 100.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 13.0),
                            child: FutureBuilder(
                                future: storage.userProfilePicDownloadURL(
                                    '${loggedInUserMail}'),
                                builder: (BuildContext context,
                                    AsyncSnapshot<String> snapshot) {
                                  if (snapshot.connectionState ==
                                          ConnectionState.done &&
                                      snapshot.hasData) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image.network(
                                        snapshot.data!,
                                        height: ScreenHeight / 12.0,
                                        width: ScreenWidth / 7.0,
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  }
                                  if (snapshot.connectionState ==
                                          ConnectionState.waiting ||
                                      !snapshot.hasData) {
                                    return Center(
                                        child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 8.0, right: 8.0),
                                      child: Container(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator()),
                                    ));
                                  } else {
                                    return Container();
                                  }
                                }),
                          ),
                          FutureBuilder<User?>(
                            future: readUserInfo(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasError) {
                                return Padding(
                                  padding: EdgeInsets.only(left:ScreenHeight/30.0),
                                  child: Text(
                                    'connection don\'t\nestablished Properly',
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
                                            top: 10.0, bottom: 10.0, left: 20.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                          user.name,
                                              style: TextStyle(
                                                  fontFamily: 'montserrat',
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Icon(
                                                  Icons.calendar_today_outlined,
                                                  size: 18.0,
                                                  color: Color(0xFF1648CE),
                                                ),
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 8.0),
                                                  child: Text(
                                                    user.dob,
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 12.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Icon(
                                                    Icons.phone_rounded,
                                                    size: 18.0,
                                                    color: Color(0xFF1648CE),
                                                  ),
                                                  Text(user.phoneNo,
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 40.0, bottom: 30.0),
                            child: InkWell(
                              onTap: () {},
                              child: Container(
                                  height: 35.0,
                                  width: 35.0,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Icon(
                                    Icons.edit,
                                    color: Color(0xFF1648CE),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 40.0,
                      right: 40.0,
                      top: 20.0,
                    ),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => ViewPageDataStart()));
                      },
                      child: Container(
                        width: double.infinity,
                        height: 100.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.white,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.book_rounded,
                                  color: Color(0xFF1648CE),
                                ),
                                Text(
                                  'Daily Reports',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontFamily: 'montserrat',
                                      fontWeight: FontWeight.w800),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Text(
                                'Check Your Medical History',
                                style: TextStyle(
                                    fontFamily: 'montserrat', fontSize: 10.0),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 40.0,
                      right: 40.0,
                      top: 20.0,
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 70.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Icon(
                                  Icons.medication_liquid_rounded,
                                  color: Color(0xFF1648CE),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 20.0),
                                child: Text(
                                  'Medical Reports',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontFamily: 'montserrat',
                                      fontWeight: FontWeight.w800),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 10.0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Medical_Reports()));
                                  },
                                  child: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Color(0XFF1648CE),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 40.0,
                      right: 40.0,
                      top: 20.0,
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 70.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Icon(
                                  Icons.settings,
                                  color: Color(0xFF1648CE),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 20.0),
                                child: Text(
                                  'Profile Settings',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontFamily: 'montserrat',
                                      fontWeight: FontWeight.w800),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 10.0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext conext) =>
                                                UpdateProfileStart()));
                                  },
                                  child: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Color(0XFF1648CE),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 40.0,
                      right: 40.0,
                      top: 20.0,
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 70.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Icon(
                                  Icons.lock_open_rounded,
                                  color: Color(0xFF1648CE),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 20.0),
                                child: Text(
                                  'Reset Password',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontFamily: 'montserrat',
                                      fontWeight: FontWeight.w800),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 10.0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (BuildContext conext) =>
                                                          ResetPasswordStart()));
                                  },
                                  child: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Color(0XFF1648CE),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 40.0,
                      right: 40.0,
                      top: 20.0,
                      bottom: 20.0,
                    ),
                    child: InkWell(
                      onTap: () =>
                          FirebaseAuth.instance.signOut(),
                      child: Container(
                        width: double.infinity,
                        height: 70.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.white,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.logout_rounded,
                                    color: Color(0xFF1648CE),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      'Logout',
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontFamily: 'montserrat',
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
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

    // required this.location
  });

  Map<String, dynamic> toJson() => {
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
