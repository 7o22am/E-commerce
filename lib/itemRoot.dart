import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

bool buy_it = false;
class itemRoot extends StatefulWidget {
  @override
  _itemRootState createState() => _itemRootState();
}

class _itemRootState extends State<itemRoot> {
  final Stream<QuerySnapshot> _usersStream =
  FirebaseFirestore.instance.collection('Post').snapshots();

  @override
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
            return item(location: data['location'], type: data['type'], price: data['price'], image: '',
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
 item({required this.type , required this.price,
   required this.location, required this.image});
final String type , price , location , image;
String get_image_name(String image_path){
  String s = image_path;
  List ss =s.split('/');
  return ss.last;
}
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
          children: [
            Image.asset('image/logo.png'),
            Row(
              children: [
                Text(
                  '  Type  : ',
                  style: TextStyle(
                      fontSize: 20.0,

                      fontWeight: FontWeight.bold,
                      color: Colors.lightBlue),
                ),
                Text(
                  '$type',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  '  Price  : ',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.lightBlue),
                ),
                Text(
                  '$price',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  '  Location  : ',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.lightBlue),
                ),
                Text(
                  '$location',
                  maxLines: 1,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),

            ElevatedButton(
                onPressed: () {
                    buy_it == false ? buy_it = true : buy_it = false;
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Add TO Car   ',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    Icon(
                      Icons.shopping_cart_outlined,
                      color: buy_it == true ? Colors.red : Colors.black,
                    )
                  ],
                ))
          ],
        ));
  }
}
