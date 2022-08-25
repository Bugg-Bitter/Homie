import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:homie/src/config/config.dart';
import 'package:homie/src/module/signup/views/signup_UI.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _secureText = true;
  String userEmail = '';
  String userPassword = '';
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double ScreenHeight = MediaQuery.of(context).size.height;
    double ScreenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: ScreenHeight,
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                ClipPath(
                  clipper: CustomShape(),
                  child: Container(
                    height: 350,
                    color: KPrimaryColor,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: ScreenHeight / 4.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(110),
                    child: SvgPicture.asset('asset/login/doc.svg'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top:  ScreenHeight/2.1),
                  child: Text(
                    'Welcome to',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF9AA0B8),
                      fontSize: 20,
                      // color: Colors.amber,
                      fontFamily: 'montserrat',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: ScreenHeight / 2.0),
                  child: Text(
                    'HoMie',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0C174B),
                      fontSize: 24,
                      fontFamily: 'orbitron',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: ScreenHeight / 1.75, right: ScreenWidth / 10.0, left: ScreenWidth / 10.0),
                  child: TextFormField(
                    mouseCursor: MouseCursor.defer,
                    controller: emailController,
                    onSaved: (value) => setState(() {
                      userEmail = value!;
                    }),
                    decoration: InputDecoration(
                      errorBorder: OutlineInputBorder(
                        borderRadius:BorderRadius.circular(30.0), 
                      ),
                        errorStyle: TextStyle(fontFamily: 'montserrat',fontSize: 14.0,color: Colors.redAccent),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[800]),
                        hintText: "  User Name or Email",
                        fillColor: Colors.white70),
                        validator: (value) {
                          if(value!.isEmpty){
                            return 'Enter registered Mail';
                          }
                          else {
                            return null;
                          }
                        },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: ScreenHeight / 1.49, right: ScreenWidth / 10.0, left: ScreenWidth / 10.0),
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: _secureText,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _secureText = !_secureText;
                            });
                          },
                          icon: Icon(_secureText
                              ? Icons.remove_red_eye_rounded
                              : Icons.security)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        
                      ),
                      errorStyle: TextStyle(fontFamily: 'montserrat',fontSize: 14.0,color: Colors.redAccent),
                      errorBorder: OutlineInputBorder(
                        borderRadius:BorderRadius.circular(30.0), 
                      ),
                      filled: true,
                      hintStyle: TextStyle(color: Colors.grey[800]),
                      hintText: "  Password",
                      fillColor: Colors.white70,
                    ),
                    validator: (value) {
                      if(value!.length < 5){
                        return 'Enter atleast 5 characters';
                      }else {
                        return null;
                      }
                    },
                    onSaved: ((value) => setState(() => userPassword = value!)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: ScreenHeight / 1.31, right: ScreenWidth / 10.0, left: ScreenWidth / 10.0),
                  child: SizedBox(
                    width: ScreenWidth,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: signIn,
                      child: Text(
                        'Log In',
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'montserrat',
                            fontWeight: FontWeight.w800),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xFF0B63F6)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: ScreenHeight / 1.19),
                  child: RichText(
                    text: TextSpan(
                        text: "Don\'n have an account?  ",
                        style: TextStyle(color: Color(0xFF686C79)),
                        children: [
                          TextSpan(
                            recognizer: TapGestureRecognizer()..onTap = () => {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => SignUpStart())),
                            },
                            text: 'SIGN UP!',
                            style: TextStyle(
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

  Future signIn() async {
    final isValid = formKey.currentState!.validate();
    if(isValid){
      formKey.currentState!.save();
      await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
    }
  }
}

class CustomShape extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    double height = size.height;
    double width = size.width;
    var path = Path();
    path.lineTo(0, height - 50);
    path.quadraticBezierTo(width / 2, height, width, height - 50);
    path.lineTo(width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
