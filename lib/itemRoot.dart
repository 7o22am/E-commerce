import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/registration_scrren.dart';
import 'package:e_commerce/shop_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

bool buy_it = false;
class itemRoot extends StatefulWidget {
  @override
  _itemRootState createState() => _itemRootState();
}

class _itemRootState extends State<itemRoot> {
  final Stream<QuerySnapshot> _usersStream =
  FirebaseFirestore.instance.collection('Post').snapshots();
  FirebaseFirestore db = FirebaseFirestore.instance;
  @override  final user = FirebaseAuth.instance.currentUser;
  DateTime current_date = DateTime.now();
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
         //   print(document.id);
            return item(location: data['location'], type: data['type'],
              price: data['price'], image: data['image'],duc_id: document.id,
              email: data['Email'] , current_user: '${user?.email}', current_data: '$current_date', phone_num: data['phone'],
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
   required this.location, required this.image, required this.duc_id,
   required this.current_user,
   required this.current_data, required this.phone_num});
final String email ,type , price , location ,
    image ,duc_id ,current_user , current_data , phone_num;
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
            Image.network(image,height: 220.0,),
            SizedBox(height: 14.0,),
            Row(
              children: [
                Text(
                  ' Time push : ',
                  style: TextStyle(
                      fontSize: 17.0,

                      fontWeight: FontWeight.bold,
                      color: Colors.lightBlue),
                ),
                Text(
                  '$current_data',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  ' Type  : ',
                  style: TextStyle(
                      fontSize: 17.0,

                      fontWeight: FontWeight.bold,
                      color: Colors.lightBlue),
                ),
                Text(
                  '$type',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  ' Price  : ',
                  style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.lightBlue),
                ),
                Text(
                  '$price',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  ' Location  : ',
                  style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.lightBlue),
                ),
                Text(
                  '$location',
                  maxLines: 1,
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),

            ElevatedButton(
                onPressed: () {
                  db.collection(current_user).doc().set({
                    'Email': email,
                    'image':image,
                    'type': type,
                    'price': price,
                    'location': location,
                    'current_data': current_data,
                    'phone': phone_num
                  }).onError(
                          (e, _) => print("Error writing document: $e"));
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: const Text(' Add to Car successfully '),
                    duration: const Duration(seconds: 3),
                    action: SnackBarAction(
                      label: 'Car ?',
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => shop()));
                      },
                    ),
                  ));
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

                    )
                  ],
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {

                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '     Messanger    ',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        Icon(
                          Icons.message,
                        )
                      ],
                    )),
                ElevatedButton(
                    onPressed: () {
                      final Uri _url = Uri.parse('tel:$phone_num');
                      launchUrl(_url);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '             Call   ',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        Icon(
                          Icons.call,

                        ),
                        Text(
                          '            ',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ))
              ],
            )
          ],
        ));
  }
}
