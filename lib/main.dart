import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:servicehub/firstpage/firstpage.dart';
import 'package:servicehub/homepage/barber.dart';
import 'package:servicehub/homepage/carpenter.dart';
import 'package:servicehub/homepage/cleaner.dart';
import 'package:servicehub/homepage/electrician.dart';
import 'package:servicehub/homepage/homepages.dart';
import 'package:servicehub/homepage/painter.dart';
import 'package:servicehub/homepage/plumber.dart';
import 'package:servicehub/messaging_system/messaginghome.dart';

import 'errorpage/errorpage.dart';
import 'googleauthentication/google.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Initialize Firestore
  FirebaseFirestore.instance.settings = Settings(
      persistenceEnabled: true, cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthService().AuthState(),
        // home: messhome(),
       
        initialRoute: '/',
        onGenerateRoute: (RouteSettings settings) {
          // Handle navigation based on the requested route
          switch (settings.name) {
            case '/':
              return MaterialPageRoute(builder: (_) => homepages());
            case '/cleaner':
              return MaterialPageRoute(builder: (_) => cleaner());
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

            // Add more routes here...
            default:
              // If the requested route is not found, you can navigate to a default page or show an error page.
              return MaterialPageRoute(builder: (_) => ErrorPage());
          }
        });
  }
}
