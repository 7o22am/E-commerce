import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:e_commerce/log_screens/Home_screen.dart';
import 'package:e_commerce/shop&orders/orders.dart';
import 'package:e_commerce/log_screens/welcome_screen.dart';
import 'package:e_commerce/user%20profile/profile_screen.dart';
import 'package:e_commerce/shop&orders/shop_screen.dart';
import 'package:e_commerce/user%20profile/my_posts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../upload_iteam/Push_posts.dart';

final user = FirebaseAuth.instance.currentUser;
class main_screen extends StatefulWidget {
  const main_screen({Key? key}) : super(key: key);

  @override
  State<main_screen> createState() => _main_screenState();
}

int currentpage = 0;
List<Widget> pages = [home(), upload_data() ,  push_posts(), profile() ,];

class _main_screenState extends State<main_screen> {
  @override
  final user = FirebaseAuth.instance.currentUser;
  void _onItemTapped(int index) {
    setState(() {
      currentpage = index;
    });
  }
  int currentpage = 0;
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        leading: IconButton(
          onPressed: (){
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => main_screen()));
          },
          icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
        ),
        title: Text('E-commerce' ,style: TextStyle(color: Colors.white,
            fontFamily: 'new2' ,fontSize: 20.0
        ),),
        actions: [
          IconButton(onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => myorders()));
          },
            icon: Icon(Icons.car_crash_outlined,size: 25,color: Colors.white,),
          ),
          IconButton(onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => shop()));
        },
            icon: Icon(Icons.shopping_cart_outlined,size: 25,color: Colors.white,),
        ),
          IconButton(onPressed: () async {
            final prefs = await SharedPreferences.getInstance();
            setState(() async {
              await FirebaseAuth.instance.signOut();
              user?.reload();
              await prefs.setBool('Remember', false);
              await prefs.setString('email', '');
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => welcome_page()));
            });

          },
            icon: Icon(Icons.logout,size: 25,color: Colors.white,),
          )
        ],
        backgroundColor: Color(0x0FF0A0E21),
      ),
      bottomNavigationBar: DotNavigationBar(
        backgroundColor: Colors.black12,

        items: [
          DotNavigationBarItem(
              icon: Icon(Icons.home),
            selectedColor: Colors.purple,

          ),
          DotNavigationBarItem(
            icon: Icon(Icons.upload),
            selectedColor: Colors.purple,

          ), DotNavigationBarItem(
            icon: Icon(Icons.add),
            selectedColor: Colors.purple,
          ), DotNavigationBarItem(
            icon: Icon(Icons.person),
            selectedColor: Colors.purple,
          ),
        ],
        currentIndex: currentpage,
        selectedItemColor: Color(0xFF111328),
        onTap: _onItemTapped,
      ),
      extendBody:  false,
      body: pages[currentpage],
    );
  }
}
