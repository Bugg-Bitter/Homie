import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
