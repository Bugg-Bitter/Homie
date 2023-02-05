import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:homie/src/firebase/storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../dailyReport/updatePage/components/back_button_ttile.dart';
import '../../dailyReport/updatePage/components/homebackbutton.dart';
import 'add_report.dart';

class reportView extends StatefulWidget {
  reportView({Key? key}) : super(key: key);

  @override
  State<reportView> createState() => _reportViewState();
}

class _reportViewState extends State<reportView> {
  List temp = [];
  String? loggedInUserMail = '';
  String? userName = '';
  Storage f_storage = Storage();
  List<String> imgLocations = <String>[];
  void getFirebaseImageFolder() {
    final storageRef = FirebaseStorage.instance.ref().child('images');
    storageRef.listAll().then((result) {
      for (int i = 0; i < result.items.length; i++) {
        setState(() {
          temp.add(result.items[i].fullPath);
        });
      }
      getImageLocationList();
    });
  }

  getImageLocationList() async {
    for (int i = 0; i < temp.length; i++)
      imgLocations.add(await f_storage.medicalReportsDownloadURL(temp[i]));
    print("All Images are = $imgLocations");
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getFirebaseImageFolder();
    getEmail();
    Future<void> getOtherInfo() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        userName = prefs.getString('updatedName');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xff4E52B6).withOpacity(0.22),
          body: Container(
            height: double.infinity,
            width: double.infinity,
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
                        title: "All Reports",
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: temp.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (temp.length == 0)
                          return Center(
                            child: Text(
                              "No Prescription Uploaded !",
                              style:
                                  TextStyle(fontSize: 32, color: Colors.black),
                            ),
                          );
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth / 20.0,
                              vertical: screenWidth / 40.0),
                          child: Container(
                              width: double.infinity,
                              height: screenHeight / 9.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: screenWidth / 20.0,
                                    top: screenHeight / 120.0),
                                child: Row(
                                  children: [
                                    Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              10), // Image border
                                          child: SizedBox.fromSize(
                                            size: Size.fromRadius(
                                                30), // Image radius
                                            child: Image.network(
                                              imgLocations[index],
                                              filterQuality: FilterQuality.high,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 3.0),
                                          child: Container(
                                            height: 14.0,
                                            width: screenWidth / 8.0,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4.0),
                                              color: Color.fromRGBO(
                                                  14, 190, 127, 0.1),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "NEW",
                                                style: TextStyle(
                                                    color: Color(0xff4E52B6),
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 10.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Records Added by You",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14.0,
                                                fontFamily: 'rubik'),
                                          ),
                                          FutureBuilder<User?>(
                                            future: readUserInfo(),
                                            builder: (BuildContext context,
                                                AsyncSnapshot snapshot) {
                                              if (snapshot.hasError) {
                                                return Padding(
                                                  padding: EdgeInsets.only(
                                                      left:
                                                          screenHeight / 30.0),
                                                  child: Text(
                                                    'Unable to load data',
                                                    style: TextStyle(
                                                        fontSize: 14.0,
                                                        color: Colors.black),
                                                  ),
                                                );
                                              } else if (snapshot.hasData) {
                                                final user = snapshot.data;
                                                return user == null
                                                    ? Center(
                                                        child: Text(
                                                            'No User Found'),
                                                      )
                                                    : Text(
                                                        " Record For ${user.name}",
                                                        style: TextStyle(
                                                            fontFamily: 'rubik',
                                                            color: Color(
                                                                0xff677294),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      );
                                              } else {
                                                return Center(
                                                  child: Text('Loading ...',
                                                      style: TextStyle(
                                                          color: Colors.black)),
                                                );
                                              }
                                            },
                                          ),
                                          Text(
                                            "1 Prescription",
                                            style: TextStyle(
                                              color: Color(0xff677294),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        );
                      }),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => Medical_Reports()),
            ),
          ),
        ),
      ),
    );
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
