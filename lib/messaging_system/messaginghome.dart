import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class messhome extends StatefulWidget {
  const messhome({super.key});

  @override
  State<messhome> createState() => _messhomeState();
}

class _messhomeState extends State<messhome> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mess"),
      ),
    );
  }
}
