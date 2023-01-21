import 'package:flutter/material.dart';

import '../components/page_components/custom_searchbar.dart';
import '../components/page_components/sectors.dart';
import '../components/page_components/selected_sector_list.dart';
import '../components/page_components/ui_banner.dart';

class SearchStart extends StatelessWidget {
  const SearchStart({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SearchUI(),
    );
  }
}

class SearchUI extends StatefulWidget {
  const SearchUI({super.key});

  @override
  State<SearchUI> createState() => _SearchUIState();
}

class _SearchUIState extends State<SearchUI> {
  String selectedSectorName = 'Doctor';

  void selectedSector(String sectorName) {
    setState(() {
      selectedSectorName = sectorName;
    });
  }

  @override
  Widget build(BuildContext context) {
    double ScreenHeight = MediaQuery.of(context).size.height;
    double ScreenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Color.fromARGB(255, 194, 194, 244),
          child: Column(
            children: [
              // Stack(
              //   alignment: Alignment.center,
              //   children: [
              //     UIBanner(),
              //     CustomSearchBar(
              //         ScreenWidth: ScreenWidth, ScreenHeight: ScreenHeight),
              //   ],
              // ),
              Padding(
                padding: EdgeInsets.only(left: 16.0, top: 10.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Categories",
                    style: TextStyle(
                        fontFamily: 'rubik',
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0),
                  ),
                ),
              ),
              detecedSectors(),
              Padding(
                padding: EdgeInsets.only(top: 50.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Search Results for $selectedSectorName',
                    style: TextStyle(
                      fontFamily: 'rubik',
                      fontSize: 24.0,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SelectedSectorsLists(
                ScreenHeight: ScreenHeight,
                currentSector: selectedSectorName,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding detecedSectors() {
    return Padding(
      padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              selectedSector('Doctor');
            },
            child: Sectors(
              searchResult: 'Doctor',
              searchResultColor: Colors.orangeAccent,
              searchResultIcon: Image.asset('asset/search/doctor.png'),
            ),
          ),
          GestureDetector(
            onTap: () {
              selectedSector('Pharmacy');
            },
            child: Sectors(
              searchResult: 'Pharmacy',
              searchResultColor: Colors.blueAccent,
              searchResultIcon: Image.asset('asset/search/pharmacy.png'),
            ),
          ),
          GestureDetector(
            onTap: () {
              selectedSector('Hospital');
            },
            child: Sectors(
              searchResult: 'Hospital',
              searchResultColor: Colors.redAccent,
              searchResultIcon: Image.asset('asset/search/hospital.png'),
            ),
          ),
        ],
      ),
    );
  }
}
