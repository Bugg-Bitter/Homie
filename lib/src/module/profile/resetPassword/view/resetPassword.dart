import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ResetPasswordStart extends StatelessWidget {
  const ResetPasswordStart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ResetPasswordUI(),
    );
  }
}

class ResetPasswordUI extends StatefulWidget {
  const ResetPasswordUI({Key? key}) : super(key: key);

  @override
  State<ResetPasswordUI> createState() => _ResetPasswordUIState();
}

class _ResetPasswordUIState extends State<ResetPasswordUI> {
    final spinKit = SpinKitRing(
    color: Color(0xff16EE74),
    size: 70.0,
  );
  TextEditingController resetEmailController = TextEditingController();

   resetMailMsg(String? msg){

  SnackBar(
      duration: Duration(milliseconds: 1500),
      content: Text(
        msg!,
        style: TextStyle(
          color: Color(0xffD9D9D9),
          fontFamily: 'GoogleSans',
          fontSize: 15.0,
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    double ScreenHeight = MediaQuery.of(context).size.height;
    double ScreenWidth = MediaQuery.of(context).size.width;
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
                        'asset/signup/bkimg.svg',
                        width: ScreenWidth,
                        color: Color(0xFF043BB8),
                      ),
                    ),
                    Text(
                      'Reset Password',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                Container(
                  height: ScreenHeight / 5.0,
                  width: double.infinity,
                  child: Center(
                      child: Text(
                    'Receive an Email to\n  Reset your password',
                    style: TextStyle(
                        fontSize: 17.0, fontWeight: FontWeight.w600),
                  )),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: ScreenHeight / 40.0, right: 40, left: 40),
                  child: TextFormField(
                    mouseCursor: MouseCursor.defer,
                    controller: resetEmailController,
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
                        hintText: "Enter Your Email",
                        fillColor: Colors.white70),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Email Properly';
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
                        _resetPassword();
                      },
                      child: Text(
                        '🗝️ Reset Password',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'montserrat',
                            fontWeight: FontWeight.w600),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Future _resetPassword() async{
    
try {
  await FirebaseAuth.instance.sendPasswordResetEmail(email: resetEmailController.text.trim());
  showDialog(context: context, 
    barrierDismissible: false,
    builder:(BuildContext context) => Center(
                child: Container(
              height: double.infinity,
              width: double.infinity,
              color: Color(0xff1A1A1A),
              child: spinKit,
            )));
    resetMailMsg('Password Reset Email sent');
    Navigator.of(context).popUntil((route) => route.isFirst);
} on FirebaseAuthException catch (e) {
  resetMailMsg(e.message);
  Navigator.of(context).pop();
}

    
  }
}
