import 'package:flutter/material.dart';
import 'package:homie/src/module/finalMlOut/final_ml_out.dart';

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
  String? loggedInUserMail = '';
  TextEditingController param1 = TextEditingController();
  TextEditingController param2 = TextEditingController();
  TextEditingController param3 = TextEditingController();
  TextEditingController param4 = TextEditingController();
  String checkParam1 = '';
  String checkParam2 = '';
  String checkParam3 = '';
  String checkParam4 = '';
  @override
  Widget build(BuildContext context) {
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
                FutureBuilder(
                    future: storage
                        .userProfilePicDownloadURL('${loggedInUserMail}'),
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done &&
                          snapshot.hasData) {
                        return InfoTemplate(
                            userName: "Evan", imageUrl: "${snapshot.data!}");
                      }
                      if (snapshot.connectionState == ConnectionState.waiting ||
                          !snapshot.hasData) {
                        return InfoTemplate(
                            userName: "Evan", imageUrl: "$dummyPics");
                      } else {
                        return Container();
                      }
                    }),
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
                                            builder: (((context) =>
                                                FinalMlOutStart(
                                                    inParam1: param1.text,
                                                    inParam2: param2.text,
                                                    inParam3: param3.text,
                                                    inParam4: param4.text)))));
                                  }
                                }
                              }
                              // param1.text = "";
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
}
