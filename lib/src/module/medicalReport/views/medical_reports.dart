import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:homie/src/config/config.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../profile/updateProfile/config/firebaseApi.dart';
import '../../search/config/search_config.dart';

class Medical_Reports extends StatefulWidget {
  const Medical_Reports({Key? key}) : super(key: key);

  @override
  State<Medical_Reports> createState() => _Medical_ReportsState();
}

class _Medical_ReportsState extends State<Medical_Reports> {
  File? image;
  Future uploadReportPic() async {
    if (image == null) {
      return;
    }
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    final filename = 'repo6';
    final destination = 'medicalReports/$filename';
    FirebaseApi.uploadFile(destination, image!);
  }

  Future _chooseImage() async {
    try {
      XFile? image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    double ScreenHeight = MediaQuery.of(context).size.height;
    double ScreenWidth = MediaQuery.of(context).size.width;
    final reportAddedToast = SnackBar(
      duration: Duration(milliseconds: 1500),
      content: Text(
        'Report Added to Firebase',
        style: TextStyle(
          color: Color(0xffD9D9D9),
          fontFamily: 'GoogleSans',
          fontSize: ScreenWidth / 30.0,
        ),
      ),
    );
    final reportNotAddedToast = SnackBar(
      duration: Duration(milliseconds: 1500),
      content: Text(
        'Choose image From Gallary',
        style: TextStyle(
          color: Color(0xffD9D9D9),
          fontFamily: 'GoogleSans',
          fontSize: ScreenWidth / 30.0,
        ),
      ),
    );

    return Scaffold(
      body: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                child: SvgPicture.asset(
                  'asset/signup/bkimg.svg',
                  width: ScreenWidth,
                  color: Color(0xFF043BB8),
                ),
              ),
              Text(
                'Medical Report',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                      itemCount: reportsList.length,
                      itemBuilder: (context, index) {
                        final item = reportsList[index];
                        return FutureBuilder(
                            future:
                                storage.medicalReportsDownloadURL('${item}'),
                            builder: (BuildContext context,
                                AsyncSnapshot<String> snapshot) {
                              if (snapshot.connectionState ==
                                      ConnectionState.done &&
                                  snapshot.hasData) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(30.0),
                                  child: Image.network(
                                    snapshot.data!,
                                    height: 80.0,
                                    width: 80.0,
                                  ),
                                );
                              }
                              if (snapshot.connectionState ==
                                      ConnectionState.waiting ||
                                  !snapshot.hasData) {
                                return Center(
                                    child: Padding(
                                  padding:
                                      EdgeInsets.only(left: 8.0, right: 8.0),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      GestureDetector(
                                          onTap: () {
                                            _chooseImage();
                                          },
                                          child: image != null
                                              ? ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  child: Image.file(
                                                    image!,
                                                    height: 100.0,
                                                    width: 105.0,
                                                  ),
                                                )
                                              : ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  child: Image.asset(
                                                    'asset/updatepage/black.png',
                                                    height: 100.0,
                                                    width: 105.0,
                                                  ),
                                                )),
                                      image == null
                                          ? GestureDetector(
                                              onTap: () {
                                                _chooseImage();
                                              },
                                              child: SvgPicture.asset(
                                                'asset/updatepage/plus.svg',
                                                color: Colors.white,
                                                height: 100.0,
                                                width: 105.0,
                                              ),
                                            )
                                          : Container(),
                                    ],
                                  ),
                                ));
                              } else {
                                return Container();
                              }
                            });
                      }),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: ScreenHeight / 25.0,
                left: ScreenWidth / 10.0,
                right: ScreenWidth / 10.0,
                bottom: ScreenHeight / 640.0),
            child: SizedBox(
              width: ScreenWidth / 1.5,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if(image == null){
                    ScaffoldMessenger.of(context).showSnackBar(reportNotAddedToast);
                  }else if(image != null){
                    ScaffoldMessenger.of(context).showSnackBar(reportAddedToast);
                  }
                  
                },
                onLongPress: (){
                  uploadReportPic();
                },
                child: Text(
                  'Add Report to Database',
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'montserrat',
                      fontWeight: FontWeight.w600),
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xFF0B63F6)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
