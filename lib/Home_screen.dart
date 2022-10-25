import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/itemRoot.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

late String location = 'null', price = 'null', type = 'null';
bool buy_it = false;

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  void initState() {
    super.initState();

  }

  final user = FirebaseAuth.instance.currentUser;
  DateTime current_date = DateTime.now();
  FirebaseFirestore db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  File? _photo;
  final ImagePicker _picker = ImagePicker();
  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadFile() async {
    if (_photo == null) return;
    final fileName = basename(_photo!.path);
    final destination = 'files/$fileName';
    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child('file/');
      await ref.putFile(_photo!);
    } catch (e) {
      print('error occurred');
    }
  }


  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Container(
                  height: 600,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      _photo != null
                          ? Image.file(
                              _photo!,
                              height: 200,
                              width: 200,
                            )
                          : FlutterLogo(
                              size: 200.0,
                            ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            imgFromGallery();
                          });
                        },
                        child: const Text('Press to select Image'),
                      ),
                      TextField(
                          onChanged: (value) {
                            type = value;
                          },
                          decoration: InputDecoration(
                            hintText: 'Enter Type Of Item',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                          )), //Location
                      TextField(
                          onChanged: (value) {
                            price = value;
                          },
                          decoration: InputDecoration(
                            hintText: 'Enter Your Price ',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 20.0),
                          )), //Type
                      TextField(
                          onChanged: (value) {
                            location = value;
                          },
                          decoration: InputDecoration(
                            hintText: 'Enter Your Location ',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                          )), //Price
                      SizedBox(
                        height: 20.0,
                      ),
                      ElevatedButton(
                        child: const Text('Save'),
                        onPressed: () => {
                          current_date = DateTime.now(),
                          db.collection("Post").doc().set({
                            'Email': user?.email,
                            'image': _photo?.path,
                            'location': location,
                            'type': type,
                            'price': price,
                            'current_data': current_date
                          }).onError(
                              (e, _) => print("Error writing document: $e")),
                          uploadFile(),
                          Navigator.pop(context),
                        },
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: itemRoot(),
    );
  }
}

