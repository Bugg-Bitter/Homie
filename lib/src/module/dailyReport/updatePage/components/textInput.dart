import 'package:flutter/material.dart';
class TextInput extends StatefulWidget {
  final String headertext;
  final double boxheight;
  final String errorMsg;
  final GlobalKey<FormState> validatorKey;
  final TextEditingController nesController;
  TextInput({
    required String this.headertext,
    required double this.boxheight,
    required String this.errorMsg,
    required this.validatorKey,
    required this.nesController,
    Key? key, 
  }) : super(key: key);

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  String fieldValue = '';
  @override
  void initState() {
    super.initState();
    widget.nesController.addListener(()=> setState(() {}),);
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
                widget.headertext,
                style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0)),
              ),
            ),
          ),
          SizedBox(
            height: widget.boxheight,
            child: Form(
              key: widget.validatorKey,
              child: Container(
                color: Colors.white,
                child: SizedBox(
                  height: 10.0,
                  child: TextFormField(
                    controller: widget.nesController,
                    autofocus: true,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      
                      // errorText: widget.errorMsg,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 22, 71, 206),
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                            width: 1.5,
                            color: Color.fromARGB(255, 22, 71, 206)),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                              width: 1.5,
                              color: Color.fromARGB(255, 224, 19, 19))),
                    ),
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
