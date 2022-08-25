import 'package:flutter/material.dart';

// Global Color
const KPrimaryColor = Color(0xFFD9E7FA);
const KPrimaryLightColor = Color(0xFF1E6FF);

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