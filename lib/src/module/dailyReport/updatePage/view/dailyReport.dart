import 'package:flutter/material.dart';
import 'package:flutter_close_app/flutter_close_app.dart';
import 'package:homie/src/config/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../search/config/search_config.dart';
import '../components/section_title.dart';
import '../components/user_info_template.dart';

class DailyReportStart extends StatefulWidget {
  const DailyReportStart({super.key});

  @override
  State<DailyReportStart> createState() => _DailyReportStartState();
}

class _DailyReportStartState extends State<DailyReportStart> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DailyReportUI(),
    );
  }
}

class DailyReportUI extends StatefulWidget {
  const DailyReportUI({super.key});

  @override
  State<DailyReportUI> createState() => _DailyReportUIState();
}

class _DailyReportUIState extends State<DailyReportUI> {
  String? loggedInUserMail = '';
  String? userName = '';

  @override
  void initState() {
    super.initState();
    getEmail();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterCloseAppPage(
      interval: 2,
      condition: true,
      onCloseFailed: () {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Press again to exit 🎉'),
        ));
      },
      child: Scaffold(
        backgroundColor: Color(0xffd7d9ef),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 70.0),
                child: FutureBuilder(
                    future: storage
                        .userProfilePicDownloadURL('${loggedInUserMail}'),
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done &&
                          snapshot.hasData) {
                        return InfoTemplate(
                            userName: "Sadman Shouviq ",
                            imageUrl: "${snapshot.data!}");
                      }
                      if (snapshot.connectionState == ConnectionState.waiting ||
                          !snapshot.hasData) {
                        return Text(
                          "Loading",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 24.0,
                              fontFamily: 'rubik'),
                        );
                      } else {
                        return Container();
                      }
                    }),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: predictionList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.only(
                            top: 18.0, left: 20.0, right: 20.0, bottom: 20.0),
                        child: SectionTitle(
                            sectionTitle: "${predictionList[index]}"),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
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
