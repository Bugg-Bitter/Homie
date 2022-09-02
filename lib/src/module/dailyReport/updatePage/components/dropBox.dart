import 'package:flutter/material.dart';

import 'myStateFullWidget.dart';

class DropBox extends StatefulWidget {
  const DropBox({
    Key? key,
    required this.typeName,

    }) : super(key: key);
    final String typeName;
  @override
  State<DropBox> createState() => _DropBoxState();
}

class _DropBoxState extends State<DropBox> {
  final choise = ["Yes", "No"];
  final citiesSelected = TextEditingController();
  String? selectedItem = "Yes";

  void dropdownCallback() {
    selectedItem = "Yes";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 5.0, bottom: 5.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.typeName,
                style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0)),
              ),
            ),
          ),
          SizedBox(height: 30.0, child: MyStatefulWidget()),
        ],
      ),
    );
  }
}