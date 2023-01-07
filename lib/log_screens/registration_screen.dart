import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'login_screen.dart';

class registration extends StatefulWidget {
  const registration({Key? key}) : super(key: key);
  @override
  State<registration> createState() => _registrationState();
}
FirebaseFirestore db = FirebaseFirestore.instance;
class _registrationState extends State<registration> {
  @override
  final _auth = FirebaseAuth.instance;
  late  String username ;
  late String email  ;
  late String pass  ;
  late String phone_num  ;
  late String city  ;
  void tost(String wrong) {
    Fluttertoast.showToast(
        msg: wrong,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 100.0,
              ),
              Container(
                height: 200.0,
                child: Image.asset('image/regis.gif'),
              ),   SizedBox(
                height: 30.0,
              ),
              Center(child: Text('Register now !',style: TextStyle(fontSize: 40 ,color: Colors.lightBlue ,),) ),
              SizedBox(
                height: 30.0,
              ),

              TextField(
                onChanged: (value) {
                  username = value;
                },
                decoration: InputDecoration(
                  hintText: 'Enter your Name ',
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 7.0, horizontal: 15.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),
              ),
              SizedBox(
                height: 14.0,
              ),
              TextField(
                onChanged: (value) {
                  email = value;
                },
                decoration: InputDecoration(
                  hintText: 'Enter your Email',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 7.0, horizontal:15.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),
              ),
              SizedBox(
                height: 14.0,
              ),
              TextField(
                obscureText: true,
                onChanged: (value) {
                  pass = value;
                },
                decoration: InputDecoration(
                  hintText: 'Enter your Password',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 7.0, horizontal: 15.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              TextField(
                onChanged: (value) {
                  phone_num = value;
                },
                decoration: InputDecoration(
                  hintText: 'Enter your Phone Number  ',
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 7.0, horizontal: 15.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),
              ),
              SizedBox(
                height: 14.0,
              ),
              TextField(
                onChanged: (value) {
                  city = value;
                },
                decoration: InputDecoration(
                  hintText: 'Enter your City ',
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 7.0, horizontal: 15.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),
              ),
              SizedBox(
                height: 14.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  elevation: 5.0,
                  child: MaterialButton(
                    onPressed: () async {

                      if (username.isNotEmpty && email.isNotEmpty &&
                          city.isNotEmpty&& phone_num.isNotEmpty && pass.isNotEmpty ) {
                        try {
                          final newusaer = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                            email: email,
                            password: pass,
                          );
                          if (newusaer != null) {
                            tost('Registration Complete Please Log In ');
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => login()));
                          } else {
                            tost('  Something Wrong ');
                          }
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            tost('The password provided is too weak.');
                          } else if (e.code == 'email-already-in-use') {
                            tost('The account already exists for that email.');
                          }
                        } catch (e) {
                          print(e);
                        }
                        db.collection("user_Inf").doc(email).set({
                          'name': username,
                          'email': email,
                          'city': city,
                          'phone_num': phone_num,
                          'image':'https://firebasestorage.googleapis.com/v0/b/e-commerce-98666.appspot.com/o/ks.gif?alt=media&token=09c054d1-3ef9-4aa6-a0c6-0b5a1ac5851b'
                        }).onError(
                                (e, _) => print("Error writing document: $e"));
                      }
                      else {tost('Empty Failed .. please Enter all ');
                      }

                    },
                    minWidth: 200.0,
                    height: 42.0,
                    child: Text(
                      'Register',
                      style: TextStyle(fontSize: 24.0 , color: Colors.white),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Text('               have account ?', style: TextStyle(color: Colors.black , fontSize: 18.0) ) ,
                  TextButton(onPressed: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => login()));
                  }, child: Text ('log-in', style: TextStyle(color: Colors.blue , fontSize: 18.0) ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
