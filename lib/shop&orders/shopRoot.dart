import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/log_screens/registration_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class shopRoot extends StatefulWidget {
  @override
  _shopRootState createState() => _shopRootState();
}
class _shopRootState extends State<shopRoot> {
  final user = FirebaseAuth.instance.currentUser;
  FirebaseFirestore db = FirebaseFirestore.instance;
  DateTime current_date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('${user?.email}').snapshots(),
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
            //   print(document.id);
            return item(location: data['location'], type: data['type'],
              price: data['price'], image: data['image'],duc_id: document.id,
              email: data['Email'], current_user: '${user?.email}', current_data: '$current_date',
              phone_num: data['phone'], new_price: data['new_price'] ,
              /* title: Text(data['Email']),
              subtitle: Text(data['Email']),*/

            );
          })
              .toList()
              .cast(),
        );
      },
    );
  }
}
class item extends StatelessWidget {
  item({required this.email ,required this.type , required this.price,
    required this.location, required this.image,
    required this.duc_id, required this.current_user,
    required this.current_data, required this.phone_num ,required this.new_price,
  });
  final String email ,type , price , location ,    new_price,
      image ,duc_id ,current_user , current_data ,phone_num;
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
          children: [

            Listitem(type: '$type', price: '$price' ,time: '$current_data',
                location: '$location' ,imagesee: '$image'),

            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary:  Color(0xFF111328)
                ),
                onPressed: () {
                  final user = FirebaseAuth.instance.currentUser;
                  db.collection('${user?.email}').doc('$duc_id').delete();
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: const Text(' Deleted successfully '),
                    duration: const Duration(seconds: 2),
                    action: SnackBarAction(
                      label: 'back ?',
                      onPressed: () {
                        db.collection('${user?.email}').doc().set({
                          'Email': email,
                          'image':image,
                          'type': type,
                          'price': price,
                          'location': location,
                          'phone':phone_num,
                          'current_data': current_data
                        }).onError(
                                (e, _) => print("Error writing document: $e"));

                      },
                    ),
                  ));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Remove     ',
                      style: TextStyle(
                          fontSize: 15.0,
                      ),
                    ),
                    Icon(
                      Icons.delete,
                    )
                  ],
                )),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary:  Color(0xFF111328)
                ),

                onPressed: () {
                  final user = FirebaseAuth.instance.currentUser;
                  db.collection('Orders').doc().set({
                    'Email': user?.email,
                    'phone':phone_num ,
                    'id': duc_id,
                    'order_time':'time',
                    'count': '1' ,
                    'price':price,
                    'new_price':new_price,
                    'image':image,
                    'location': location,
                    'type':type
                  }).onError((e, _) =>
                      print("Error writing document: $e"));
                  db.collection('${user?.email}').doc('$duc_id').delete();
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: const Text(' Add successfully '),
                    duration: const Duration(seconds: 2),
                    action: SnackBarAction(
                      label: 'Go to Orders',
                      onPressed: () {


                      },
                    ),
                  ));

                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Text(
                      'Order now   ',
                      style: TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'new2'
                      ),
                    ),
                    Icon(
                      Icons.car_crash_outlined,

                    )
                  ],
                )),
          ],
        ));
  }
}
class Listitem extends StatelessWidget {
  Listitem ({required this.type ,required this.time,
    required this.price ,required this.location,
    required this.imagesee});
  String type , price , location ,time ,imagesee;
  @override
  Widget build(BuildContext context) {
    return ListTile(

      title: Text (type   , style: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.bold,
          color: Colors.lightBlue),
      ),
      subtitle: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$price',
            style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold),
          ),
          Text(
            time,
            style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold),
          ),
          Text(
            location,
            style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      horizontalTitleGap: 16.0,
      leading: Image.network('$imagesee',height: 10000.0),

    );
  }
}