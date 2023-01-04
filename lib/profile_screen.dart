import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/shop_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'Push_posts.dart';
import 'Root.dart';
import 'orders.dart';

var mAuth = FirebaseAuth.instance;
DateTime current_date = DateTime.now();
FirebaseFirestore db = FirebaseFirestore.instance;

class profile extends StatefulWidget {
  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  CollectionReference users =
  FirebaseFirestore.instance.collection('user_Inf');
  late String username, phone_num, city;

  File? _photo;
  final ImagePicker _picker = ImagePicker();
  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    try{
      setState(() {
        if (pickedFile != null) {
          _photo = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });
      image_name = pickedFile?.name as String;
      if(_photo!=null)
          uploadFile();
    }
    catch(e){
      return debugPrint('error her');
    }

  }

  Future uploadFile() async {
    if (_photo == null) return;
    try {
      final fileName = basename(_photo!.path);
      final destination = '$fileName';
      final ref =
          firebase_storage.FirebaseStorage.instance.ref().child(destination);
      await ref.putFile(_photo!);
      setState(() async {
        image_url = (await ref.getDownloadURL()).toString();
      });

      ;
    } catch (e) {
      print('error occurred link ');
    }
  }

  @override
  Widget build(BuildContext context) {
    user?.reload();
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      child: FutureBuilder<DocumentSnapshot>(
        future: users.doc('${(user?.email)}').get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }
          if (snapshot.hasData && !snapshot.data!.exists) {
            return Text("Document does not exist");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 24.0,
                ),
                /*  CircleAvatar(
                  backgroundImage: AssetImage('image/ks.gif' , ),
                  minRadius: 90.0,


                ) ,*/
                Stack(
                  children: [
                    Image.asset('image/regis.gif'),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          height: 380,
                        )),
                    Positioned(
                        top: 200,
                        left: 5,
                        child: GestureDetector(
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(data['image']),
                            minRadius: 80.0,
                          ),
                          onTap: (() {
                            imgFromGallery();
                            db
                                .collection('user_Inf')
                                .doc('${(data['email'])}')
                                .update({
                              'image': image_url,
                            }).onError((e, _) =>
                                    print("Error writing document: $e"));
                          }),
                        )),
                    Positioned(
                        top: 340, left: 75, child: Icon(Icons.linked_camera))
                  ],
                ),
                TextField(
                  onChanged: (value) {
                    if (value.isNotEmpty)
                      username = value;
                    else
                      username = data['name'];
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: '${(data['name'])}'.toUpperCase(),
                    hintText: 'Enter Your Name',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF111328), width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 14.0,
                ),
                TextField(
                  enabled: false,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: '${(data['email'])}',
                    hintText: 'Enter Your Email',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF111328), width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 14.0,
                ),
                TextField(
                  onChanged: (value) {
                    if (value.isNotEmpty)
                      phone_num = value;
                    else
                      phone_num = data['phone_num'];
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: '${(data['phone_num'])}',
                    hintText: 'Enter Your Phone Number ',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF111328), width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 14.0,
                ),
                TextField(
                  onChanged: (value) {
                    if (value.isNotEmpty)
                      city = value;
                    else
                      city = data['city'];
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: '${(data['city'])}',
                    hintText: 'Enter Your City ',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF111328), width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 18.0,
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 50.0),
                  child: Material(
                    color: Color(0xFF111328),
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    elevation: 5.0,
                    child: MaterialButton(
                      onPressed: () async {
                        db
                            .collection('user_Inf')
                            .doc('${(data['email'])}')
                            .update({
                          'name': username,
                          'phone_num': phone_num,
                          'city': city,
                        }).onError(
                                (e, _) => print("Error writing document: $e"));
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: const Text(' Edited successfully '),
                          duration: const Duration(seconds: 3),
                          action: SnackBarAction(
                            label: 'back ?',
                            onPressed: () {
                              db
                                  .collection('user_Inf')
                                  .doc('${(data['email'])}')
                                  .update({
                                'name': '${(data['name'])}',
                                'phone_num': '${(data['phone_num'])}',
                                'city': '${(data['city'])}',
                              }).onError((e, _) =>
                                      print("Error writing document: $e"));
                            },
                          ),
                        ));
                      },
                      minWidth: 200.0,
                      height: 42.0,
                      child: Text(
                        'Update !',
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 50.0),
                  child: Material(
                    color: Color(0xFF111328),
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    elevation: 5.0,
                    child: MaterialButton(
                      onPressed: () async {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => shop()));
                      },
                      minWidth: 200.0,
                      height: 42.0,
                      child: Text(
                        ' My Car ',
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 50.0),
                  child: Material(
                    color: Color(0xFF111328),
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    elevation: 5.0,
                    child: MaterialButton(
                      onPressed: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => myorders()));
                      },
                      minWidth: 200.0,
                      height: 42.0,
                      child: Text(
                        ' My Orders ',
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 50.0),
                  child: Material(
                    color: Color(0xFF111328),
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    elevation: 5.0,
                    child: MaterialButton(
                      onPressed: () async {
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content:  Text(' Check your E-mail ${user!.email.toString()}  '),
                          duration: const Duration(seconds: 3),
                          action: SnackBarAction(
                            label: 'Go ',
                            onPressed: () async {
                              setState(() async {
                                await FirebaseAuth.instance
                                    .sendPasswordResetEmail(
                                        email: user!.email.toString());
                              });
                            },
                          ),
                        ));
                      },
                      minWidth: 200.0,
                      height: 42.0,
                      child: Text(
                        'Reset your Password ',
                        style: TextStyle(fontSize:20.0, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            );
            // Text("Full Name: ${data['phone_num']} ${data['name']}");
          }

          return Text("loading");
        },
      ),
    );
  }
}
