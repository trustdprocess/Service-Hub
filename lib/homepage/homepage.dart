import 'package:flutter/material.dart';
import 'package:servicehub/map/leaflet.dart';
import 'package:servicehub/profile/profile.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  late String greeting;
  int _currentindex = 0;

  @override
  void initState() {
    super.initState();
    final currentTime = DateTime.now();
    final currentHour = currentTime.hour;

    if (currentHour < 12) {
      greeting = 'Good morning';
    } else if (currentHour < 17) {
      greeting = 'Good afternoon';
    } else {
      greeting = 'Good evening';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentindex,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => profile()),
                );
              },
              child: Icon(Icons.explore),
            ),
            label: "Explore",
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => explore()),
                );
              },
              child: Icon(Icons.face),
            ),
            label: "Profile",
          ),
        ],
        onTap: (value) {
          setState(() {
            _currentindex = value;
          });
        },
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(
          "Service Hub",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.yellow,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Container(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 4.0, bottom: 2.0),
                child: Text(
                  "Hello",
                  style: TextStyle(
                      fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 2.0, bottom: 16.0),
                child: Text(
                  "$greeting!",
                  style: TextStyle(
                      fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 40),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 10,
              runSpacing: 10,
              children: List.generate(6, (index) {
                return Container(
                  width: MediaQuery.of(context).size.width * 0.4, // Adjust the width as needed
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/electrician.jpg"),
                      SizedBox(height: 10),
                      Text(
                        "Electrician",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
