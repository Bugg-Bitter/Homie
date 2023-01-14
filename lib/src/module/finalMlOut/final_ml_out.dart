import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_close_app/flutter_close_app.dart';
import 'package:homie/src/utils/date_utils.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../config/config.dart';
import '../../utils/drawDownTriangles.dart';
import '../../utils/drawUpTriangles.dart';
import '../dailyReport/updatePage/components/back_button_ttile.dart';
import '../dailyReport/updatePage/components/homebackbutton.dart';
import '../mlInputs/mlInputSectionName.dart';

class FinalMlOutStart extends StatelessWidget {
  final String inParam1;
  final String inParam2;
  final String inParam3;
  final String inParam4;
  const FinalMlOutStart({
    super.key,
    required this.inParam1,
    required this.inParam2,
    required this.inParam3,
    required this.inParam4,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FinalMlOutUI(finalSectionName: 'Body Temperature'),
    );
  }
}

class FinalMlOutUI extends StatefulWidget {
  final String finalSectionName;
  const FinalMlOutUI({super.key, required this.finalSectionName});

  @override
  State<FinalMlOutUI> createState() => _FinalMlOutUIState();
}

class _FinalMlOutUIState extends State<FinalMlOutUI> {
  int progressBarOrangeIntValue = 0;
  int progressBarGreenIntValue = 0;
  int progressBarPurpleIntValue = 0;
  int orangeStateVal = 0;
  int greenStateVal = 0;
  int purpleStateVal = 0;
  bool isOrange = false;
  bool isGreen = false;
  bool isPurple = false;

  @override
  void initState() {
    super.initState();
    orageProgressBar = DateUtilss().multiLinearRegressionDub(85, 35);
    greenProgressBar = DateUtilss().multiLinearRegressionDub(70, 60);
    purpleProgressBar = DateUtilss().multiLinearRegressionDub(85, 35);
    progressBarOrangeIntValue = (orageProgressBar * 100).toInt();
    progressBarGreenIntValue = (greenProgressBar * 100).toInt();
    progressBarPurpleIntValue = (purpleProgressBar * 100).toInt();
    orangeStateVal =
        (DateUtilss().multiLinearRegressionDub(85, 35) * 100).toInt();
    greenStateVal =
        (DateUtilss().multiLinearRegressionDub(85, 35) * 100).toInt();
    purpleStateVal =
        (DateUtilss().multiLinearRegressionDub(85, 35) * 100).toInt();
    isOrange = DateUtilss().multiLinearRegressionBool();
    isGreen = DateUtilss().multiLinearRegressionBool();
    isPurple = DateUtilss().multiLinearRegressionBool();
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
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
              MlInputsSection(
                section: widget.finalSectionName,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                child: Container(
                  width: double.infinity,
                  height: 180.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: LineChart(
                    LineChartData(
                      maxX: 8,
                      maxY: 8,
                      minX: 0,
                      minY: 0,
                      borderData: FlBorderData(
                          show: true,
                          border: Border.all(color: Colors.white, width: 1.2)),
                      lineBarsData: [
                        LineChartBarData(
                          spots: [
                            FlSpot(DateUtilss().multiLinearRegressionInt(8, 1),
                                DateUtilss().multiLinearRegressionInt(8, 1)),
                            FlSpot(DateUtilss().multiLinearRegressionInt(9, 1),
                                DateUtilss().multiLinearRegressionInt(8, 1)),
                            FlSpot(DateUtilss().multiLinearRegressionInt(8, 1),
                                DateUtilss().multiLinearRegressionInt(8, 1)),
                            FlSpot(DateUtilss().multiLinearRegressionInt(8, 1),
                                DateUtilss().multiLinearRegressionInt(8, 1)),
                            FlSpot(DateUtilss().multiLinearRegressionInt(8, 1),
                                DateUtilss().multiLinearRegressionInt(8, 1)),
                            FlSpot(DateUtilss().multiLinearRegressionInt(8, 1),
                                DateUtilss().multiLinearRegressionInt(8, 1)),
                            FlSpot(DateUtilss().multiLinearRegressionInt(8, 1),
                                DateUtilss().multiLinearRegressionInt(8, 1)),
                            FlSpot(DateUtilss().multiLinearRegressionInt(8, 1),
                                DateUtilss().multiLinearRegressionInt(8, 1)),
                          ],
                          isCurved: true,
                          barWidth: 4,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                child: Container(
                  height: 140.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xffeaeaea),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              height: 80.0,
                              width: 80.0,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    Colors.yellowAccent,
                                    Colors.orange,
                                    Colors.deepOrangeAccent,
                                  ], stops: [
                                    0.0,
                                    0.5,
                                    0.7
                                  ]),
                                  borderRadius: BorderRadius.circular(50.0)),
                              child: Stack(
                                children: [
                                  Center(
                                    child: CircularPercentIndicator(
                                      animateFromLastPercent: true,
                                      center: Text(
                                        "${progressBarOrangeIntValue}%",
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                      backgroundColor: Colors.transparent,
                                      lineWidth: 2.5,
                                      percent: orageProgressBar.toDouble(),
                                      progressColor: Colors.white,
                                      radius: 37.0,
                                      circularStrokeCap: CircularStrokeCap.round,
                                      animation: true,
                                      animationDuration: 1000,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: 80.0,
                              width: 80.0,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    Colors.greenAccent,
                                    Colors.teal,
                                  ], stops: [
                                    0.0,
                                    0.7
                                  ]),
                                  borderRadius: BorderRadius.circular(50.0)),
                              child: Stack(
                                children: [
                                  Center(
                                    child: CircularPercentIndicator(
                                      center: Text(
                                        "$progressBarGreenIntValue%",
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                      backgroundColor: Colors.transparent,
                                      lineWidth: 2.5,
                                      percent: greenProgressBar,
                                      progressColor: Colors.white,
                                      radius: 37.0,
                                      circularStrokeCap: CircularStrokeCap.round,
                                      animation: true,
                                      animationDuration: 1000,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: 80.0,
                              width: 80.0,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    Colors.redAccent,
                                    Colors.purple,
                                  ], stops: [
                                    0.0,
                                    0.7
                                  ]),
                                  borderRadius: BorderRadius.circular(50.0)),
                              child: Stack(
                                children: [
                                  Center(
                                    child: CircularPercentIndicator(
                                      center: Text(
                                        "$progressBarPurpleIntValue%",
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                      backgroundColor: Colors.transparent,
                                      lineWidth: 2.5,
                                      percent: purpleProgressBar,
                                      progressColor: Colors.white,
                                      radius: 37.0,
                                      circularStrokeCap: CircularStrokeCap.round,
                                      animation: true,
                                      animationDuration: 1000,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 10.0,
                                  width: 10.0,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: [
                                        Colors.yellowAccent,
                                        Colors.orange,
                                        Colors.deepOrangeAccent,
                                      ], stops: [
                                        0.0,
                                        0.5,
                                        0.7
                                      ]),
                                      borderRadius: BorderRadius.circular(50.0)),
                                ),
                                Text(
                                  " $orangeStateVal",
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 10.0),
                                  child: CustomPaint(
                                      size: Size(10, 10),
                                      painter: isOrange == true
                                          ? DrawDownTriangleShape()
                                          : DrawUpTriangleShape()),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 10.0,
                                  width: 10.0,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: [
                                        Colors.greenAccent,
                                        Colors.teal,
                                      ], stops: [
                                        0.0,
                                        0.7
                                      ]),
                                      borderRadius: BorderRadius.circular(50.0)),
                                ),
                                Text(
                                  " $greenStateVal",
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 10.0),
                                  child: CustomPaint(
                                      size: Size(10, 10),
                                      painter: isGreen == true
                                          ? DrawDownTriangleShape()
                                          : DrawUpTriangleShape()),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 10.0,
                                  width: 10.0,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: [
                                        Colors.redAccent,
                                        Colors.purple,
                                      ], stops: [
                                        0.0,
                                        0.7
                                      ]),
                                      borderRadius: BorderRadius.circular(50.0)),
                                ),
                                Text(
                                  " $purpleStateVal",
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 10.0),
                                  child: CustomPaint(
                                      size: Size(10, 10),
                                      painter: isPurple == true
                                          ? DrawDownTriangleShape()
                                          : DrawUpTriangleShape()),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                child: Container(
                  width: double.infinity,
                  height: 150.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              "Health Condition Prediction $orangeStateVal %",
                              style: TextStyle(
                                  color: Color(0xff6f6f6f), fontSize: 18.0),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                             orangeStateVal < 31 ? "Visit doctor as soon as possible" : orangeStateVal < 61 ?"Take a basic health check up" : "Just keep a healthy diet",
                              style: TextStyle(
                                  color: Color(0xff6f6f6f), fontSize: 18.0),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
