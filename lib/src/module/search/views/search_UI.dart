import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/page_components/custom_searchbar.dart';
import '../components/page_components/sectors.dart';
import '../components/page_components/selected_sector_list.dart';
import '../components/page_components/ui_banner.dart';
import '../config/search_config.dart';

class SearchStart extends StatelessWidget {
  const SearchStart({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SearchUI(),
    );
  }
}

class SearchUI extends StatefulWidget {
  const SearchUI({super.key});

  @override
  State<SearchUI> createState() => _SearchUIState();
}

class _SearchUIState extends State<SearchUI> {
  String selectedSectorName = 'Doctor';
  String? loggedInUserMail = '';
  String? userName = '';
  String? userDOB = '';
  String? userPhone = '';

  void selectedSector(String sectorName) {
    setState(() {
      selectedSectorName = sectorName;
    });
  }

  Future<void> getOtherInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('updatedName');
      userDOB = prefs.getString('updatedBirth');
      userPhone = prefs.getString('updatedPhone');
    });
  }

  Future<String?> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      loggedInUserMail = prefs.getString('userEmail');
      print(loggedInUserMail);
    });
    return loggedInUserMail;
  }

  @override
  void initState() {
    super.initState();
    getEmail();
    getOtherInfo();
  }

  @override
  Widget build(BuildContext context) {
    double ScreenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Color.fromARGB(255, 194, 194, 244),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FutureBuilder<User?>(
                    future: readUserInfo(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasError) {
                        return Padding(
                          padding: EdgeInsets.only(left: ScreenHeight / 30.0),
                          child: Text(
                            'Unable to load data',
                            style:
                                TextStyle(fontSize: 14.0, color: Colors.black),
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
                        future: storage
                            .userProfilePicDownloadURL('${loggedInUserMail}'),
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
                              padding: EdgeInsets.only(left: 8.0, right: 8.0),
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
              Padding(
                padding: EdgeInsets.only(left: 16.0, top: 10.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Categories",
                    style: TextStyle(
                        fontFamily: 'rubik',
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0),
                  ),
                ),
              ),
              detecedSectors(),
              Padding(
                padding: EdgeInsets.only(top: 50.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Search Results for $selectedSectorName',
                    style: TextStyle(
                      fontFamily: 'rubik',
                      fontSize: 24.0,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SelectedSectorsLists(
                ScreenHeight: ScreenHeight,
                currentSector: selectedSectorName,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding detecedSectors() {
    return Padding(
      padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              selectedSector('Doctor');
            },
            child: Sectors(
              searchResult: 'Doctor',
              searchResultColor: Colors.orangeAccent,
              searchResultIcon: Image.asset('asset/search/doctor.png'),
            ),
          ),
          GestureDetector(
            onTap: () {
              selectedSector('Pharmacy');
            },
            child: Sectors(
              searchResult: 'Pharmacy',
              searchResultColor: Colors.blueAccent,
              searchResultIcon: Image.asset('asset/search/pharmacy.png'),
            ),
          ),
          GestureDetector(
            onTap: () {
              selectedSector('Hospital');
            },
            child: Sectors(
              searchResult: 'Hospital',
              searchResultColor: Colors.redAccent,
              searchResultIcon: Image.asset('asset/search/hospital.png'),
            ),
          ),
        ],
      ),
    );
  }

  Future<User?> readUserInfo() async {
    final onlyDocUser =
        FirebaseFirestore.instance.collection('newUser').doc(loggedInUserMail);
    final snapshot = await onlyDocUser.get();
    if (snapshot.exists) return User.fromJson(snapshot.data()!);
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
