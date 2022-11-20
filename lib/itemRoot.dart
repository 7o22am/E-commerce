import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Push_posts.dart';
import 'package:e_commerce/registration_screen.dart';
import 'package:e_commerce/shop_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

bool buy_it = false;
String select = 'All products';
FirebaseFirestore db = FirebaseFirestore.instance;
List<String> type_store = ['All products',
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
  @override
  final user = FirebaseAuth.instance.currentUser;
  DateTime current_date = DateTime.now();

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        Column(
          children: [
            SizedBox(
              height: 20.0,
            ),

            TextField(
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
            SizedBox(
              height: 17.0,
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
      required this.current_user,
      required this.current_data,
      required this.phone_num});
  final String email,
      type,
      price,
      location,
      image,
      duc_id,
      current_user,
      current_data,
      phone_num;
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      children: [
        SizedBox(
          height: 14.0,
        ),
        Listitem(
          type: '$type',
          price: '$price EGY',
          time: '$current_data',
          location: '$location',
          imagesee: '$image',
          current_user: '$current_user',
          email: '$email',
          image: '$image',
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
  });
  String type, price, location, time, imagesee, current_user, email, image;
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
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$price',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              maxLines: 1,
            ),
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
                              Text(
                                '$price',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
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
                  child: Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Image.asset(
                          type_image[i],
                          height: 100,
                          width: 100,
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
                      tost(select);
                    });
                  },
                ),
            ],
          ),
        ),
        SizedBox(
          height: 15,
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
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              shrinkWrap: true,
              children: snapshot.data!.docs
                  .map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
                //   print(document.id);
                if(select == data['department'] || select == 'All products'){
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

                  );

                }
                else{
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
