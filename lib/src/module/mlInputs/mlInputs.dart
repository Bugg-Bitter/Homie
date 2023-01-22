import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:homie/src/module/finalMlOut/final_ml_out.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/config.dart';
import '../dailyReport/updatePage/components/back_button_ttile.dart';
import '../dailyReport/updatePage/components/homebackbutton.dart';
import '../dailyReport/updatePage/components/user_info_template.dart';
import '../search/config/search_config.dart';
import 'mlInputSectionName.dart';

class MlInputsStart extends StatelessWidget {
  const MlInputsStart({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MlInputsUI(
        sectionName: 'Body Temperature',
      ),
    );
  }
}

class MlInputsUI extends StatefulWidget {
  final String sectionName;

  const MlInputsUI({super.key, required this.sectionName});

  @override
  State<MlInputsUI> createState() => _MlInputsUIState();
}

class _MlInputsUIState extends State<MlInputsUI> {
  TextEditingController param1 = TextEditingController();
  TextEditingController param2 = TextEditingController();
  TextEditingController param3 = TextEditingController();
  TextEditingController param4 = TextEditingController();
  String checkParam1 = '';
  String checkParam2 = '';
  String checkParam3 = '';
  String checkParam4 = '';
  String? loggedInUserMail = '';
  String? userName = '';
  String? userDOB = '';
  String? userPhone = '';

  getSectionFlag() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    if (widget.sectionName == 'Body Temperature') {
      _pref.setInt("$bodyTemKey", 1);
    } else if (widget.sectionName == 'Heart Rate') {
      _pref.setInt("$heartRateKey", 1);
    } else if (widget.sectionName == 'Breathing Rate') {
      _pref.setInt("$breathingRateKey", 1);
    } else if (widget.sectionName == 'Blood Pressure') {
      _pref.setInt("$bloodPressureKey", 1);
    } else if (widget.sectionName == 'Blood Sugar') {
      _pref.setInt("$booldSugarKey", 1);
    } else {
      _pref.setInt("$ohtersKey", 1);
    }
  }

  @override
  void initState() {
    super.initState();
    getEmail();
    getOtherInfo();
    getSectionFlag();
  }

  @override
  Widget build(BuildContext context) {
    double ScreenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffd7d9ef),
        resizeToAvoidBottomInset: false,
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 32.0, bottom: 32.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 16.0),
                        child: HomeBackButton(),
                      ),
                      BackButtonTitle(
                        title: widget.sectionName,
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Row(
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
                                        bottom: 10.0, left: 10.0),
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
                        padding:
                            EdgeInsets.only(right: 13.0, top: 5.0, bottom: 5.0),
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
                ),
                MlInputsSection(section: widget.sectionName),
                Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 30.0),
                  child: SizedBox(
                    height: 50.0,
                    width: double.infinity,
                    child: TextField(
                      controller: param1,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          filled: true,
                          hintStyle: TextStyle(color: Colors.grey[800]),
                          hintText: "Parameter 1",
                          fillColor: Colors.white70),
                    ),
                  ),
                ),
                checkParam1 != ""
                    ? Text(
                        checkParam1,
                        style: TextStyle(
                          color: Colors.redAccent,
                        ),
                      )
                    : Container(),
                Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 30.0),
                  child: SizedBox(
                    height: 50.0,
                    width: double.infinity,
                    child: TextField(
                      controller: param2,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          filled: true,
                          hintStyle: TextStyle(color: Colors.grey[800]),
                          hintText: "Parameter 2",
                          fillColor: Colors.white70),
                    ),
                  ),
                ),
                checkParam2 != ""
                    ? Text(
                        checkParam2,
                        style: TextStyle(
                          color: Colors.redAccent,
                        ),
                      )
                    : Container(),
                Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 30.0),
                  child: SizedBox(
                    height: 50.0,
                    width: double.infinity,
                    child: TextField(
                      controller: param3,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          filled: true,
                          hintStyle: TextStyle(color: Colors.grey[800]),
                          hintText: "Parameter 3",
                          fillColor: Colors.white70),
                    ),
                  ),
                ),
                checkParam3 != ""
                    ? Text(
                        checkParam3,
                        style: TextStyle(
                          color: Colors.redAccent,
                        ),
                      )
                    : Container(),
                Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 30.0),
                  child: SizedBox(
                    height: 50.0,
                    width: double.infinity,
                    child: TextField(
                      controller: param4,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          filled: true,
                          hintStyle: TextStyle(color: Colors.grey[800]),
                          hintText: "Parameter 4",
                          fillColor: Colors.white70),
                    ),
                  ),
                ),
                checkParam4 != ""
                    ? Text(
                        checkParam4,
                        style: TextStyle(
                          color: Colors.redAccent,
                        ),
                      )
                    : Container(),
                Padding(
                  padding: EdgeInsets.only(top: 24.0),
                  child: SizedBox(
                    width: 150.0,
                    height: 50.0,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: () {
                          setState(() {
                            if (param1.text == '') {
                              checkParam1 = "invalid value";
                            } else {
                              checkParam1 = "";
                              if (param2.text == '') {
                                checkParam2 = "invalid value";
                              } else {
                                checkParam2 = "";
                                if (param3.text == '') {
                                  checkParam3 = "invalid value";
                                } else {
                                  checkParam3 = "";
                                  if (param4.text == '') {
                                    checkParam4 = "invalid value";
                                  } else {
                                    checkParam4 = "";
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (((context) => FinalMlOutStart(
                                              inSection: widget.sectionName,
                                              inParam1: param1.text,
                                              inParam2: param2.text,
                                              inParam3: param3.text,
                                              inParam4: param4.text,
                                            ))),
                                      ),
                                    );
                                  }
                                }
                              }
                            }
                          });
                        },
                        child: const Text(
                          "Submit",
                          style: TextStyle(
                            fontSize: 24.0,
                          ),
                        )),
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
