import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';
import 'Home_screen.dart';
import 'Root.dart';

late String location = '', price = '', type = '',count='',
    phone_num = '',  dep,image_url='',image_name='';
bool buy_it = false;

class push_posts extends StatefulWidget {
  const push_posts({Key? key}) : super(key: key);
  @override
  State<push_posts> createState() => _push_postsState();
}

void tost(String wrong) {
  Fluttertoast.showToast(
      msg: wrong,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
      fontSize: 16.0);
}

final user = FirebaseAuth.instance.currentUser;
DateTime current_date = DateTime.now();
FirebaseFirestore db = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;
firebase_storage.FirebaseStorage storage =
    firebase_storage.FirebaseStorage.instance;


class _push_postsState extends State<push_posts> {
  void initState() {
    super.initState();

  }
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
    image_name =pickedFile?.name as String;
    uploadFile();
    Timer(Duration(seconds: 2), () {
      print("Yeah, this line is printed immediately");
    });
  }

  Future uploadFile() async {
    if (_photo == null) return;
    try {
        final fileName = basename(_photo!.path);
        final destination = '$fileName';
        final ref = firebase_storage.FirebaseStorage.instance
            .ref(destination)
            .child('file/');
        await ref.putFile(_photo!);
         setState(() async {
           image_url = (await ref.getDownloadURL()).toString();
         });

      ;
    } catch (e) {
      print('error occurred');
    }

  }

  @override

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 30.0,),
              _photo != null
                  ? Image.file(
                      _photo!,
                      height: 200,
                      width: 200,
                    )
                  : FlutterLogo(
                      size: 200.0,
                    ),
              SizedBox(height: 30.0,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Color(0xFF111328)),
                onPressed: () {
                  setState(() {
                    imgFromGallery();
                  });
                },
                child: const Text(' Press to select Image ',
    style: TextStyle(color: Colors.white , fontSize: 18.0) ,),
              ),
                  SizedBox(
                    height: 25.0,
                  ),
                  DropDown(
                    items: [
                      'Mobiles, Tablets & Accessories',
                      'Computers & Office Supplies',
                      'TVs & Electronics',
                      'mens Fashion',
                      ' WoMens Fashion',
                      'Kids Fashion',
                      ' Health, Beauty & Perfumes',
                      '  Supermarket',
                      ' Furniture & Tools',
                      ' Kitchen & Appliances',
                      'Toys, Games & Baby',
                      ' Sports',
                      'Fitness & Outdoors',
                      ' Books',
                      ' Video Games',
                      'Automotiv'
                    ],
                    hint: Text("Select department please "),
                    icon: Icon(
                      Icons.expand_more,
                      color: Colors.blue,
                    ),
                      onChanged: (value){
                        setState(() {
                           dep = value.toString();
                        });
                      },
                  ),
              SizedBox(
                height: 25.0,
              ),
              TextField(
                  onChanged: (value) {
                    type = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter Type Of Item',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  )),
              TextField(
                  onChanged: (value) {
                    count = value;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Enter count ',
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                  )), //count
              TextField(
                  onChanged: (value) {
                    price = value;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Enter Your Price by (EGY)',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                  )), //Type
              TextField(
                  onChanged: (value) {
                    location = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter Your Location ',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  )), //Price

              TextField(
                  onChanged: (value) {
                    phone_num = value;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Enter Your Phone Number ',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  )), //Price
              SizedBox(
                height: 35.0,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Color(0xFF111328)),
                child: const Text('  Push Now   ',
    style: TextStyle(color: Colors.white , fontSize: 18.0) ),
                onPressed: () => {
                    if (location.isNotEmpty &&
                        type.isNotEmpty &&
                        price.isNotEmpty &&
                        phone_num.isNotEmpty &&
                        _photo != null) {
                      current_date = DateTime.now(),
                      db.collection("Post").doc().set({
                        'Email': user?.email,
                        'image': image_url,
                        'image_name' :image_name,
                        'location': location,
                        'type': type,
                        'department' : dep,
                        'price': price,
                        'count': count,
                        'phone': phone_num,
                        'current_data': current_date,
                        'new_price': ''
                      }).onError((e, _) => print("Error writing document: $e")),
                    } else {
                      tost(' Enter all data '),
                    },
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => main_screen())),

                },
              ),
              SizedBox(
                height: 100.0,
              ),
            ],
          ),


    );
  }
}
