import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

DateTime now = DateTime.now();
String date = DateFormat('yMd').format(now);
DateFormat time = DateFormat.jm();
DateFormat dateAndTime = DateFormat.yMd().add_jm();

// Global update tracker
int updateInfoTracker = 0;

// Global Color
const KPrimaryColor = Color(0xFFD9E7FA);
const KPrimaryLightColor = Color(0xFF1E6FF);

// Global Validator
final pulseRatefromKey = GlobalKey<FormState>();
final BPfromKey = GlobalKey<FormState>();
final O2fromKey = GlobalKey<FormState>();
final tempInfromKey = GlobalKey<FormState>();
final diabetiesBeforefromKey = GlobalKey<FormState>();
final diabetiesAfterfromKey = GlobalKey<FormState>();
final weatherformKey = GlobalKey<FormState>();
final weightfromKey = GlobalKey<FormState>();
final extraNotesfromKey = GlobalKey<FormState>();

// Global Defining Controllers...
final pulseRateController = TextEditingController();
final BPController = TextEditingController();
final O2Controller = TextEditingController();
final tempInController = TextEditingController();
final diabetiesBeforeController = TextEditingController();
final diabetiesAfterController = TextEditingController();
final weatherController = TextEditingController();
final weightController = TextEditingController();
final extraNotesController = TextEditingController();
var intercourseController = '';
var exerciseController = '';
String errorMsg = '';

// Unimplemnted Modules Message
final nonImplementedMsg = MaterialApp(
  debugShowCheckedModeBanner: false,
  home: NonImplementedModules(),
);

class NonImplementedModules extends StatelessWidget {
  const NonImplementedModules({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: Text(
            'This module is under Development !',
            style: TextStyle(
              fontFamily: 'montserrat',
              fontWeight: FontWeight.w800,
              fontSize: 24.0,
            ),
          ),
        ),
      ),
    );
  }
}

@override
Widget snackBaar(BuildContext context) {
  return Scaffold(
    body: Container(
      height: double.infinity,
      width: double.infinity,
      child: SnackBar(
          content: Text(
        'Added to Firebase',
        style: TextStyle(
          fontSize: 18.0,
          fontFamily: 'montserrat',
        ),
      )),
    ),
  );
}

// Firebase Wrong Pass response message..
final wrongPassResponse = SnackBar(
    duration: Duration(milliseconds: 1500),
    content: Text(
      'Wrong Password !',
      style: TextStyle(color: Colors.amberAccent, fontSize: 18.0),
    ));

// Firebase SuccsessFul Login Response
final successResponse = SnackBar(
    duration: Duration(milliseconds: 1500),
    content: Text(
      'Wrong Password !',
      style: TextStyle(color: Colors.amberAccent, fontSize: 18.0),
    ));

// Suggested Doctor Numbers [Constant]
const totalDoctor = 6;

// SignUp total TextFields [Constant]
const totalSignUpTextFields = 5;

String signedInEmail = '';
String signedInPass = '';

List<String> reportsList = [
  'repo1.png',
  'repo2.png',
  'repo3.png',
  'repo4.png',
  'repo5.png',
  'repo6.png',
  'repo7.png',
  'repo8.png',
  'repo9.png',
  'repo10.png',
  'repo11.png',
  'repo12.png',
];

List<String> cardTitles = [
  'Monkeypox Treatment',
  'Unplug and Mind Wander',
  'People Respond Drugs',
  'Foods Can Affect !',
  'Genetic variations',
];

List<String> imgLocation = [
  'asset/homepage/airticle1.png',
  'asset/homepage/airticle2.png',
  'asset/homepage/airticle3.png',
  'asset/homepage/airticle4.png',
  'asset/homepage/airticle5.png',
];

String subtitle =
    "Health experts working globally\n to lessen the outbreak of monkeypox\n as the WHO has recently declared…";

// List of Predicitons
List<String> predictionList = [
  "Body Temperature",
  "Heart Rate",
  "Breathing Rate",
  "Blood Pressure",
  "Blood Sugar",
  "Others",
];

List<String> predictionListPages = [
  "MlInputsUI",
];

const String dummyPics = "https://picsum.photos/200";

/// The Section of suggestions

/// FlowChart Scales...
List<int> xScaleList = [10, 20, 30, 40, 50];
List<int> yScaleList = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

/// Color Accurate
List upOrDownColor = [
  Colors.red,
  Colors.teal,
];

/// Ml Graph Points
List<double> graphXpoints = [0, 1, 2, 3, 4, 5, 6, 7, 8];
List<double> graphYpoints = [0, 2, 6, 4, 2, 1, 5, 6, 4];

/// Section ProgressBar
double orageProgressBar = 0;
double greenProgressBar = 0;
double purpleProgressBar = 0;

/// avg health controller
int healthFlag = 0;
