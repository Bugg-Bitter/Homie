import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../config/config.dart';
import '../../config/updateConfig.dart';
import '../config/firebaseApi.dart';

class UpdateProfileStart extends StatelessWidget {
  const UpdateProfileStart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UpdateProfileUI(),
    );
  }
}

class UpdateProfileUI extends StatefulWidget {
  const UpdateProfileUI({Key? key}) : super(key: key);

  @override
  State<UpdateProfileUI> createState() => _UpdateProfileUIState();
}

class _UpdateProfileUIState extends State<UpdateProfileUI> {
    File? image;
    
  Future _chooseImage() async {
    try {
      XFile? image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
    );
    if(image == null) return;
    final imageTemp = File(image.path);
    setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('failed');
    }
}
  final picker = ImagePicker();
  bool _secureText = true;
  TextEditingController updatedNameController = TextEditingController();
  TextEditingController updatedGenderController = TextEditingController();
  TextEditingController updatedEmailController = TextEditingController();
  TextEditingController updatedDOBController = TextEditingController();
  TextEditingController updatedCellController = TextEditingController();
  TextEditingController updatedPasswordController = TextEditingController();
  
  String? loggedInUserMail = '';
  @override
  void initState() {
    
    super.initState();
    getEmail();
  }
  @override
  Widget build(BuildContext context) {
    double ScreenWidth = MediaQuery.of(context).size.width;
    double ScreenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Positioned(
                      child: SvgPicture.asset(
                        'asset/updatepage/updateBanner.svg',
                        width: ScreenWidth,
                        color: Color(0xFF043BB8),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        'UPDATE YOUR\nINFORMATION',
                        style: TextStyle(
                            letterSpacing: 1.9,
                            color: Colors.white,
                            fontSize: 30,
                            fontFamily: 'awesome',
                            fontWeight: FontWeight.w400),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: ScreenHeight / 50.0),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _chooseImage();
                        },
                        child: image != null ? 
                        CircleAvatar(
                          backgroundImage:FileImage(image!),
                          radius: 55,
                        )
                         :
                        CircleAvatar(
                          backgroundImage:
                              AssetImage('asset/updatepage/black.png'),
                          radius: 55,
                        ),
                      ),
                      image == null ?
                      GestureDetector(
                        onTap: () {
                          _chooseImage();
                        },
                        child: SvgPicture.asset(
                          'asset/updatepage/plus.svg',
                          color: Colors.white,
                          height: 60,
                        ),
                      ):Container(),
                    ],
                  ),
                ),
          
                /// Updated Name
                Padding(
                  padding: EdgeInsets.only(
                      top: ScreenHeight / 40.0, right: 40, left: 40),
                  child: TextFormField(
                    controller: updatedNameController,
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
                        hintText: "  ${updatedHintTxts[0]}",
                        fillColor: Colors.white70),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return '${updatedErrorTxts[0]}';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
          
                /// Updated Gender
                Padding(
                  padding: EdgeInsets.only(
                      top: ScreenHeight / 40.0, right: 40, left: 40),
                  child: TextFormField(
                    controller: updatedGenderController,
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
                        hintText: "  ${updatedHintTxts[1]}",
                        fillColor: Colors.white70),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return '${updatedErrorTxts[1]}';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
          
                /// updated Mail
                Padding(
                  padding: EdgeInsets.only(
                      top: ScreenHeight / 40.0, right: 40, left: 40),
                  child: TextFormField(
                    controller: updatedEmailController,
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
                        hintText: "  ${updatedHintTxts[2]}",
                        fillColor: Colors.white70),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return '${updatedErrorTxts[2]}';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
          
                /// updated Date
                Padding(
                  padding: EdgeInsets.only(
                      top: ScreenHeight / 40.0, right: 40, left: 40),
                  child: TextFormField(
                    controller: updatedDOBController,
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
                        hintText: "  ${updatedHintTxts[3]}",
                        fillColor: Colors.white70),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return '${updatedErrorTxts[3]}';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
          
                /// updated Phone no.
                Padding(
                  padding: EdgeInsets.only(
                      top: ScreenHeight / 40.0, right: 40, left: 40),
                  child: TextFormField(
                    controller: updatedCellController,
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
                        hintText: "  ${updatedHintTxts[4]}",
                        fillColor: Colors.white70),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return '${updatedErrorTxts[4]}';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                /// updated Password no.
                Padding(
                  padding: EdgeInsets.only(
                      top: ScreenHeight / 40.0, right: 40, left: 40),
                  child: TextFormField(
                    controller: updatedPasswordController,
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
                        hintText: "  ${updatedHintTxts[5]}",
                        fillColor: Colors.white70),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return '${updatedErrorTxts[5]}';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: ScreenHeight / 19.0,
                    bottom: ScreenHeight / 20.0
                  ),
                  child: SizedBox(
                    width: ScreenWidth / 2.0,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        updateInfoTracker++;
                        final docUser = FirebaseFirestore.instance.collection('newUser').doc(updatedEmailController.text.trim());

                        docUser.update({
                          'name':updatedNameController.text,
                          'password':updatedPasswordController.text,
                          'phone':updatedCellController.text,
                          'gender':updatedGenderController.text,
                          'email':updatedEmailController.text,
                          'dateOfBirth':updatedDOBController.text,
                        });
                        _updatedUser(updatedEmailController.text.trim(),
                        updatedPasswordController.text.trim());
                        uploadProfilePic();
                        updatedNameController.clear();
                        updatedPasswordController.clear();
                        updatedGenderController.clear();
                        updatedEmailController.clear();
                        updatedDOBController.clear();
                        updatedCellController.clear();
                      },
                      child: Text(
                        'Update',
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'montserrat',
                            fontWeight: FontWeight.w400),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xFF0B63F6)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future _updatedUser(String newEmail,String newPass)async{
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: newEmail, password: newPass);
    print('Successfully created new user !');
  } on FirebaseAuthException catch (e) {
    print("Exception is $e");
  }
}
  Future<String?> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
     setState(() {
       loggedInUserMail =   prefs.getString('userEmail');
       print(loggedInUserMail);
     });
     return loggedInUserMail;
  }
Future uploadProfilePic()async {

  if(image == null){
    return;
  }
  SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('updatedName', updatedNameController.text);
      prefs.setString('updatedBirth', updatedDOBController.text);
      prefs.setString('updatedPhone', updatedCellController.text);
  final filename = loggedInUserMail;
  final destination = 'newUsersProfilePic/$filename';
  FirebaseApi.uploadFile(destination,image!);
}
}