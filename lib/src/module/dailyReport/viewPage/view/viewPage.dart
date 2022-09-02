import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:homie/src/module/dailyReport/viewPage/components/mobile.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:flutter/src/widgets/framework.dart';

class ViewPageDataStart extends StatelessWidget {
  const ViewPageDataStart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner:false,
      home: ViewPageDataUI(),
    );
  }
}

class ViewPageDataUI extends StatefulWidget {
  const ViewPageDataUI({Key? key}) : super(key: key);

  @override
  State<ViewPageDataUI> createState() => _ViewPageDataUIState();
}

class _ViewPageDataUIState extends State<ViewPageDataUI> {
  int trackedIndex=0;
   Future <void>_createPDF (DailyReports reports) async {
    PdfDocument document = PdfDocument();
    List <String> partitions = (reports.edateWithTime).split(' ');
    final page = document.pages.add();
    page.graphics.drawString('Date : ${(partitions[0])}                Time : ${partitions[1]}', PdfStandardFont(PdfFontFamily.helvetica, 24));
    page.graphics.drawString('\n\n                       Pulse Rate: ${reports.epulse}', PdfStandardFont(PdfFontFamily.helvetica, 24));
    page.graphics.drawString('\n\n\n\n                   Blood Pressure: ${reports.epulse}', PdfStandardFont(PdfFontFamily.helvetica, 24));
    page.graphics.drawString('\n\n\n\n\n\n                   O2 Saturation: ${reports.epulse}', PdfStandardFont(PdfFontFamily.helvetica, 24));
    page.graphics.drawString('\n\n\n\n\n\n\n\n                 Body Temperature: ${reports.epulse}', PdfStandardFont(PdfFontFamily.helvetica, 24));
    page.graphics.drawString('\n\n\n\n\n\n\n\n\n\n                Diabetics Before meal: ${reports.epulse}', PdfStandardFont(PdfFontFamily.helvetica, 24));
    page.graphics.drawString('\n\n\n\n\n\n\n\n\n\n\n\n                    Diabetics After meal: ${reports.epulse}', PdfStandardFont(PdfFontFamily.helvetica, 24));
    page.graphics.drawString('\n\n\n\n\n\n\n\n\n\n\n\n\n\n                          Weight: ${reports.epulse}', PdfStandardFont(PdfFontFamily.helvetica, 24));
    page.graphics.drawString('\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n                        Intercourse: ${reports.epulse}', PdfStandardFont(PdfFontFamily.helvetica, 24));
    page.graphics.drawString('\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n                      Weather Report: ${reports.epulse}', PdfStandardFont(PdfFontFamily.helvetica, 24));
    page.graphics.drawString('\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n                      Extra Notes: ${reports.epulse}', PdfStandardFont(PdfFontFamily.helvetica, 24));
    List<int> bytes = await document.save() ;
    document.dispose();
    saveAndLaunchFile(bytes, 'Generated Report.pdf');
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<List<DailyReports>>(
                stream: readDailyReports(),
                builder: (context,snapshot){
                  if(snapshot.hasError){
                    return Text('Data isn\'t loading');
                  }
                  else if(snapshot.hasData){
                    final reports = snapshot.data!;
                    return ListView(
                      children: reports.map(buildReports).toList(),
                    );
                  }else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
            ),
          ],
        ),
      ),
    ));
  }
  Widget buildReports(DailyReports reports) {
    trackedIndex++;
    double ScreenHeight = MediaQuery.of(context).size.height;
    double ScreenWidth = MediaQuery.of(context).size.width;
    List <String> partitions = (reports.edateWithTime).split(' ');
    return GestureDetector(
      onTap: (){
        _createPDF(reports);
      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(ScreenWidth / 10.0,ScreenHeight / 20.0,ScreenWidth / 10.0,ScreenHeight / 20.0),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.greenAccent,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top:ScreenHeight / 50.0,bottom: ScreenHeight / 50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('Date : ${partitions[0]}'),
                    Text('Time : ${partitions[1]}'),
                  ],
                ),
              ),
              Text("Pulse Rate : ${reports.epulse}"),
              Text("Blood Pressure : ${reports.ebp}"),
              Text("O2 Saturation : ${reports.eo2}"),
              Text("Body temperature : ${reports.etemp}"),
              Text("Diabetics Before : ${reports.ediabeticsBefore}"),
              Text("Diabetics After : ${reports.ediabeticsAfter}"),
              Text("Weight : ${reports.eweight}"),
              Text("Intercourse : ${reports.eintercourse}"),
              Text("Weather Report : ${reports.eweather}"),
              Padding(
                padding: EdgeInsets.only(bottom:ScreenHeight / 50.0),
                child: Text("Extra Notes : ${reports.eextranotes}"),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Stream<List<DailyReports>> readDailyReports() => FirebaseFirestore.instance
      .collection('dailyReports')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => DailyReports.fromJson(doc.data()))
          .toList());
}

class DailyReports {
  final String ebp;
  final String ediabeticsBefore;
  final String ediabeticsAfter;
  final String eextranotes;
  final String eintercourse;
  final String eo2;
  final String epulse;
  final String etemp;
  final String eweather;
  final String eweight;
  final String edateWithTime;

  DailyReports( {
    required this.ebp,
    required this.ediabeticsBefore,
    required this.ediabeticsAfter,
    required this.eextranotes,
    required this.eintercourse,
    required this.eo2,
    required this.epulse,
    required this.etemp,
    required this.eweather,
    required this.eweight,
    required this.edateWithTime,
    // required this.location
  });

  Map<String, dynamic> toJson() => {
        'diabeticsBefore': ediabeticsBefore,
        'diabeticsAfter': ediabeticsAfter,
        'extranotes':eextranotes,
        'temp': etemp,
        'intercourse': eintercourse,
        'o2': eo2,
        'pulse':epulse,
        'weather':eweather,
        'weight':eweight,
        'dateWitTime':edateWithTime,
      };

  static DailyReports fromJson(Map<String, dynamic> json) => DailyReports(
        ebp: json['bp'],
        ediabeticsBefore: json['diabeticsBefore'],
        ediabeticsAfter: json['diabeticsAfter'],
        eextranotes: json['extranotes'],
        eintercourse: json['intercourse'],
        eo2:json['o2'],
        epulse: json['pulse'],
        etemp: json['temp'],
        eweather: json['weather'],
        eweight: json['weight'],
        edateWithTime: json['dateWithTime'],
      );
}
