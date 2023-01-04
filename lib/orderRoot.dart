import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Root.dart';

class ordersRoot extends StatefulWidget {
  const ordersRoot({Key? key}) : super(key: key);

  @override
  State<ordersRoot> createState() => _ordersRootState();
}
FirebaseFirestore db = FirebaseFirestore.instance;
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
              return List_orders_item(order_email: data['Email'],
                order_id: data['id'],
                order_phone: data['phone'],
                order_price: data['price'],
                order_totalprice: data['price'],
                order_image: data['image'],
                order_count: data['count'],
                order_type: data['type'],
                order_new_price: data['new_price'],
                order_data: data['order_time'].toString(), doc_id:document.id , );
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
  List_orders_item ({required this.order_id ,required this.order_email,
    required this.order_phone ,required this.order_image,
    required this.order_price,
    required this.order_totalprice,required this.order_count
    ,required this.order_type ,required this.order_new_price,
    required this.order_data ,required this.doc_id
  });
  String order_id , order_email , order_phone ,order_image,order_price
  ,order_totalprice , order_count ,order_type , order_new_price ,order_data ,doc_id;

  @override
  Widget build(BuildContext context) {
    return ListTile(

      title: Text (order_type   , style: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.bold,
          color: Colors.lightBlue),
      ),
      subtitle: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Time : $order_data',
            style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold),
          ),
          Text(
            'you order $order_count items  total cost $order_totalprice EGY',
            style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold),
          ),
          Text(
            'Come sooooooooooooooooon',
            style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold),
          ),
        ],
      ),

      horizontalTitleGap: 16.0,
      leading: Image.network('$order_image',height: 1000000000000.0,),
      trailing: IconButton(
        icon: new Icon(
          Icons.close,
          size: 20,
        ),
        onPressed: () {
          db.collection('Orders').doc('$doc_id').delete();
          Scaffold.of(context).showSnackBar(SnackBar(
            content: const Text('Sure, Delete order ? '),
            duration: const Duration(seconds: 3),
            action: SnackBarAction(
              label: 'back ?',
              onPressed: () {

              },
            ),
          ));
        },
      ),


    );
  }
}