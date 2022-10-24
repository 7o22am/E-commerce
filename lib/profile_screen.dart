import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:path/path.dart';


class profile extends StatefulWidget {

  const profile({Key? key}) : super(key: key);

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  void initState() {
    super.initState();

    loadImage();
    printUrl();
  }

  void loadImage() async {

 final ref =  FirebaseStorage.instance.ref('/files/image_picker1236853947266465422.png');
 //final url = ref.getDownloadURL();
 print(ref.fullPath);
 print(ref.name);
 print(ref.root);

  }
  printUrl() async {
    final ref =
    FirebaseStorage.instance.ref().child('/files/image_picker1236853947266465422.png');
    String url = (await ref.getDownloadURL()).toString();
    print(url);
  }
  Widget build(BuildContext context) {
    
    return Column(
      children: [
        Text('dsadsds'),
        //Image.file(_image)
      ],

    );
  }
}
