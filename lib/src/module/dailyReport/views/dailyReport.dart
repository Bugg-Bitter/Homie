import 'package:flutter/material.dart';
import 'package:homie/src/config/config.dart';
import 'package:homie/src/utils/date_utils.dart' as date_util;

import '../components/addButton.dart';
import '../components/dropBox.dart';
import '../components/textInput.dart';

class DailyReportStart extends StatelessWidget {
  const DailyReportStart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DailyReportUI(),
    );
  }
}

class DailyReportUI extends StatefulWidget {
  const DailyReportUI({Key? key}) : super(key: key);

  @override
  State<DailyReportUI> createState() => _DailyReportUIState();
}

class _DailyReportUIState extends State<DailyReportUI> {
  DateTime currentDateTime = DateTime.now();
  List<DateTime> currentMonthList = List.empty();
  late ScrollController scrollController;
  @override
  void initState() {
    super.initState();
    currentMonthList = date_util.DateUtils.daysInMonth(currentDateTime);
    currentMonthList.sort((a, b) => a.day.compareTo(b.day));
    currentMonthList = currentMonthList.toSet().toList();
    scrollController =
        ScrollController(initialScrollOffset: 80.0 * currentDateTime.day);
  }

  @override
  Widget build(BuildContext context) {
    double ScreenHeight = MediaQuery.of(context).size.height;
    double ScreenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.only(top: ScreenHeight / 25.0),
                  child: Text(
                    date_util.DateUtils.months[currentDateTime.month - 1] +
                        ' ' +
                        currentDateTime.year.toString(),
                    style: TextStyle(
                      fontFamily: 'montserrat',
                      fontSize: 20.0,
                      color: Color(0xFF929CAD),
                    ),
                  )),
              Text(
                'Today',
                style: TextStyle(
                  // fontFamily: 'montserrat',
                  color: Colors.black,
                  fontSize: 25.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              horizontalDates(ScreenWidth, ScreenHeight),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 24.0, right: 24.0, top: 24.0),
                    child: Column(
                      children: [
                        TextInput(
                          headertext: "Pulse Rate",
                          boxheight: 30.0,
                          errorMsg: 'Enter Pulse Rate',
                          validatorKey: pulseRatefromKey,
                          nesController: pulseRateController,

                        ),
                        SizedBox(height: 10.0),
                        TextInput(
                          headertext: "Blood Pressure (B/P):",
                          boxheight: 30.0,
                          errorMsg: 'Enter B/P',
                          validatorKey: BPfromKey, 
                          nesController: BPController,
                        ),
                        SizedBox(height: 10.0),
                        TextInput(
                          headertext: "O2 Saturation Level:",
                          boxheight: 30.0,
                          errorMsg: 'Enter O2 Saturation Level',
                          validatorKey: O2fromKey, 
                          nesController: O2Controller,
                        ),
                        SizedBox(height: 10.0),
                        TextInput(
                          headertext: "Body Temperature (In C°):",
                          boxheight: 30.0,
                          errorMsg: 'Enter Body Temperature (In C°)',
                          validatorKey: tempInfromKey, 
                          nesController: tempInController,
                        ),
                        SizedBox(height: 10.0),
                        TextInput(
                            headertext: "Diabetes (Before Meal):",
                            boxheight: 30.0,
                            errorMsg: 'Enter Diabetes (Before Meal)',
                            validatorKey: diabetiesBeforefromKey,
                            nesController: diabetiesBeforeController,
                            ),
                        SizedBox(height: 10.0),
                        TextInput(
                            headertext: "Diabetes (After Meal):",
                            boxheight: 30.0,
                            errorMsg: 'Enter Diabetes (After Meal)',
                            validatorKey: diabetiesAfterfromKey, 
                            nesController: diabetiesAfterController,),
                        SizedBox(height: 10.0),
                        TextInput(
                            headertext: "Weight (In KG):",
                            boxheight: 30.0,
                            errorMsg: 'Enter Weight (In KG)',
                            validatorKey: weightfromKey, 
                            nesController: weightController,),
                        SizedBox(height: 10.0),
                        DropBox(
                          typeName: 'Intercourse:',
                        ),
                        SizedBox(height: 10.0),
                        DropBox(typeName: 'Exercise:'),
                        SizedBox(height: 10.0),
                        TextInput(
                            headertext: "Weather Temperature (In C°):",
                            boxheight: 30.0,
                            errorMsg: 'Enter Weather Temperature (In C°)',
                            validatorKey: weatherformKey, 
                            nesController: weatherController,),
                        SizedBox(height: 10.0),
                        TextInput(
                            headertext: "Extra Notes:",
                            boxheight: 50.0,
                            errorMsg: 'Enter Weather Temperature (In C°)',
                            validatorKey: extraNotesfromKey, 
                            nesController: extraNotesController,),
                        SizedBox(
                          height: 20.0,
                        ),
                        AddButton(),
                        SizedBox(
                          height: 20.0,
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
    );
  }

  Widget horizontalDates(double ScreenWidth, double ScreenHeight) {
    return Container(
      width: ScreenWidth,
      height: ScreenHeight / 10.0,
      child: Padding(
        padding: EdgeInsets.only(top: ScreenHeight / 100.0),
        child: ListView.builder(
            itemCount: currentMonthList.length,
            controller: scrollController,
            scrollDirection: Axis.horizontal,
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return roundedSquareViews(index);
            }),
      ),
    );
  }

  Widget roundedSquareViews(index) {
    return Padding(
        padding: EdgeInsets.only(left: 8.0),
        child: GestureDetector(
          onTap: () {
            setState(() {
              currentDateTime = currentMonthList[index];
            });
          },
          child: Container(
            width: 50,
            alignment: currentMonthList[index].day != currentDateTime.day
                ? Alignment.centerRight
                : Alignment.center,
            decoration: BoxDecoration(
              color: currentMonthList[index].day != currentDateTime.day
                  ? Colors.white
                  : Color(0xFFEFF1FC),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    currentMonthList[index].day.toString(),
                    style: TextStyle(
                        fontFamily: 'montserrat',
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color:
                            (currentMonthList[index].day != currentDateTime.day)
                                ? Colors.black
                                : Color(0xFF1648CE)),
                  ),
                  Text(
                    date_util.DateUtils
                        .weekdays[currentMonthList[index].weekday - 1],
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color:
                            (currentMonthList[index].day != currentDateTime.day)
                                ? Colors.black
                                : Color(0xFF1648CE)),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
