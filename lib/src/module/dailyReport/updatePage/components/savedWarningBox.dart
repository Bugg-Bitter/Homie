import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:homie/src/config/config.dart';
import 'package:intl/intl.dart';

class SavedWarningBox extends StatefulWidget {
  const SavedWarningBox({
    Key? key,
  }) : super(key: key);

  @override
  State<SavedWarningBox> createState() => _SavedWarningBoxState();
}

class _SavedWarningBoxState extends State<SavedWarningBox> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (pulseRatefromKey.currentState!.validate()) {
          if (BPfromKey.currentState!.validate()) {
            if (O2fromKey.currentState!.validate()) {
              if (tempInfromKey.currentState!.validate()) {
                if (diabetiesBeforefromKey.currentState!.validate()) {
                  if (diabetiesAfterfromKey.currentState!.validate()) {
                    if (weightfromKey.currentState!.validate()) {
                      if (weatherformKey.currentState!.validate()) {
                        if (extraNotesfromKey.currentState!.validate()) {
                          final fullPulseRate = pulseRateController.text;
                          final fullBP = BPController.text;
                          final fullO2 = O2Controller.text;
                          final fullTempIn = tempInController.text;
                          final fullDiabetiesBefore =
                              diabetiesBeforeController.text;
                          final fullDiabetiesAfter =
                              diabetiesAfterController.text;
                          final fullWeather = weatherController.text;
                          final fullWeight = weightController.text;
                          final fullExtraNotes = extraNotesController.text;
                          final fullIntercourse = intercourseController;
                          final fullExercise = exerciseController;

                          createNewReport(
                            newPulseRate: fullPulseRate,
                            newBP: fullBP,
                            newExercise:fullExercise,
                            newO2: fullO2,
                            newTempIn: fullTempIn,
                            newDiabetiesBefore: fullDiabetiesBefore,
                            newDiabetiesAfter: fullDiabetiesAfter,
                            newWeather: fullWeather,
                            newWeight: fullWeight,
                            newExtraNotes: fullExtraNotes,
                            newIntercourse: fullIntercourse,
                            newDateAndTimes: DateFormat('yyyy-MM-dd KK:mm:ss').format(DateTime.now()),
                          );
                          // print("${dateAndTime}");
                          pulseRateController.clear();
                          BPController.clear();
                          O2Controller.clear();
                          tempInController.clear();
                          diabetiesBeforeController.clear();
                          diabetiesAfterController.clear();
                          weatherController.clear();
                          weightController.clear();
                          extraNotesController.clear();
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

  Future createNewReport(
      {
      required String newPulseRate,
      required String newBP,
      required String newO2,
      required String newTempIn,
      required String newDiabetiesBefore,
      required String newDiabetiesAfter,
      required String newWeather,
      required String newWeight,
      required String newExtraNotes,
      required String newIntercourse,
      required String newDateAndTimes,
      required String newExercise,
      }
      ) async {

    final newDailyReport = FirebaseFirestore.instance.collection('dailyReports').doc(DateFormat('yyyy-MM-dd KK:mm:ss').format(DateTime.now()));
    final jsonData = {
      'pulse': newPulseRate,
      'bp': newBP,
      'o2': newO2,
      'temp': newTempIn,
      'diabeticsBefore': newDiabetiesBefore,
      'diabeticsAfter': newDiabetiesAfter,
      'weather': newWeather,
      'weight':newWeight,
      'extranotes':newExtraNotes,
      'intercourse':newIntercourse,
      'dateWithTime':newDateAndTimes,
      'exercise':newExercise,
    };
    await newDailyReport.set(jsonData);
    print('Successfully inserted');
  }
}
