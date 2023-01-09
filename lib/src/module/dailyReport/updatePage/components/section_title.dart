import 'package:flutter/material.dart';

import '../../../mlInputs/mlInputs.dart';

class SectionTitle extends StatefulWidget {
  final String sectionTitle;
  SectionTitle({
    Key? key,
    required this.sectionTitle,
  }) : super(key: key);

  @override
  State<SectionTitle> createState() => _SectionTitleState();
}

class _SectionTitleState extends State<SectionTitle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350.0,
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              "${widget.sectionTitle}",
              style: TextStyle(color: Color(0xff4d52b6), fontSize: 24.0),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => MlInputsUI(
                        sectionName: widget.sectionTitle,
                      ))));
            },
            child: Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(
                Icons.arrow_forward_ios_rounded,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
