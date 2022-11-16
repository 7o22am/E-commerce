import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/registration_scrren.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'Root.dart';

final _firestore = FirebaseFirestore.instance;

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);
  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  @override
  final user = FirebaseAuth.instance.currentUser;
  String email='';
  String pass = '';
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:  Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 120.0,
              ),
              Container(
                height: 200.0,
                child: Image.asset('image/log_in_image.png'),
              ),
            /*  Center(
                  child: Text('LOG IN' ,style: TextStyle(fontSize: 40 ,color: Colors.lightBlue ,),),
              ),*/
              SizedBox(
                height: 48.0,
              ),
              TextField(
                onChanged: (value) {
                  email=value;
                },
                decoration: InputDecoration(
                  hintText: 'Enter your Email',
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                    BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                    BorderSide(color: Colors.lightBlueAccent, width: 2.0),
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
                  pass =value;
                },
                decoration: InputDecoration(
                  hintText: 'Enter your Password ',
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                    BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                    BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  elevation: 5.0,
                  child: MaterialButton(
                    onPressed: ()   async {
                      try {
                        final currentuser = await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: email,
                            password: pass
                        );
                        if(currentuser != null ){
                          tost('WELLCOME');
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => main_screen()));}
                        else
                        {
                          tost('Wrong Email or Password !');
                        }
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          tost('No user found for that email.');
                        } else if (e.code == 'wrong-password') {
                          tost('Wrong password provided for that user.');
                        }
                      }


                    },
                    minWidth: 200.0,
                    height: 42.0,
                    child: Text(
                      'Log In',
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Text('                 Dont have account ?') ,
                  TextButton(onPressed: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => registration()));
                  }, child: Text ('Sign-in'))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}