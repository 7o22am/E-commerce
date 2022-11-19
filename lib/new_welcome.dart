import 'package:e_commerce/registration_scrren.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

class welcome_page extends StatefulWidget {
  const welcome_page({Key? key}) : super(key: key);

  @override
  State<welcome_page> createState() => _welcome_pageState();
}

class _welcome_pageState extends State<welcome_page> {
  //viewport as margin left
  final _pageController = PageController();
  double currentPage = 0;

  //indicator handler
  @override
  void initState() {
    //page controller is always listening
    //every pageview is scrolled sideways it will take the index page
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page!.toDouble();
        print(currentPage);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Image.asset('image/ez.gif'),
              ),
              Padding(
                padding: const EdgeInsets.all(18),
                child: Text(
                  '  Welcome ! ',
                  style: TextStyle(
                      fontSize: 40.0,
                      fontFamily: 'new2',
                      fontWeight: FontWeight.w900,
                      color: Colors.lightBlueAccent),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 220,
                  child: PageView(
                    physics: BouncingScrollPhysics(),
                    controller: _pageController,
                    scrollDirection: Axis.horizontal,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Your World Of Shopping Awaits We’r'
                          'e so glad you’re here!  You are now part of a'
                          ' growing community of E commerce '
                          'creating, collaborating, '
                          'and connecting across the globe via E-commerce .\n'
                          'Whether you’ve joined to create business'
                          ' or just to connect with us , we’ve got something '
                          'for you.\nLet’s go ! ',
                          style: TextStyle(fontSize: 15, fontFamily: 'new2'),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Hi there !  My name is Hossam  and I am ver'
                          'y happy '
                          'to welcome you !\nYou jo'
                          'ined . who '
                          'are already skyrocketing their sales with'
                          ' E-commerce by:'
                          'shopping , buying and sell There’s '
                          'just one more tiny step you need to take'
                          ' to achieve all these amazing things:',
                          style: TextStyle(fontSize: 15.0, fontFamily: 'new2'),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Hi there !  👋   \nWant a free sample of our products ?'
                          ' \nYes, please ! No, thanks.',
                          style: TextStyle(fontSize: 20.0, fontFamily: 'new2'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(25),
                alignment: Alignment.center,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Material(
                        color: Colors.lightBlueAccent,
                        borderRadius: BorderRadius.circular(30.0),
                        elevation: 5.0,
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => registration()));
                          },
                          minWidth: 50.0,
                          height: 30.0,
                          child: Text(
                            ' sign up ',
                            style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: 'new2',
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 50.0,
                    ),
                    Wrap(
                      children: List.generate(
                        3,
                        (index) {
                          return Container(
                            margin: EdgeInsets.only(right: 8),
                            alignment: Alignment.center,
                            height: 9,
                            width: 9,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: currentPage == index
                                  ? Colors.black
                                  : Colors.black12,
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      width: 25.0,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Material(
                        elevation: 5.0,
                        color: Colors.lightBlueAccent,
                        borderRadius: BorderRadius.circular(30.0),
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => login()));
                          },
                          minWidth: 50.0,
                          height: 30.0,
                          child: Text(
                            '  log in ',
                            style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: 'new2',
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
