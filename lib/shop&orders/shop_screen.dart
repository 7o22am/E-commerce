import 'package:e_commerce/shop&orders/shopRoot.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main/Root.dart';

import 'orders.dart';

class shop extends StatefulWidget {
  const shop({Key? key}) : super(key: key);

  @override
  State<shop> createState() => _shopState();
}

class _shopState extends State<shop> {
  @override
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
        title: Center(child: Text('My Shop' ,style: TextStyle(color: Colors.white,
            fontSize: 20.0,
            fontFamily: 'new2'),)),
        actions: [ IconButton(onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => myorders()));
        },
          icon: Icon(Icons.car_crash_outlined,size: 25,color: Colors.white,),
        ),
          IconButton(onPressed: () {

        },
            icon: Icon(Icons.info,size: 25,color: Colors.white,))
        ],
        backgroundColor: Color(0x0FF0A0E21),
      ),
      body: shopRoot(),
    );
  }
}
