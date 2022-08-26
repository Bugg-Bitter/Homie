import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:homie/src/module/login/views/login.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SignUpStart extends StatelessWidget {
  const SignUpStart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignUpUI(),
    );
  }
}

class SignUpUI extends StatefulWidget {
  const SignUpUI({Key? key}) : super(key: key);

  @override
  State<SignUpUI> createState() => _SignUpUIState();
}

class _SignUpUIState extends State<SignUpUI> {
  bool _secureText = true;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  List<String> fieldTxts = [
    'Full Name',
    'Gender',
    'Email Address',
    'Date of Birth',
    'Phone Number',
    'Password'
  ];
  List<String> errorfieldTxts = [
    'Required Name',
    'Required Gender',
    'Required email',
    'Required Date of birth',
    'Required Phone no.',
    'Required Password'
  ];

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double ScreenWidth = MediaQuery.of(context).size.width;
    double ScreenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        // resizeToAvoidBottomInset: true,
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Positioned(
                      child: SvgPicture.asset(
                        'asset/signup/bkimg.svg',
                        width: ScreenWidth,
                        color: Color(0xFF043BB8),
                      ),
                    ),
                    Text(
                      'Create New Account',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),

                /// Full Name
                Padding(
                  padding: EdgeInsets.only(
                      top: ScreenHeight / 40.0, right: 40, left: 40),
                  child: TextFormField(
                    controller: fullNameController,
                    decoration: InputDecoration(
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        errorStyle: TextStyle(
                            fontFamily: 'montserrat',
                            fontSize: 14.0,
                            color: Colors.redAccent),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[800]),
                        hintText: "  ${fieldTxts[0]}",
                        fillColor: Colors.white70),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return '${errorfieldTxts[0]}';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),

                /// Gender
                Padding(
                  padding: EdgeInsets.only(
                      top: ScreenHeight / 40.0, right: 40, left: 40),
                  child: TextFormField(
                    mouseCursor: MouseCursor.defer,
                    controller: genderController,
                    decoration: InputDecoration(
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        errorStyle: TextStyle(
                            fontFamily: 'montserrat',
                            fontSize: 14.0,
                            color: Colors.redAccent),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[800]),
                        hintText: "  ${fieldTxts[1]}",
                        fillColor: Colors.white70),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return '${errorfieldTxts[1]}';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),

                /// Email
                Padding(
                  padding: EdgeInsets.only(
                      top: ScreenHeight / 40.0, right: 40, left: 40),
                  child: TextFormField(
                    mouseCursor: MouseCursor.defer,
                    controller: emailController,
                    decoration: InputDecoration(
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        errorStyle: TextStyle(
                            fontFamily: 'montserrat',
                            fontSize: 14.0,
                            color: Colors.redAccent),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[800]),
                        hintText: "  ${fieldTxts[2]}",
                        fillColor: Colors.white70),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return '${errorfieldTxts[2]}';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),

                /// DOB
                Padding(
                  padding: EdgeInsets.only(
                      top: ScreenHeight / 40.0, right: 40, left: 40),
                  child: TextFormField(
                    mouseCursor: MouseCursor.defer,
                    controller: dobController,
                    decoration: InputDecoration(
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        errorStyle: TextStyle(
                            fontFamily: 'montserrat',
                            fontSize: 14.0,
                            color: Colors.redAccent),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[800]),
                        hintText: "  ${fieldTxts[3]}",
                        fillColor: Colors.white70),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return '${errorfieldTxts[3]}';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),

                /// Phone
                Padding(
                  padding: EdgeInsets.only(
                      top: ScreenHeight / 40.0, right: 40, left: 40),
                  child: TextFormField(
                    mouseCursor: MouseCursor.defer,
                    controller: phoneController,
                    decoration: InputDecoration(
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        errorStyle: TextStyle(
                            fontFamily: 'montserrat',
                            fontSize: 14.0,
                            color: Colors.redAccent),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[800]),
                        hintText: "  ${fieldTxts[4]}",
                        fillColor: Colors.white70),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return '${errorfieldTxts[4]}';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),

                /// Password
                Padding(
                  padding: EdgeInsets.only(
                      top: ScreenHeight / 40.0, right: 40, left: 40),
                  child: TextFormField(
                    mouseCursor: MouseCursor.defer,
                    controller: passwordController,
                    decoration: InputDecoration(
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        errorStyle: TextStyle(
                            fontFamily: 'montserrat',
                            fontSize: 14.0,
                            color: Colors.redAccent),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[800]),
                        hintText: "  ${fieldTxts[5]}",
                        fillColor: Colors.white70),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return '${errorfieldTxts[5]}';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: ScreenHeight / 25.0,
                      left: ScreenWidth / 10.0,
                      right: ScreenWidth / 10.0,
                      bottom: ScreenHeight / 640.0),
                  child: SizedBox(
                    width: ScreenWidth / 1.5,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if ((fullNameController.text != '') &&
                            (genderController.text != '') &&
                            (emailController.text != '') &&
                            (dobController.text != '') &&
                            (phoneController.text != '') &&
                            (passwordController.text != '')) {
                          final fullName = fullNameController.text;
                          final fullGender = genderController.text;
                          final fullEmail = emailController.text;
                          final fullDateOfBirth = dobController.text;
                          final fullPhoneNumber = phoneController.text;
                          final fullPassword = passwordController.text;
                          createNewUser(
                              newName: fullName,
                              newGender: fullGender,
                              newEmail: fullEmail,
                              newDOB: fullDateOfBirth,
                              newPhone: fullPhoneNumber,
                              newPassword: fullPassword);
                        }
                        fullNameController.clear();
                        genderController.clear();
                        emailController.clear();
                        dobController.clear();
                        phoneController.clear();
                        passwordController.clear();
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'montserrat',
                            fontWeight: FontWeight.w800),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xFF0B63F6)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: ScreenHeight / 60.0),
                  child: RichText(
                    text: TextSpan(
                        text: "Already have an account?\t",
                        style: TextStyle(color: Color(0xFF686C79)),
                        children: [
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => {
                                    Navigator.pop(context),
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoginScreen())),
                                  },
                            text: 'SIGN IN!',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: Colors.blueAccent,
                            ),
                          ),
                        ]),
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

Future createNewUser(
    {required String newName,
    required String newGender,
    required String newEmail,
    required String newDOB,
    required String newPhone,
    required String newPassword}) async {
  final newPersonInfo =
      FirebaseFirestore.instance.collection('newUser').doc(newEmail);
  final jsonData = {
    'name': newName,
    'gender': newGender,
    'email': newEmail,
    'dateOfBirth': newDOB,
    'phone': newPhone,
    'password': newPassword,
  };

  await newPersonInfo.set(jsonData);
}
