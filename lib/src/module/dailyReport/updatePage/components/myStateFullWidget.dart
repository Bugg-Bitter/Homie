import 'package:flutter/material.dart';
import 'package:homie/src/config/config.dart';

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  String dropdownValue = 'Yes';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.0,
      width: double.infinity,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
              color: Color.fromARGB(255, 22, 71, 206),
              width: 1.5,
              style: BorderStyle.solid),
          borderRadius: BorderRadius.all(Radius.circular(10.0),
          ),
        ),
      ),
      child: DropdownButton<String>(
        borderRadius: BorderRadius.circular(10.0),
        dropdownColor: Colors.white,
        isExpanded: true,
        underline: DropdownButtonHideUnderline(child: Container()),
        value: dropdownValue,
        icon: Padding(
          padding: EdgeInsets.only(right: 15.0),
          child: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Color.fromARGB(255, 22, 71, 206),
          ),
        ),
        elevation: 16,
        style: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 0, 0, 0)),
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
            intercourseController = dropdownValue;
          });
        },
        items:
            <String>['Yes', 'No'].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Text(
                value,
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}