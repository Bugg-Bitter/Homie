import 'package:homie/src/firebase/storage_service.dart';

final Storage storage = Storage();
var flagOfmodules = 1;
var searchResult = 'Doctors';
final String phoneNo = '16263';
var degree = 'MBBS (DMC)DCH (IRE) MRCP (UK)MRCPCH(UK)FRCP(Glassgow)';
var addressList = '';

///////[Hospital Sections Info]////////
List<String> hospitalImages = [
  'hosOne',
  'hosTwo',
  'hosThree',
  'hosFour',
  'hosFive',
  'hosSix'
];
List<String> hospitalNames = [
  'Heart Foundation',
  'Lazz Pharma',
  'Chiropractic Treatment bd',
  'CuraFoot Clinic',
  'City Eye Center',
  'KB Dental Surgery',
];
///////[Hospital Sections Info]////////

///////[Pharmacies Sections Info]////////
List<String> pharmacyImages = [
  'pharmOne',
  'pharmTwo',
  'pharmThree',
  'pharmFour',
  'pharmFive',
  'pharmSix'
];

List<String> pharmacyNames = [
  'Desh Pharmacy',
  'Care Pharmacy',
  'Ferdousi Pharmacy',
  'Receptor pharmacy',
  'Q Pharma Ltd',
  'M.M. Pharma'
];
///////[Pharmacies Sections Info]////////

///////[Doctors Sections Info]////////
List<String> Designations = [
  'cardiologist',
  'pharmacist',
  'chiropractor',
  'podiatrist',
  'optometrist',
  'dentist',
];

List<String> DocNames = [
  'Nishat Era',
  'Mariam Begum',
  'Jackson talu',
  'Umar Mahady',
  'Mahedy Hasan',
  'Rabid Hasan'
];
///////[Doctors Sections Info]////////

///////[Department Info]////////
List<String> departments = [
  'Echocardiography & Interventional Cardiology',
  'Prescription Aid Pharmacy',
  'Treat patients with health problems',
  'General ankle and foot medical care',
  'Able to perform operations on eyes',
  'Dental Anesthesiology & Oral & Craniofacial Sciences',
];

Map<String, Map<String, String>> geoPoints = {
  "cardiologist": {
    "long": "99.249075",
    "lat": "39.909736",
  },
  "pharmacist": {
    "long": "35.925572",
    "lat": "15.961329",
  },
  "chiopractor": {
    "long": "101.359858",
    "lat": "58.813742",
  },
  "podiatrist": {
    "long": "110.506587",
    "lat": "55.776587",
  },
  "optometrist": {
    "long": "109.099398",
    "lat": "60.586967",
  },
  "dentist": {
    "long": "114.728154",
    "lat": "54.572062",
  },
};
