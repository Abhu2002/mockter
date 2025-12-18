import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  double h = 80.0;
  double Width = 200.0;
  int count = 0;
  int count1 = 0;
  IconData icon = Icons.light_mode;
  Color cs = Colors.white60;
  Color ns = Colors.black87;
  Color Bcolor = Colors.yellowAccent;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Container(
        height: 1000,
        color: cs,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 35.0, left: 8, right: 8),
              child: Container(
                height: 200,
                width: 500,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  gradient: LinearGradient(
                      colors: [Colors.redAccent, Colors.yellowAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: IconButton(
                              icon: Icon(Icons.arrow_back),
                              iconSize: 30,
                              color: Colors.white,
                              onPressed: () {},
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 320,
                        ),
                        Container(
                          child: Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              icon: Icon(icon),
                              iconSize: 30,
                              color: Colors.white,
                              onPressed: () {
                                changeTheme();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      child: Text(
                        'Welcome Darshil Patel',
                        style: TextStyle(
                          color: Colors.purpleAccent,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 130,
              left: 140,
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://avatars.githubusercontent.com/u/10570920?v=4'),
                backgroundColor: Colors.purpleAccent,
                radius: 80,
              ),
            ),
            Positioned(
                top: 278,
                left: 27,
                child: Text(
                  'Name :',
                  style: TextStyle(
                    color: ns,
                    fontSize: 23,
                    fontWeight: FontWeight.w300,
                  ),
                )),
            Positioned(
              top: 300,
              left: 15,
              child: AnimatedContainer(
                height: h,
                width: Width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  gradient: LinearGradient(
                      colors: [Colors.purpleAccent, Colors.deepPurpleAccent]),
                ),
                duration: Duration(milliseconds: 1000),
                curve: Curves.elasticInOut,
                child: GestureDetector(
                  onTap: changesize,
                  child: Center(
                    child: Text(
                      'Darshil Patel',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        color: Colors.yellowAccent,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
                top: 278,
                right: 25,
                child: Text(
                  ': Recent Test Scores',
                  style: TextStyle(
                    color: ns,
                    fontSize: 21,
                    fontWeight: FontWeight.w300,
                  ),
                )),
            Positioned(
              top: 300,
              right: 15,
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  gradient: LinearGradient(
                      colors: [Colors.purpleAccent, Colors.deepPurpleAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 22, bottom: 10),
                    child: Text(
                      'Data Structures : 86/100 \n\n'
                      'Theory of Computation : 76/100\n\n'
                      'Digital Logic : 80/100',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w500,
                        color: Colors.yellowAccent,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
                top: 387,
                left: 25,
                child: Text(
                  'Contact No :',
                  style: TextStyle(
                    color: ns,
                    fontSize: 23,
                    fontWeight: FontWeight.w300,
                  ),
                )),
            Positioned(
              top: 410,
              left: 15,
              child: Container(
                height: 80,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  gradient: LinearGradient(
                      colors: [Colors.purpleAccent, Colors.deepPurpleAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
                ),
                child: Center(
                  child: Text(
                    '9999955555',
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w500,
                      color: Colors.yellowAccent,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
                top: 507,
                left: 30,
                child: Text(
                  'Email Address :',
                  style: TextStyle(
                    color: ns,
                    fontSize: 23,
                    fontWeight: FontWeight.w300,
                  ),
                )),
            Positioned(
              top: 530,
              left: 20,
              child: Container(
                height: 80,
                width: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  gradient: LinearGradient(
                      colors: [Colors.purpleAccent, Colors.deepPurpleAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
                ),
                child: Center(
                  child: Text(
                    'darshil.patel_19@sakec.ac.in',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: Colors.yellowAccent,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
                top: 625,
                left: 30,
                child: Text(
                  'Profression : ',
                  style: TextStyle(
                    color: ns,
                    fontSize: 23,
                    fontWeight: FontWeight.w300,
                  ),
                )),
            Positioned(
              top: 647,
              left: 15,
              child: Container(
                height: 75,
                width: 220,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  gradient: LinearGradient(
                      colors: [Colors.purpleAccent, Colors.deepPurpleAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
                ),
                child: Center(
                  child: Text(
                    'Student',
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w500,
                      color: Colors.yellowAccent,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
                top: 625,
                right: 30,
                child: Text(
                  ': Gender ',
                  style: TextStyle(
                    color: ns,
                    fontSize: 23,
                    fontWeight: FontWeight.w300,
                  ),
                )),
            Positioned(
              top: 647,
              right: 15,
              child: Container(
                height: 75,
                width: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  gradient: LinearGradient(
                      colors: [Colors.purpleAccent, Colors.deepPurpleAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
                ),
                child: Center(
                  child: Text(
                    'Male',
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w500,
                      color: Colors.yellowAccent,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
                top: 741,
                left: 32,
                child: Text(
                  'University & College :',
                  style: TextStyle(
                    color: ns,
                    fontSize: 23,
                    fontWeight: FontWeight.w300,
                  ),
                )),
            Positioned(
              top: 764,
              right: 15,
              child: Container(
                height: 80,
                width: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  gradient: LinearGradient(
                      colors: [Colors.purpleAccent, Colors.deepPurpleAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
                ),
                child: Center(
                  child: Text(
                    'Mumbai University / Shah and anchor College',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w500,
                      color: Colors.yellowAccent,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
                top: 870,
                right: 135,
                child: SizedBox(
                  height: 50,
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('Logout'),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      )),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.deepOrange),
                    ),
                  ),
                ))
          ],
        ),
      )),
    );
  }

  void changeTheme() {
    setState(() {
      if (count == 0) {
        icon = Icons.dark_mode;
        cs = Colors.black87;
        ns = Colors.white;
        count = 1;
      } else {
        icon = Icons.light_mode;
        cs = Colors.white60;
        count = 0;
      }
    });
  }

  void changesize() {
    setState(() {
      if (count == 0) {
        h = 90;
        Width = 205;
        count = 1;
      } else {
        h = 80;
        Width = 200;
        count = 0;
      }
    });
  }
}
