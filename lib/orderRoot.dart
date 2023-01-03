import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Root.dart';

class ordersRoot extends StatefulWidget {
  const ordersRoot({Key? key}) : super(key: key);

  @override
  State<ordersRoot> createState() => _ordersRootState();
}

class _ordersRootState extends State<ordersRoot> {
  @override
  final Stream<QuerySnapshot> _usersStream =
  FirebaseFirestore.instance.collection('Orders').snapshots();
  FirebaseFirestore db = FirebaseFirestore.instance;

  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        return ListView(

          children: snapshot.data!.docs
              .map((DocumentSnapshot document) {
            Map<String, dynamic> data =
            document.data()! as Map<String, dynamic>;
             //  print(data['id']);
         if(user?.email == data['Email'])
            return List_orders_item(email: data['Email'], id: data['id'],
              phone: data['phone']);
         else
           return SizedBox();

              /* title: Text(data['Email']),
              subtitle: Text(data['Email']),*/


          })
              .toList()
              .cast(),
        );
      },
    );
  }
}

class List_orders_item extends StatelessWidget {
  List_orders_item ({required this.id ,required this.email,
    required this.phone ,
  });
  String id , email , phone  ;
  @override
  Widget build(BuildContext context) {
    return ListTile(

      title: Text (id   , style: TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
          color: Colors.lightBlue),
      ),
      subtitle: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$email',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          Text(
           phone,
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      horizontalTitleGap: 16.0,

    );
  }
}