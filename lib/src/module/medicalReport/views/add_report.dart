import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as Path;

class Medical_Reports extends StatefulWidget {
  const Medical_Reports({Key? key}) : super(key: key);

  @override
  State<Medical_Reports> createState() => _Medical_ReportsState();
}

class _Medical_ReportsState extends State<Medical_Reports> {
  bool uploading = false;
  double val = 0.0;
  late CollectionReference imgRef;
  late firebase_storage.Reference ref;
  List<File> _image = [];
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    imgRef = FirebaseFirestore.instance.collection('imgeURLs');
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
        appBar: AppBar(
          title: Text("Add Image"),
          actions: [
            TextButton(
                onPressed: () {
                  setState(() {
                    uploading = true;
                  });
                  uploadFile().whenComplete(() => Navigator.of(context).pop());
                },
                child: Text(
                  'Upload',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ))
          ],
        ),
        body: Stack(
          children: [
            GridView.builder(
              itemCount: _image.length + 1,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: ((context, index) {
                return index == 0
                    ? Center(
                        child: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () => !uploading ? chooseImage() : null,
                        ),
                      )
                    : Container(
                        margin: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: FileImage(_image[index - 1]),
                              fit: BoxFit.cover),
                        ),
                      );
              }),
            ),
            uploading
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          child: Text(
                            'uploading...',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CircularProgressIndicator(
                          value: val,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.green),
                        )
                      ],
                    ),
                  )
                : Container()
          ],
        ));
  }

  chooseImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image.add(File(pickedFile!.path));
    });
    if (pickedFile!.path == null) retriveLostData();
  }

  Future<void> retriveLostData() async {
    final LostDataResponse response = await picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _image.add(File(response.file!.path));
      });
    } else {
      print(response.file);
    }
  }

  Future uploadFile() async {
    int i = 1;

    for (var img in _image) {
      setState(() {
        val = i / _image.length;
      });
      ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('images/${Path.basename(img.path)}');
      await ref.putFile(img).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          imgRef.add({'url': value});
          i++;
        });
      });
    }
  }
}
