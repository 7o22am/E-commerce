import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/registration_scrren.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'itemRoot.dart';

bool buy_it = false;
class uploadRoot extends StatefulWidget {
  @override
  _uploadRootState createState() => _uploadRootState();
}
final user = FirebaseAuth.instance.currentUser;
class _uploadRootState extends State<uploadRoot> {

  final Stream<QuerySnapshot> _usersStream =
  FirebaseFirestore.instance.collection('Post').snapshots();
  FirebaseFirestore db = FirebaseFirestore.instance;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

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
          physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          children: snapshot.data!.docs
              .map((DocumentSnapshot document) {
            Map<String, dynamic> data =
            document.data()! as Map<String, dynamic>;
            if(data['Email'] == '${user?.email}'){
              return item(location: data['location'], type: data['type'],
                price: data['price'], image: data['image'],duc_id: document.id,
                email: data['Email'], current_user: '${user?.email}',
                current_data: '$current_date', image_name: data['image_name'] ,

              );
            }
            else return SizedBox(height: 1,);

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
    required this.duc_id, required this.current_user,required this.image_name,
    required this.current_data});
  final String email ,type , price , location ,
      image ,duc_id ,current_user , current_data ,image_name ;
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
                    primary: Color(0xFF111328)
                ),
                onPressed: () async {
                  db.collection('Post').doc('$duc_id').delete();
                  final storageRef = FirebaseStorage.instance.ref(image_name);
                  final desertRef = storageRef.child('file/');
                  await desertRef.delete();

                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: const Text(' Deleted successfully '),
                    duration: const Duration(seconds: 3),
                    action: SnackBarAction(
                      label: 'back ?',
                      onPressed: () {
                        db.collection('Post').doc().set({
                          'Email': email,
                          'image':image,
                          'type': type,
                          'price': price,
                          'location': location,
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
                      ' Stop displaying it on the home page ',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),

                  ],
                ))
          ],
        ));
  }
}
