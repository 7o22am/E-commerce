
import 'package:e_commerce/upload_iteam/Push_posts.dart';
import 'package:e_commerce/log_screens/login_screen.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main/Root.dart';
import 'service/firebase_options.dart';
import 'log_screens/welcome_screen.dart';
late bool check=false;
void main() async {
  // These two lines
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp( options: DefaultFirebaseOptions.currentPlatform,);
  await FirebaseAppCheck.instance.activate(webRecaptchaSiteKey: 'recaptcha-v3-site-key');
  final prefs = await SharedPreferences.getInstance();
  try{
    check = prefs.getBool('Remember')!;
  }
  catch(e){
    check=false;
  }

  runApp(MyApp());
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'new2',
          primaryColor: Colors.lightBlue
      ),

      home:( check == true) ? main_screen() : welcome_page() ,
    );
  }
}

