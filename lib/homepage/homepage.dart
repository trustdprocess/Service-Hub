import 'package:flutter/material.dart';
import 'package:servicehub/homepage/cleaner.dart';
import 'package:servicehub/homepage/painter.dart';
import 'package:servicehub/homepage/plumber.dart';
import 'package:servicehub/map/leaflet.dart';
import 'package:servicehub/profile/profile.dart';

import '../errorpage/errorpage.dart';
import 'barber.dart';
import 'carpenter.dart';
import 'electrician.dart';

class ServiceItem {
  final String title;
  final String imageAsset;
  final String route; // Add route to navigate to

  ServiceItem(this.title, this.imageAsset, this.route);
}

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

  final List<ServiceItem> services = [
    ServiceItem("Electrician", "assets/electrician.jpg", '/electricity'), // Navigate to '/electricity' route
    ServiceItem("Plumber", "assets/plumber.png", '/plumber'), // Navigate to '/plumber' route
    ServiceItem("Carpenter", "assets/carpenter.jpg.avif", '/carpenter'), // Navigate to '/carpenter' route
    ServiceItem("Barber", "images/barber.jpg", '/barber'), // Navigate to '/barber' route
    ServiceItem("Painter", "images/paint.jpg.avif", '/painter'), // Navigate to '/painter' route
    ServiceItem("Cleaner", "images/cleaner.jpg", '/cleaner'), // Navigate to '/cleaner' route
    // Add more services here...
  ];

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
                padding:
                    const EdgeInsets.only(left: 16.0, top: 4.0, bottom: 2.0),
                child: Text(
                  "Hello" + ",",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, top: 2.0, bottom: 16.0),
                child: Text(
                  "$greeting!",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                alignment: Alignment.bottomLeft,
                child: Text("How Can We Help You?",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
            ),
            SizedBox(height: 40),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 10,
              runSpacing: 10,
              children: services.map((service) {
                return InkWell(
                  onTap: () {
                    // Navigate to the specified route when tapped
                    Navigator.pushNamed(context, service.route);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(service.imageAsset),
                        SizedBox(height: 10),
                        Text(
                          service.title,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Service Hub',
    initialRoute: '/',
    onGenerateRoute: (RouteSettings settings) {
      switch (settings.name) {
        case '/':
          return MaterialPageRoute(builder: (_) => homepage());
        case '/electricity':
          return MaterialPageRoute(builder: (_) => ElectricityPage());
        case '/plumber':
          return MaterialPageRoute(builder: (_) => PlumberPage());
        case '/carpenter':
          return MaterialPageRoute(builder: (_) => CarpenterPage());
        case '/barber':
          return MaterialPageRoute(builder: (_) => BarberPage());
        case '/painter':
          return MaterialPageRoute(builder: (_) => PainterPage());
        case '/cleaner':
          return MaterialPageRoute(builder: (_) => cleaner());
        // Add more routes here...
        default:
          // If the requested route is not found, you can navigate to a default page or show an error page.
          return MaterialPageRoute(builder: (_) => ErrorPage());
      }
    },
    onUnknownRoute: (RouteSettings settings) {
      // Handle unknown routes here. You can navigate to an error page or any fallback page.
      return MaterialPageRoute(builder: (_) => ErrorPage());
    },
  ));
}


