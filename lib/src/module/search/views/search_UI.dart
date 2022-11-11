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
          color: Color(0xFFFAFAFE),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  UIBanner(),
                  CustomSearchBar(
                      ScreenWidth: ScreenWidth, ScreenHeight: ScreenHeight),
                ],
              ),
              detecedSectors(),
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Search Results for $selectedSectorName',
                    style: TextStyle(
                      fontFamily: 'montserrat',
                      fontSize: 20.0,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF6A788E),
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
            child: const Sectors(
              searchResult: 'Doctor',
              searchResultColor: Colors.orangeAccent,
              searchResultIcon: Icons.medical_services_rounded,
            ),
          ),
          GestureDetector(
            onTap: () {
              selectedSector('Pharmacy');
            },
            child: const Sectors(
              searchResult: 'Pharmacy',
              searchResultColor: Colors.blueAccent,
              searchResultIcon: Icons.local_pharmacy_rounded,
            ),
          ),
          GestureDetector(
            onTap: () {
              selectedSector('Hospital');
            },
            child: Sectors(
              searchResult: 'Hospital',
              searchResultColor: Colors.redAccent,
              searchResultIcon: Icons.local_hospital_rounded,
            ),
          ),
        ],
      ),
    );
  }
}
