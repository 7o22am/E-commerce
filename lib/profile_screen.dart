import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final user = FirebaseAuth.instance.currentUser;
DateTime current_date = DateTime.now();
FirebaseFirestore db = FirebaseFirestore.instance;

class profile extends StatelessWidget {
  String username ='' , phone_num='' , city='' ;
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('user_Inf');
    return SingleChildScrollView(
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
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
        /*    username = '${(data['name'])}';
            phone_num = '${(data['phone_num'])}';
            city = '${(data['city'])}';*/
            return  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 24.0,),
                CircleAvatar(
                  backgroundImage: AssetImage('image/logo.png' ),
                  minRadius: 80.0,
                ) ,
                SizedBox(height: 40.0,),
                TextField (
                  onChanged: (value) {
                     username =value;
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: '${(data['name'])}'.toUpperCase(),
                    hintText: 'Enter Your Name',
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),   enabledBorder: OutlineInputBorder(
                    borderSide:
                    BorderSide(color: Colors.white, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),

                  ),

                ),
                SizedBox(height: 14.0,),
                TextField (
                  enabled: false ,

                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: '${(data['email'])}',
                    hintText: 'Enter Your Email',
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),   enabledBorder: OutlineInputBorder(
                    borderSide:
                    BorderSide(color: Colors.white, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),

                  ),

                ),
                SizedBox(height: 14.0,),
                TextField (
                  onChanged: (value) {
                    phone_num =value;
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: '${(data['phone_num'])}',
                    hintText: 'Enter Your Phone Number ',
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),   enabledBorder: OutlineInputBorder(
                    borderSide:
                    BorderSide(color: Colors.white, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),

                  ),

                ),
                SizedBox(height: 14.0,),
                TextField (
                  onChanged: (value) {
                    city =value;
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: '${(data['city'])}',
                    hintText: 'Enter Your City ',
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),   enabledBorder: OutlineInputBorder(
                    borderSide:
                    BorderSide(color: Colors.white, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),

                  ),

                ),
                SizedBox(height: 14.0,),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Material(
                    color: Colors.lightBlueAccent,
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    elevation: 5.0,
                    child: MaterialButton(
                      onPressed: ()   async {

                        db.collection('user_Inf').doc('${(data['email'])}').update({
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
                              db.collection('user_Inf').doc('${(data['email'])}').update({
                                'name': '${(data['name'])}',
                                'phone_num': '${(data['phone_num'])}',
                                'city': '${(data['city'])}',
                              }).onError(
                                      (e, _) => print("Error writing document: $e"));
                            },
                          ),
                        ));
                      },
                      minWidth: 200.0,
                      height: 42.0,
                      child: Text(
                        'Updata !',

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