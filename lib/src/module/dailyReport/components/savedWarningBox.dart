import 'package:flutter/material.dart';
import 'package:homie/src/config/config.dart';

class SavedWarningBox extends StatelessWidget {
  const SavedWarningBox({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        pulseRateController.clear();
        BPController.clear();
        O2Controller.clear();
        tempInController.clear();
        diabetiesBeforeController.clear();
        diabetiesAfterController.clear();
        weatherController.clear();
        weightController.clear();
        extraNotesController.clear();
        if (pulseRatefromKey.currentState!.validate()) {
          if (BPfromKey.currentState!.validate()) {
            if (O2fromKey.currentState!.validate()) {
              if (tempInfromKey.currentState!.validate()) {
                if (diabetiesBeforefromKey.currentState!.validate()) {
                  if (diabetiesAfterfromKey.currentState!.validate()) {
                    if (weightfromKey.currentState!.validate()) {
                      if (weatherformKey.currentState!.validate()) {
                        if (extraNotesfromKey.currentState!.validate()) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(40)),
                                    insetPadding: EdgeInsets.all(5.0),
                                    title: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 40.0),
                                          child: Text(
                                            'Report Added Successfully!',
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                fontFamily: 'montserrat',
                                                fontWeight: FontWeight.w600),
                                          ),
                                        )
                                      ],
                                    ),
                                    actions: [
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 20.0),
                                        child: Center(
                                          child: Container(
                                              width: 150.0,
                                              height: 175.0,
                                              child: Image.asset(
                                                  'asset/dailyReport/emoji.png')),
                                        ),
                                      ),
                                    ],
                                  ));
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(
            left: 15.0, right: 15.0, top: 5.0, bottom: 5.0),
        child: Text(
          '+ Add New Report',
          style: TextStyle(
              fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.w400),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
