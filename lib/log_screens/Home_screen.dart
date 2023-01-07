import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/main/itemRoot.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

late String location = '', price = '', type = '' , phone_num='' ,image_url='';
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
  void tost(String wrong ){
    Fluttertoast.showToast(
        msg: wrong ,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 16.0
    );
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
    final destination = '$fileName';
    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child('file/');

      await ref.putFile(_photo!);
      image_url = (await ref.getDownloadURL()).toString();
                    print(image_url);
    } catch (e) {
      print('error occurred');
    }
  }


  Widget build(BuildContext context) {
    return Scaffold(
      body: itemRoot(),
    );
  }
}

