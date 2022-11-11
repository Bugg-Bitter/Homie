import 'package:flutter/material.dart';

import '../../../../config/config.dart';
import '../../config/search_config.dart';
import '../search_info_component.dart';

class SelectedSectorsLists extends StatelessWidget {
  const SelectedSectorsLists({
    Key? key,
    required this.ScreenHeight,
    required this.currentSector,
  }) : super(key: key);

  final double ScreenHeight;
  final String currentSector;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: totalDoctor,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          if (currentSector == 'Doctor') {
            return FutureBuilder(
                future: storage.docDownloadURL('${Designations[index]}.jpeg'),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    return InfoComponent(
                      ScreenHeight: ScreenHeight,
                      imageLink: snapshot.data!,
                      listNames: DocNames,
                      listInfo: Designations,
                      index: index,
                      currentStateTitle: 'Doctor',
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      !snapshot.hasData) {
                    return Center(
                        child: Padding(
                      padding: EdgeInsets.only(top: ScreenHeight / 20.0),
                      child: Container(
                          height: 40,
                          width: 40,
                          child: CircularProgressIndicator()),
                    ));
                  } else {
                    return Container();
                  }
                });
          } else if (currentSector == 'Pharmacy') {
            return FutureBuilder(
                future:
                    storage.pharmDownloadURL('${pharmacyImages[index]}.jpeg'),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    return InfoComponent(
                      ScreenHeight: ScreenHeight,
                      imageLink: snapshot.data!,
                      listNames: pharmacyNames,
                      listInfo: Designations,
                      index: index,
                      currentStateTitle: 'Pharmacy',
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      !snapshot.hasData) {
                    return Center(
                        child: Padding(
                      padding: EdgeInsets.only(top: ScreenHeight / 20.0),
                      child: Container(
                          height: 40,
                          width: 40,
                          child: CircularProgressIndicator()),
                    ));
                  } else {
                    return Container();
                  }
                });
          } else {
            return FutureBuilder(
                future: storage.hosDownloadURL('${hospitalImages[index]}.jpeg'),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    return InfoComponent(
                      ScreenHeight: ScreenHeight,
                      imageLink: snapshot.data!,
                      listNames: hospitalNames,
                      listInfo: Designations,
                      index: index,
                      currentStateTitle: 'Hospitals',
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      !snapshot.hasData) {
                    return Center(
                        child: Padding(
                      padding: EdgeInsets.only(top: ScreenHeight / 20.0),
                      child: Container(
                          height: 40,
                          width: 40,
                          child: CircularProgressIndicator()),
                    ));
                  } else {
                    return Container();
                  }
                });
          }
        },
      ),
    );
  }
}
