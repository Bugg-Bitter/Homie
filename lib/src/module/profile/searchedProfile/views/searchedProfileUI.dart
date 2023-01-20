import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:homie/src/module/profile/config/searchedProfileConfig.dart';
import 'package:homie/src/module/search/config/search_config.dart';
import 'package:homie/src/module/search/views/search_UI.dart';

class SearchedProfileStart extends StatelessWidget {
  const SearchedProfileStart({
    Key? key,
    required this.searchedImage,
    required this.name,
    required this.designation,
    required this.assignedHospital,
    required this.specialist,
    required this.department,
    required this.tracker,
    required this.stateTitle,
    // required this.phoneNo
  }) : super(key: key);
  final String searchedImage;
  final String name;
  final String designation;
  final String assignedHospital;
  final String specialist;
  final String department;
  final int tracker;
  final String stateTitle;
  // final int phoneNo;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SearchedProfileUI(
        linkedImage: searchedImage,
        linkedName: name,
        linkedDesignation: designation,
        linkedHospital: assignedHospital,
        linkedSpecialist: specialist,
        linkedDepartment: department,
        linkedTracker: tracker,
        linkedStateTitle: stateTitle,
      ),
    );
  }
}

class SearchedProfileUI extends StatefulWidget {
  const SearchedProfileUI({
    Key? key,
    required this.linkedImage,
    required this.linkedName,
    required this.linkedDesignation,
    required this.linkedHospital,
    required this.linkedSpecialist,
    required this.linkedDepartment,
    required this.linkedTracker,
    required this.linkedStateTitle,
  }) : super(key: key);

  final String linkedImage;
  final String linkedName;
  final String linkedDesignation;
  final String linkedHospital;
  final String linkedSpecialist;
  final String linkedDepartment;
  final int linkedTracker;
  final String linkedStateTitle;
  @override
  State<SearchedProfileUI> createState() => _SearchedProfileUIState();
}

class _SearchedProfileUIState extends State<SearchedProfileUI> {
  static final CameraPosition _doctorsArea = CameraPosition(
    target: LatLng(23.872633449925942, 90.3969710662202),
    zoom: 12.4746,
  );

  static final Marker _doctorsAreaMarker = Marker(
    markerId: MarkerId('_doctorsArea'),
    infoWindow: InfoWindow(title: 'Doctor'),
    icon: BitmapDescriptor.defaultMarker,
    position: LatLng(23.872633449925942, 90.3969710662202),
  );
  var counter = 0;
  @override
  Widget build(BuildContext context) {
    geoPoints;
    // print("${widget.linkedTracker}");

    Map<String, String>? tempMap = geoPoints["${widget.linkedTracker}"];
    print("${tempMap!["long"]}");
    // print("${geoPoints["${widget.linkedTracker}"]["lat"]}");
    double ScreenHeight = MediaQuery.of(context).size.height;
    double ScreenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: Padding(
          padding: EdgeInsets.only(
              left: ScreenWidth / 5.0,
              right: ScreenWidth / 5.0,
              bottom: ScreenHeight / 90.0),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xff4E52B6)),
            child: InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)),
                          insetPadding: EdgeInsets.all(ScreenWidth / 30.0),
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(top: ScreenHeight / 30.0),
                                child: Text(
                                  'Address: 32, Rabindra Sarani, Sector – 7, Uttara, Dhaka – 1230',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 20.0),
                                child: Text(
                                    'Visiting Hour: 4pm to 11pm (Closed: Friday)',
                                    textAlign: TextAlign.center),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 20.0, bottom: 20.0),
                                child: Text(
                                    'Appointment: ${phoneNoList[widget.linkedTracker]}',
                                    textAlign: TextAlign.center),
                              ),
                            ],
                          ),
                          actions: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20.0, bottom: 40.0),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color(0xff4E52B6)),
                                child: InkWell(
                                  onTap: () async {
                                    await FlutterPhoneDirectCaller.callNumber(
                                        phoneNoList[widget.linkedTracker]);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      'Call',
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontFamily: 'rubik',
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ));
              },
              child: Padding(
                padding: EdgeInsets.only(
                    left: 15.0, right: 15.0, bottom: 15.0, top: 15.0),
                child: Text(
                  'Make an Appointment',
                  style: TextStyle(
                      fontSize: 16.0,
                      fontFamily: 'rubik',
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 160, 162, 206),
        centerTitle: true,
        leading: Padding(
          padding: EdgeInsets.fromLTRB(8.0, 5.0, 2.0, 5.0),
          child: Container(
            height: 20.0,
            width: 20.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Color.fromARGB(255, 108, 108, 224),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: IconButton(
                color: Colors.black,
                icon: Icon(
                  Icons.arrow_back_ios,
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SearchStart()));
                },
              ),
            ),
          ),
        ),
        title: Text(
          '${widget.linkedStateTitle} Profile',
          style: TextStyle(
              fontWeight: FontWeight.w600, fontSize: 16.0, color: Colors.black),
        ),
      ),
      body: Container(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Color.fromARGB(255, 161, 161, 229)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: ListTile(
                        leading: Container(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              widget.linkedImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.linkedName,
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 9, 31, 68),
                              ),
                            ),
                            Text(
                              widget.linkedDesignation,
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w700,
                                color: Color.fromARGB(255, 86, 93, 104),
                              ),
                            ),
                            Text(
                              '${widget.linkedHospital}',
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w700,
                                color: Color.fromARGB(255, 9, 31, 68),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Color.fromARGB(255, 161, 161, 229)),
                    child: Padding(
                      padding:
                          EdgeInsets.only(left: 10.0, right: 10.0, top: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${widget.linkedStateTitle} Information',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Text(
                            'Degree - ${widget.linkedSpecialist}\n',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'Designation: Consultant & Coordinator',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'Department: ${widget.linkedDepartment}',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'Institute: ${widget.linkedHospital}',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.black,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: ScreenHeight / 50.0),
                            child: Text(
                              'Location',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: ScreenHeight / 3.0,
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
                                child: GoogleMap(
                                  initialCameraPosition: CameraPosition(
                                    target: LatLng(
                                        double.parse(tempMap["long"]!),
                                        double.parse(tempMap["lat"]!)),
                                    zoom: 12.4746,
                                  ),
                                  markers: {
                                    _doctorsAreaMarker,
                                    Marker(
                                      markerId: MarkerId('_doctorsArea'),
                                      infoWindow: InfoWindow(title: 'Doctor'),
                                      icon: BitmapDescriptor.defaultMarker,
                                      position: LatLng(
                                          double.parse(tempMap["long"]!),
                                          double.parse(tempMap["lat"]!)),
                                    ),
                                  },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 54.0,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
