
import 'package:e_commerce/orderRoot.dart';
import 'package:flutter/material.dart';

import 'Root.dart';
class myorders extends StatefulWidget {
  const myorders({Key? key}) : super(key: key);

  @override
  State<myorders> createState() => _myordersState();
}

class _myordersState extends State<myorders> {
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
        title: Center(child: Text('My Orders' ,style: TextStyle(color: Colors.white,
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
      body: ordersRoot(),

    );
  }
}
