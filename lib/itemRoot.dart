import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Push_posts.dart';
import 'package:e_commerce/registration_screen.dart';
import 'package:e_commerce/shop_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

bool buy_it = false;
FirebaseFirestore db = FirebaseFirestore.instance;
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
          physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            shrinkWrap: true,
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
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
          children: [
            SizedBox(height: 14.0,),
            Listitem(type: '$type', price: '$price EGY' ,time: '$current_data',
                location: '$location' ,imagesee: '$image',
              current_user: '$current_user', email: '$email', image: '$image',
             ),
         /*  ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary:  Color(0xFF111328)
              ),

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
                        fontSize: 20.0,
                          fontFamily: 'new2'
                      ),
                    ),
                    Icon(
                      Icons.shopping_cart_outlined,

                    )
                  ],
                )),*/
          ],
        ));
  }
}
class Listitem extends StatelessWidget {
  Listitem ({required this.type ,required this.time,
    required this.price ,required this.location,required this.current_user,
    required this.imagesee,required this.email,required this.image,
  });
   String type , price , location ,time ,
       imagesee,current_user,email,image;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ListTile(

        title: Text (type   , style: TextStyle(

            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            color: Colors.lightBlue),maxLines: 1,
        ),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$price',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),maxLines: 1,
            ),
          ],
        ),
        trailing: IconButton(
          icon: new Icon(Icons.add_shopping_cart,size: 35,),
            onPressed: () {
              db.collection(current_user).doc().set({
                'Email': email,
                'image':image,
                'type': type,
                'price': price,
                'location': location,
                'current_data': time,
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
        ),
        horizontalTitleGap: 16.0,
          leading: Image.network('$imagesee',height: 10000.0),

      ),
      onTap: ((){
       showModalBottomSheet(context: context, builder:  (BuildContext context){
         return Padding(padding: EdgeInsets.all(8),
           child: Container(
             child:  Column(
               children: [
                 ListTile(

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

                 ),
                 ElevatedButton(
                     style: ElevatedButton.styleFrom(
                         primary:  Color(0xFF111328)
                     ),

                     onPressed: () {
                       db.collection(current_user).doc().set({
                         'Email': email,
                         'image':image,
                         'type': type,
                         'price': price,
                         'location': location,
                         'current_data': time,
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
                               fontSize: 20.0,
                               fontFamily: 'new2'
                           ),
                         ),
                         Icon(
                           Icons.shopping_cart_outlined,

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
                               '    Messenger    ',
                               style: TextStyle(
                                   fontSize: 18.0,
                                   fontFamily: 'new2'

                               ),
                             ),
                             Icon(
                               Icons.message,
                             )
                           ],
                         )),
                     ElevatedButton(
                         style: ElevatedButton.styleFrom(
                             primary: Color(0xFF111328)
                         ),
                         onPressed: () {
                           final Uri _url = Uri.parse('tel:$phone_num');
                           launchUrl(_url);
                         },
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Text(
                               '       Call      ',
                               style: TextStyle(
                                   fontSize: 18.0,
                                   fontFamily: 'new2'
                               ),
                             ),
                             Icon(
                               Icons.call,

                             ),

                           ],
                         ))
                   ],
                 )
               ],
             ),
           ),
         );
       });
      }),
    );
  }
}
