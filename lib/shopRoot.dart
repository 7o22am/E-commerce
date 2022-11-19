import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/registration_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

bool buy_it = false;
class shopRoot extends StatefulWidget {
  @override
  _shopRootState createState() => _shopRootState();
}
final user = FirebaseAuth.instance.currentUser;
class _shopRootState extends State<shopRoot> {

  final Stream<QuerySnapshot> _usersStream =
  FirebaseFirestore.instance.collection('${user?.email}').snapshots();
  FirebaseFirestore db = FirebaseFirestore.instance;

  DateTime current_date = DateTime.now();
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
            //   print(document.id);
            return item(location: data['location'], type: data['type'],
              price: data['price'], image: data['image'],duc_id: document.id,
              email: data['Email'], current_user: '${user?.email}', current_data: '$current_date',
              phone_num: data['phone'] ,
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
    required this.current_data, required this.phone_num});
  final String email ,type , price , location ,
      image ,duc_id ,current_user , current_data ,phone_num;
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

            Listitem(type: '$type', price: '$price' ,time: '$current_data',
                location: '$location' ,imagesee: '$image'),

            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary:  Color(0xFF111328)
                ),
                onPressed: () {
                  db.collection(current_user).doc('$duc_id').delete();
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: const Text(' Deleted successfully '),
                    duration: const Duration(seconds: 2),
                    action: SnackBarAction(
                      label: 'back ?',
                      onPressed: () {
                        db.collection(current_user).doc().set({
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
                          fontSize: 20.0,
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


                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Text(
                      'Order now   ',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'new2'
                      ),
                    ),
                    Icon(
                      Icons.car_crash_outlined,

                    )
                  ],
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary:  Color(0xFF111328)
                    ),
                    onPressed: () {

                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '    Messenger     ',
                          style: TextStyle(
                              fontSize: 18.0,
                          ),
                        ),
                        Icon(
                          Icons.message,
                        )
                      ],
                    )),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary:  Color(0xFF111328)
                    ),
                    onPressed: () {
                      final Uri _url = Uri.parse('tel:$phone_num');
                      launchUrl(_url);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '       Call  ',
                          style: TextStyle(
                              fontSize: 18.0,
                          ),
                        ),
                        Icon(
                          Icons.call,

                        ),
                        Text(
                          '    ',
                          style: TextStyle(
                              fontSize: 18.0,
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
class Listitem extends StatelessWidget {
  Listitem ({required this.type ,required this.time,
    required this.price ,required this.location,
    required this.imagesee});
  String type , price , location ,time ,imagesee;
  @override
  Widget build(BuildContext context) {
    return ListTile(

      title: Text (type   , style: TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
          color: Colors.lightBlue),
      ),
      subtitle: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$price',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          Text(
            time,
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          Text(
            location,
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      horizontalTitleGap: 16.0,
      leading: Image.network('$imagesee',height: 10000.0),

    );
  }
}