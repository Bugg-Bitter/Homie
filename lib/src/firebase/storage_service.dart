import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;

class Storage {
  final firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;

  // Upload Users Profile Pictures
  Future<void> uploadFile(
    String filePath,
    String fileName,
  ) async {
    File file = File(filePath);

    try {
      await storage.ref('newUsersProfilePic/$fileName').putFile(file);
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
  }


  // Get Doctor Pictures List...
  Future<firebase_storage.ListResult> listFiles() async {
    firebase_storage.ListResult results = await storage.ref('doctors').listAll();

    results.items.forEach((firebase_storage.Reference ref) { 
      print('Found file: $ref');
    });
    return results;
  }


  // Load Doctors Pictures
  Future<String> docDownloadURL(String imageName) async {
    String downloadURL = await storage.ref('doctors/$imageName').getDownloadURL();
    return downloadURL;
  }



  // Load Hospitals Pictures
  Future<String> hosDownloadURL(String imageName) async {
    String downloadURL = await storage.ref('hospitals/$imageName').getDownloadURL();
    return downloadURL;
  }



  // Load Pharmacies Pictures
    Future<String> pharmDownloadURL(String imageName) async {
    String downloadURL = await storage.ref('pharmacies/$imageName').getDownloadURL();
    return downloadURL;
  }

  // User Pictures ....
  Future<String> userProfilePicDownloadURL(String imageName) async {
    String downloadURL = await storage.ref('newUsersProfilePic/$imageName').getDownloadURL();
    return downloadURL;
  }
  
    Future<String> medicalReportsDownloadURL(String imageName) async {
    String downloadURL = await storage.ref('medicalReports/$imageName').getDownloadURL();
    return downloadURL;
  }
}


