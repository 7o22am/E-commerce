import 'package:e_commerce/Home_screen.dart';
import 'package:e_commerce/itemRoot.dart';
import 'package:e_commerce/profile_screen.dart';
import 'package:e_commerce/search_screen.dart';
import 'package:e_commerce/shop_screen.dart';
import 'package:e_commerce/upload_screen.dart';
import 'package:flutter/material.dart';

class main_screen extends StatefulWidget {
  const main_screen({Key? key}) : super(key: key);

  @override
  State<main_screen> createState() => _main_screenState();
}

int currentpage = 0;
List<Widget> pages = [home(), search(), upload_data()];

class _main_screenState extends State<main_screen> {
  @override
  void _onItemTapped(int index) {
    setState(() {
      currentpage = index;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('E-commerce'),
        actions: [IconButton(onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => shop()));
        },
            icon: Icon(Icons.shopping_cart_outlined,size: 25))],
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blueAccent,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.lightBlue),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'search',
              backgroundColor: Colors.lightBlue),
          BottomNavigationBarItem(
              icon: Icon(Icons.upload),
              label: 'upload',
              backgroundColor: Colors.lightBlue),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'profile',
              backgroundColor: Colors.lightBlue),
        ],
        currentIndex: currentpage,
        selectedItemColor: Colors.redAccent,
        onTap: _onItemTapped,
      ),
      body: pages[currentpage],
    );
  }
}
