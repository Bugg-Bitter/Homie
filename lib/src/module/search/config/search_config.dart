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
  "0": {
    "long": "23.820705189344714",
    "lat": "90.43236232917504",
  },
  "1": {
    "long": "23.888654087430353",
    "lat": "90.39597096733527",
  },
  "2": {
    "long": "23.778236276580877",
    "lat": "90.34927992354864",
  },
  "3": {
    "long": "23.76013887817693",
    "lat": "90.38361304443988",
  },
  "4": {
    "long": "23.777986650344246",
    "lat": "90.42000694945503",
  },
  "5": {
    "long": "23.624876222941428",
    "lat": "90.5013799643957",
  },
};