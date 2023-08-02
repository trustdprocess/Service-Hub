import 'package:flutter/material.dart';
class homepages extends StatefulWidget {
  const homepages({super.key});

  @override
  State<homepages> createState() => _homepagesState();
}

class _homepagesState extends State<homepages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
    Row(
      children: [
          Image.asset("assets/barber.png"),
      ],
    )


        ],
      ),
    );
  }
}