import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:e_commerce/Home_screen.dart';
import 'package:e_commerce/itemRoot.dart';
import 'package:e_commerce/profile_screen.dart';
import 'package:e_commerce/search_screen.dart';
import 'package:e_commerce/shop_screen.dart';
import 'package:e_commerce/upload_screen.dart';
import 'package:e_commerce/welcome_screen.dart';
import 'package:flutter/material.dart';

import 'Push_posts.dart';

class main_screen extends StatefulWidget {
  const main_screen({Key? key}) : super(key: key);

  @override
  State<main_screen> createState() => _main_screenState();
}

int currentpage = 0;
List<Widget> pages = [home(), upload_data() , search(), push_posts(), profile() ,];

class _main_screenState extends State<main_screen> {
  @override
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
          icon: Icon(Icons.arrow_back_ios,color: Colors.black,),
        ),
        title: Text('E-commerce' ,style: TextStyle(color: Colors.black),),
        actions: [
          IconButton(onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => shop()));
        },
            icon: Icon(Icons.shopping_cart_outlined,size: 25,color: Colors.black,),
        ),
          IconButton(onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => welcomepage()));
          },
            icon: Icon(Icons.logout,size: 25,color: Colors.black,),
          )
        ],
        backgroundColor: Colors.black12,
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

          ),DotNavigationBarItem(
            icon: Icon(Icons.search),
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
        selectedItemColor: Colors.redAccent,
        onTap: _onItemTapped,
      ),
      extendBody:  true,
      body: pages[currentpage],
    );
  }
}
/* currentIndex: currentpage,
        selectedItemColor: Colors.redAccent,
        onTap: _onItemTapped,*/