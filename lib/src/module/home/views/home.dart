import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../config/config.dart';

class HomeStart extends StatelessWidget {
  const HomeStart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeUI(),
    );
  }
}

class HomeUI extends StatefulWidget {
  const HomeUI({Key? key}) : super(key: key);

  @override
  State<HomeUI> createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  @override
  Widget build(BuildContext context) {
    double ScreenHeight = MediaQuery.of(context).size.height;
    double ScreenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(
                  child: SizedBox(
                    width: ScreenWidth / 5.2,
                    height: ScreenHeight / 20.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Container(
                        child: Text(
                          'Posts',
                          style: TextStyle(
                              fontFamily: 'montserrat',
                              fontWeight: FontWeight.w500,
                              fontSize: 18.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Tab(
                  child: SizedBox(
                    width: ScreenWidth / 5.2,
                    height: ScreenHeight / 20.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Container(
                        child: Text(
                          'Airticles',
                          style: TextStyle(
                              fontFamily: 'montserrat',
                              fontWeight: FontWeight.w500,
                              fontSize: 18.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          body:
           
          TabBarView(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Container(
                        height: 90,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0xFFF5FAFF),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  'Emergncy \nHealth Call Center',
                                  style: TextStyle(
                                      fontFamily: 'montserrat',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18.0),
                                ),
                                SizedBox(
                                  width: ScreenWidth / 5.2,
                                  height: ScreenHeight / 20.0,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12.0),
                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Color(0xFF0B63F6)),
                                        ),
                                        onPressed: () async {
                                          await FlutterPhoneDirectCaller
                                              .callNumber('16263');
                                        },
                                        child: Text(
                                          'call',
                                          style: TextStyle(
                                              fontFamily: 'montserrat',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18.0),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: cardTitles.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  top: 7.0, left: 4.0, right: 4.0),
                              child: SizedBox(
                                height: ScreenHeight / 8.0,
                                width: double.infinity,
                                child: InkWell(
                                  onTap: (){
                                    launchUrlString('https://www.who.int');
                                  },
                                  child: Card(
                                    elevation: 5,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            child: Padding(
                                              padding: EdgeInsets.only(left: 8.0),
                                              child: SizedBox(
                                                  height: ScreenHeight / 5.0,
                                                  width: ScreenWidth / 5.0,
                                                  child: Image.asset(
                                                      '${imgLocation[index]}')),
                                            )),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "${cardTitles[index]}",
                                              style: TextStyle(
                                                fontFamily: 'montserrat',
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(top: 10.0),
                                              child: Text(
                                                  subtitle),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  children: [

                    Expanded(
                      child: ListView.builder(
                          itemCount: cardTitles.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  top: 7.0, left: 4.0, right: 4.0),
                              child: SizedBox(
                                height: ScreenHeight / 8.0,
                                width: double.infinity,
                                child: InkWell(
                                  onTap: (){
                                    launchUrlString('https://www.who.int');
                                  },
                                  child: Card(
                                    elevation: 5,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            child: Padding(
                                              padding: EdgeInsets.only(left: 8.0),
                                              child: SizedBox(
                                                  height: ScreenHeight / 5.0,
                                                  width: ScreenWidth / 5.0,
                                                  child: Image.asset(
                                                      '${imgLocation[index]}')),
                                            )),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "${cardTitles[index]}",
                                              style: TextStyle(
                                                fontFamily: 'montserrat',
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(top: 10.0),
                                              child: Text(
                                                  subtitle),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
