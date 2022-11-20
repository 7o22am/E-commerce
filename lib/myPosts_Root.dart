import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';


bool buy_it = false;
FirebaseFirestore db = FirebaseFirestore.instance;
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
              return item2(location: data['location'], type: data['type'],
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
class item2 extends StatelessWidget {
  item2({required this.email ,required this.type , required this.price,
    required this.location, required this.image,
    required this.duc_id, required this.current_user,required this.image_name,
    required this.current_data});
  final String email ,type , price , location ,
      image ,duc_id ,current_user , current_data ,image_name ;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
          children: [
            Slidable(
              endActionPane:  ActionPane(
                motion: ScrollMotion(),
                children: [
                  SlidableAction(
                    flex: 1,
                    onPressed:(BuildContext context) async {
                           db.collection('Post').doc('$duc_id').delete();
                         final storageRef = FirebaseStorage.instance.ref(image_name);
                         final desertRef = storageRef.child('file/');
                         await desertRef.delete();

                    },
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.black,
                    icon: Icons.delete,
                    label: 'Delete',
                  ),

                ],
              ),

              child: ListTile(

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
                      current_data,
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      location,
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                trailing:Icon(Icons.arrow_forward_ios_outlined),
                horizontalTitleGap: 16.0,
                leading: Image.network('$image'),


              ),


            ),

      /*      ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Color(0xFF111328)
                ),
                onPressed: () async {
                  db.collection('Post').doc('$duc_id').delete();
                  final storageRef = FirebaseStorage.instance.ref(image_name);
                  final desertRef = storageRef.child('file/');
                  await desertRef.delete();

                /*  Scaffold.of(context).showSnackBar(SnackBar(
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
                  ));*/
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
                ))*/
          ],
        ));
  }
}

