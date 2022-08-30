// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:homie/src/config/config.dart';
import 'package:homie/src/module/search/components/search_info_component.dart';
import '../config/search_config.dart';

class SearchStart extends StatelessWidget {
  const SearchStart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SearchUI(),
    );
  }
}

class SearchUI extends StatefulWidget {
  const SearchUI({Key? key}) : super(key: key);

  @override
  State<SearchUI> createState() => _SearchUIState();
}

class _SearchUIState extends State<SearchUI> {
  @override
  Widget build(BuildContext context) {
    double ScreenHeight = MediaQuery.of(context).size.height;
    double ScreenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Color(0xFFFAFAFE),
          child: Expanded(
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'asset/search/banner.png',
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          ScreenWidth / 7.0,
                          ScreenHeight / 8.0,
                          ScreenWidth / 7.0,
                          ScreenHeight / 50.0),
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
                            hintText: " Search Doctor",
                            fillColor: Colors.white),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            flagOfmodules = 1;
                            searchResult = 'Doctors';
                          });
                        },
                        child: Container(
                          height: 80.0,
                          width: 80.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Color(0xFFFAE9E9),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.medical_services_rounded,
                                color: Color(0xFFE35F47),
                              ),
                              Text('Doctors'),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            flagOfmodules = 2;
                            searchResult = 'Pharmacy';
                          });
                        },
                        child: Container(
                          height: 80.0,
                          width: 80.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Color(0xFFFAE9E9),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.medication,
                                color: Color(0xFF1648CE),
                              ),
                              Text('Pharmacy'),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            flagOfmodules = 3;
                            searchResult = 'Hospitals';
                          });
                        },
                        child: Container(
                          height: 80.0,
                          width: 80.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Color(0xFFFAE9E9),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.local_hospital_rounded,
                                color: Color(0xFF117639),
                              ),
                              Text('Hospitals'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0, left: 40.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Search Results for $searchResult',
                      style: TextStyle(
                        fontFamily: 'montserrat',
                        fontSize: 24.0,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF6A788E),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: totalDoctor,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      if (flagOfmodules == 1) {
                        return FutureBuilder(
                            future: storage
                                .docDownloadURL('${Designations[index]}.jpeg'),
                            builder: (BuildContext context,
                                AsyncSnapshot<String> snapshot) {
                              if (snapshot.connectionState ==
                                      ConnectionState.done &&
                                  snapshot.hasData) {
                                return InfoComponent(
                                    ScreenHeight: ScreenHeight,
                                    imageLink: snapshot.data!,
                                    listNames: DocNames,
                                    listInfo: Designations,
                                    index: index,
                                    currentStateTitle: 'Doctor',);
                              }
                              if (snapshot.connectionState ==
                                      ConnectionState.waiting ||
                                  !snapshot.hasData) {
                                return Center(
                                    child: Padding(
                                  padding:
                                      EdgeInsets.only(top: ScreenHeight / 20.0),
                                  child: Container(
                                      height: 40,
                                      width: 40,
                                      child: CircularProgressIndicator()),
                                ));
                              } else {
                                return Container();
                              }
                            });
                      } else if (flagOfmodules == 2) {
                        return FutureBuilder(
                            future: storage.pharmDownloadURL(
                                '${pharmacyImages[index]}.jpeg'),
                            builder: (BuildContext context,
                                AsyncSnapshot<String> snapshot) {
                              if (snapshot.connectionState ==
                                      ConnectionState.done &&
                                  snapshot.hasData) {
                                return InfoComponent(
                                    ScreenHeight: ScreenHeight,
                                    imageLink: snapshot.data!,
                                    listNames: pharmacyNames,
                                    listInfo: Designations,
                                    index: index,currentStateTitle: 'Pharmacy',);
                              }
                              if (snapshot.connectionState ==
                                      ConnectionState.waiting ||
                                  !snapshot.hasData) {
                                return Center(
                                    child: Padding(
                                  padding:
                                      EdgeInsets.only(top: ScreenHeight / 20.0),
                                  child: Container(
                                      height: 40,
                                      width: 40,
                                      child: CircularProgressIndicator()),
                                ));
                              } else {
                                return Container();
                              }
                            });
                      } else {
                        return FutureBuilder(
                            future: storage.hosDownloadURL(
                                '${hospitalImages[index]}.jpeg'),
                            builder: (BuildContext context,
                                AsyncSnapshot<String> snapshot) {
                              if (snapshot.connectionState ==
                                      ConnectionState.done &&
                                  snapshot.hasData) {
                                return InfoComponent(
                                    
                                    ScreenHeight: ScreenHeight,
                                    imageLink: snapshot.data!,
                                    listNames: hospitalNames,
                                    listInfo: Designations,
                                    index: index,
                                    currentStateTitle: 'Hospitals',);
                              }
                              if (snapshot.connectionState ==
                                      ConnectionState.waiting ||
                                  !snapshot.hasData) {
                                return Center(
                                    child: Padding(
                                  padding:
                                      EdgeInsets.only(top: ScreenHeight / 20.0),
                                  child: Container(
                                      height: 40,
                                      width: 40,
                                      child: CircularProgressIndicator()),
                                ));
                              } else {
                                return Container();
                              }
                            });
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
