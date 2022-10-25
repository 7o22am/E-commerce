import 'package:e_commerce/shopRoot.dart';
import 'package:e_commerce/upload_Root.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'itemRoot.dart';

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
        title: Text('E-commerce'),
        actions: [IconButton(onPressed: () {

        },
            icon: Icon(Icons.info,size: 25))],
      ),
      body: shopRoot(),
    );
  }
}
