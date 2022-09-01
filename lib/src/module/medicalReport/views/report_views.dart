import 'dart:io';

import 'package:flutter/material.dart';

class reportView extends StatefulWidget {
  reportView({Key? key, required this.image}) : super(key: key);
  final String image;

  @override
  State<reportView> createState() => _reportViewState();
}

class _reportViewState extends State<reportView> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Hero(
            tag: 'report_view',
            child: Image.network("${widget.image}",fit: BoxFit.contain,),
          ),
        ),
      ),
    );
  }
}
