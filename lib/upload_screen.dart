import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class upload_data extends StatefulWidget {
  const upload_data({Key? key}) : super(key: key);

  @override
  State<upload_data> createState() => _upload_dataState();
}

class _upload_dataState extends State<upload_data> {
  @override
  File? image;
  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageset = File(image.path);
    setState(() {
      this.image = imageset;
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          image != null
              ? Image.file(
            image!,
            height: 20,
            width: 30,
          )
              : FlutterLogo(
            size: 30.0,
          ),
        ElevatedButton(onPressed: () {
          setState(() {
          pickImage();
          });
        }, child:  Text('Select Image2'),
        ),
          Tab(
            icon: Container(
              child: Image(
                image: AssetImage(
                  'image/logo.png',
                ),
                fit: BoxFit.cover,
              ),
              height: 100,
              width: 100,

            ),

          )
        ],
      ),
    );
  }
}
