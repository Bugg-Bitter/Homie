import 'package:flutter/material.dart';
import 'package:homie/src/module/profile/searchedProfile/views/searchedProfileUI.dart';
import 'package:homie/src/module/search/config/search_config.dart';

class InfoComponent extends StatelessWidget {
  const InfoComponent({
    Key? key,
    required this.ScreenHeight,
    required this.imageLink,
    required this.listNames,
    required this.listInfo,
    required this.index,
    required this.currentStateTitle,
  }) : super(key: key);

  final double ScreenHeight;
  final String imageLink;
  final List<String> listNames;
  final List<String> listInfo;
  final int index;
  final String currentStateTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(left: 40.0, right: 40.0, top: ScreenHeight / 130.0),
      child: Container(
        width: double.infinity,
        height: 70.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 13.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(13.0),
                      child: Image.network(
                        imageLink,
                        height: 50.0,
                        width: 50.0,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          '${listNames[index]}',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w700),
                        ),
                      ),
                      currentStateTitle == 'Doctor'
                          ? Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Text(
                                textAlign: TextAlign.left,
                                '${listInfo[index]}',
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchedProfileStart(
                                    searchedImage: imageLink,
                                    designation: listInfo[index],
                                    name: listNames[index],
                                    assignedHospital: hospitalNames[index],
                                    specialist: degree,
                                    department: departments[index],
                                    tracker: index,
                                    stateTitle: currentStateTitle,
                                  )));
                    },
                    child: Container(
                      height: 35.0,
                      width: 35.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Icon(
                        Icons.arrow_forward_rounded,
                        color: Color(0xFF1648CE),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
