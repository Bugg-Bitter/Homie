import 'package:flutter/material.dart';


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

// Suggested Doctor Numbers [Constant]
const totalDoctor = 6;


// SignUp total TextFields [Constant]
const totalSignUpTextFields = 5;

String signedInEmail = '';
String signedInPass = '';