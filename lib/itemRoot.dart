import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Push_posts.dart';
import 'package:e_commerce/registration_screen.dart';
import 'package:e_commerce/shop_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Root.dart';
import 'main.dart';


bool buy_it = false;
String select = 'All products';
FirebaseFirestore db = FirebaseFirestore.instance;
List<String> type_store = [
  'All products',
  'mens Fashion',
  'Mobiles, Tablets & Accessories',
  'Computers & Office Supplies',
  'TVs & Electronics',
  ' WoMens Fashion',
  'Kids Fashion',
  ' Health, Beauty & Perfumes',
  '  Supermarket',
  ' Furniture & Tools',
  ' Kitchen & Appliances',
  'Toys, Games & Baby',
  ' Sports',
  'Fitness & Outdoors',
  ' Books',
  ' Video Games',
  'Automotiv'
];
List<String> type_image = [
  'image/ks.gif',
  'image/story_image/men.png',
  'image/story_image/mobile.png',
  'image/story_image/computr.png',
  'image/story_image/tv.png',
  'image/story_image/woman.png',
  'image/story_image/kids.png',
  'image/story_image/helth.png',
  'image/story_image/super.png',
  'image/story_image/men.png',
  'image/story_image/mobile.png',
  'image/story_image/computr.png',
  'image/story_image/tv.png',
  'image/story_image/woman.png',
  'image/story_image/kids.png',
  'image/story_image/helth.png',
  'image/story_image/super.png',
  'image/story_image/mobile.png',
];

class itemRoot extends StatefulWidget {
  @override
  _itemRootState createState() => _itemRootState();
}

class _itemRootState extends State<itemRoot> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('user_Inf');
  @override
  final user = FirebaseAuth.instance.currentUser;
  DateTime current_date = DateTime.now();
  final berlinWallFell = DateTime.utc(1989, 11, 9);
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 50.0,
                ),
                Container(

                  child: FutureBuilder<DocumentSnapshot>(
                    future: users.doc('${(user?.email)}').get(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text("Something went wrong");
                      }
                      if (snapshot.hasData && !snapshot.data!.exists) {
                        return Text("Document does not exist");
                      }
                      if (snapshot.connectionState == ConnectionState.done) {
                        Map<String, dynamic> data =
                            snapshot.data!.data() as Map<String, dynamic>;
                        return Container(
                          alignment: Alignment.topLeft,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Color(0x0FF0A0E21),
                          ),
                          child: Text(
                            '   Hi,  ${data['name']}     ',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        );
                      }

                      return Text("loading");
                    },
                  ),
                ),
                CircleAvatar(
                  backgroundImage: AssetImage('image/new.gif'),
                  minRadius: 40.0,
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  select = value;
                });
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: ' Search by Type of Items ... ',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
              ),
            ),

          ],
        ), //search
       Padding(padding: const EdgeInsets.all(8.0), child: suggest()), //store
      ]),
    );
  }
}

class item extends StatelessWidget {
  item(
      {required this.email,
      required this.type,
      required this.price,
      required this.location,
      required this.image,
      required this.duc_id,
        required this. new_price,
      required this.current_user,
      required this.current_data,
        required this.count,
      required this.phone_num});
  final String email,
      type,
      price,
      location,
      image,
      duc_id,
      current_user,
      current_data,
      new_price,
      phone_num,count;
  @override
  Widget build(BuildContext context) {
    return Card(
     // color: Color(0x0FF0A0E21),
        child: Column(
      children: [
        SizedBox(
          height: 14.0,
        ),
        Listitem(
          type: '$type',
          price: '$price',
          time: '$current_data',
          location: '$location',
          imagesee: '$image',
          current_user: '$current_user',
          email: '$email',
          image: '$image', new_price: '$new_price', count: '$count',
        ),
      ],
    ));
  }
}

class Listitem extends StatelessWidget {
  Listitem({
    required this.type,
    required this.time,
    required this.price,
    required this.location,
    required this.current_user,
    required this.imagesee,
    required this.email,
    required this.image,
    required this.new_price,
    required this.count
  });
  String type, price, location, time, imagesee,
      current_user, email, image,new_price ,count;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ListTile(
         
        title: Text(
          type,
          style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              color: Colors.lightBlue),
          maxLines: 1,
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(new_price.isEmpty) Text(
                  '$price EGY'  ,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                )
                else Row(
                  children: [
                    Text(
                       price ,
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,decoration: TextDecoration.lineThrough
                      ),
                      maxLines: 1,
                    ),
                    Text(
                      '  $new_price EGY' ,
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                    )
                  ],
                ),

              ],
            ),
            Text('$count available' ,
              style: TextStyle(fontSize: 14.0,
                color: Colors.green ,fontFamily: 'normal'
              ),)
          ],
        ),
        trailing: IconButton(
          icon: new Icon(
            Icons.add_shopping_cart,
            size: 35,
          ),
          onPressed: () {
            db.collection(current_user).doc().set({
              'Email': email,
              'image': image,
              'type': type,
              'price': price,
              'location': location,
              'current_data': time,
              'phone': phone_num
            }).onError((e, _) => print("Error writing document: $e"));
            Scaffold.of(context).showSnackBar(SnackBar(
              content: const Text(' Add to Car successfully '),
              duration: const Duration(seconds: 3),
              action: SnackBarAction(
                label: 'Car ?',
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => shop()));
                },
              ),
            ));
          },
        ),
        horizontalTitleGap: 16.0,
        leading: Image.network('$imagesee', height: 10000.0),
      ),
      onTap: (() {
        showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Container(
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            type,
                            style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.lightBlue),
                          ),

                          subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('$count available' ,
                                style: TextStyle(fontSize: 14.0,
                                    color: Colors.green ,fontFamily: 'normal'
                                ),),
                              if(new_price.isEmpty) Text(
                                '$price EGY'  ,
                                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                              )
                              else Row(
                                children: [
                                  Text(
                                    price ,
                                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,decoration: TextDecoration.lineThrough
                                    ),
                                    maxLines: 1,
                                  ),
                                  Text(
                                    '  $new_price EGY' ,
                                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                  )
                                ],
                              ),
                              Text(
                                time,
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                location,
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          horizontalTitleGap: 16.0,
                          trailing: IconButton(
                            icon: new Icon(
                              Icons.share,
                              size: 35,
                            ),
                            onPressed: () {
                            },
                          ),
                          leading: Image.network('$imagesee', height: 10000.0),
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Color(0xFF111328)),
                            onPressed: () {
                              db.collection(current_user).doc().set({
                                'Email': email,
                                'image': image,
                                'type': type,
                                'price': price,
                                'location': location,
                                'current_data': time,
                                'phone': phone_num
                              }).onError((e, _) =>
                                  print("Error writing document: $e"));
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content:
                                    const Text(' Add to Car successfully '),
                                duration: const Duration(seconds: 3),
                                action: SnackBarAction(
                                  label: 'Car ?',
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => shop()));
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
                                      fontSize: 20.0, fontFamily: 'new2'),
                                ),
                                Icon(
                                  Icons.shopping_cart_outlined,
                                )
                              ],
                            )),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Color(0xFF111328)),
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Order now   ',
                                  style: TextStyle(
                                      fontSize: 20.0, fontFamily: 'new2'),
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
                                    primary: Color(0xFF111328)),
                                onPressed: () {},
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '    Messenger    ',
                                      style: TextStyle(
                                          fontSize: 18.0, fontFamily: 'new2'),
                                    ),
                                    Icon(
                                      Icons.message,
                                    )
                                  ],
                                )),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Color(0xFF111328)),
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
                                          fontSize: 18.0, fontFamily: 'new2'),
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
                ),
              );
            });
      }),
    );
  }
}

class suggest extends StatefulWidget {
  const suggest({Key? key}) : super(key: key);

  @override
  State<suggest> createState() => _suggestState();
}

class _suggestState extends State<suggest> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _usersStream =
        FirebaseFirestore.instance.collection('Post').snapshots();
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (int i = 0; i < type_store.length; i++)
                GestureDetector(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage(type_image[i]),
                          minRadius: 30.0,
                        ),
                        Text(
                          type_store[i],
                          style: TextStyle(color: Colors.blue),
                        )
                      ],
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      select = type_store[i];
                    });
                  },
                ),
            ],
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Container(
          alignment: Alignment.topLeft,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Color(0x0FF0A0E21),
          ),
          child: Text(
            '   $select',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
        StreamBuilder<QuerySnapshot>(
          stream: _usersStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading");
            }

            return ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: snapshot.data!.docs
                  .map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    //   print(document.id);
                    if (data['department'].contains(select) ||
                        select == 'All products' ||
                        data['type'].contains(select)) {
                      return item(
                        location: data['location'],
                        type: data['type'],
                        price: data['price'],
                        image: data['image'],
                        duc_id: document.id,
                        email: data['Email'],
                        current_user: '${user?.email}',
                        current_data: '$current_date',
                        phone_num: data['phone'],
                        new_price:  data['new_price'], count: data['count'],
                      );
                    } else {
                      return SizedBox();
                    }
                  })
                  .toList()
                  .cast(),
            );
          },
        ),
      ],
    );
  }
}
