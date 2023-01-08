import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_slidable/flutter_slidable.dart';

bool buy_it = false;
FirebaseFirestore db = FirebaseFirestore.instance;
String new_salary = '';

class uploadRoot extends StatefulWidget {
  @override
  _uploadRootState createState() => _uploadRootState();
}


class _uploadRootState extends State<uploadRoot> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('Post').snapshots();
  FirebaseFirestore db = FirebaseFirestore.instance;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  DateTime current_date = DateTime.now();
  final user = FirebaseAuth.instance.currentUser;
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
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          children: snapshot.data!.docs
              .map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                if ('${data['Email']}' == '${user?.email}') {
                  return item2(
                    location: data['location'],
                    type: data['type'],
                    price: data['price'],
                    image: data['image'],
                    duc_id: document.id,
                    email: data['Email'],
                    current_user: '${user?.email}',
                    current_data: '$current_date',
                    image_name: data['image_name'],
                    new_price: data['new_price'],
                  );
                } else
                  return SizedBox(
                    height: 1,
                  );
              })
              .toList()
              .cast(),
        );
      },
    );
  }
}

class item2 extends StatelessWidget {
  item2(
      {required this.email,
      required this.type,
      required this.price,
      required this.location,
      required this.image,
      required this.duc_id,
      required this.current_user,
      required this.image_name,
       required this.new_price,
      required this.current_data});
  final String email,
      type,
      price,
      location,
      image,
      duc_id,
      current_user,
      current_data,
      new_price,
      image_name;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      children: [
        Slidable(
          endActionPane: ActionPane(
            motion: ScrollMotion(),
            children: [
              SlidableAction(
                flex: 2,
                onPressed: (BuildContext context) async {
                  showModalBottomSheet(
                      context: context,

                      builder: (BuildContext context) {
                        return SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Container(
                              child: Column(
                                children: [
                                  SizedBox(height: 25.0),
                                  Text('Do You Went To Make Discount ?' ,style: TextStyle(
                                    fontSize: 10.0
                                  ), ),
                                  SizedBox(height: 20.0),
                                  TextField(
                                    onChanged: (value) {
                                      new_salary = value;
                                    },
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      labelText: 'New Price',
                                      hintText: 'Enter Your New Price ',
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 20.0),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 1.0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(32.0)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFF111328),
                                            width: 2.0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(32.0)),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 25.0),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 16.0, horizontal: 50.0),
                                    child: Material(
                                      color: Color(0xFF111328),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30.0)),
                                      elevation: 5.0,
                                      child: MaterialButton(
                                        onPressed: () async {
                                          if(new_salary.isNotEmpty){  db.collection('Post').doc('$duc_id').update({
                                            'new_price': new_salary,
                                          }).onError(
                                                  (e, _) => print("Error writing document: $e"));}



                                          Navigator.pop(context);
                                        },
                                        minWidth: 200.0,
                                        height: 42.0,
                                        child: Text(
                                          'Done',
                                          style: TextStyle(
                                              fontSize: 24.0,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 200.0),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                },
                backgroundColor: Colors.greenAccent,
                foregroundColor: Colors.white,
                icon: Icons.price_change_outlined,
                label: 'Discount',
              ),
              SlidableAction(
                flex: 1,
                onPressed: (BuildContext context) async {

                },
                backgroundColor: Colors.yellowAccent,
                foregroundColor: Colors.white,
                icon: Icons.share,
                label: 'Share',
              ),
              SlidableAction(
                flex: 1,
                onPressed: (BuildContext context) async {
                  db.collection('Post').doc('$duc_id').delete();
                  final storageRef = FirebaseStorage.instance.ref(image_name);
                  final desertRef = storageRef.child('file/');
                  await desertRef.delete();
                },
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ],

          ),
          child: ListTile(
            title: Text(
              type,
              style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.lightBlue),
            ),
            subtitle: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(new_price.isEmpty) Text(
                  '$price EGY'  ,
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                )
                else Row(
                  children: [
                    Text(
                      price ,
                      style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold,decoration: TextDecoration.lineThrough
                      ),
                      maxLines: 1,
                    ),
                    Text(
                      '  $new_price EGY' ,
                      style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                    )
                  ],
                ),
                Text(
                  current_data,
                  style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  location,
                  style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            trailing: Icon(Icons.arrow_forward_ios_outlined),
            horizontalTitleGap: 16.0,
            leading: Image.network('$image'),
          ),
        ),


      ],
    ));
  }
}
