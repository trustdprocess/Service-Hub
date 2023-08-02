import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class userForm extends StatefulWidget {
  const userForm({super.key});

  @override
  State<userForm> createState() => _userFormState();
}

class _userFormState extends State<userForm> {
  final formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController contactNo = TextEditingController();
  Future<void> sendToFirestore() async {
    if (formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Processing Data")));
    }
    try {
      await FirebaseFirestore.instance
          .collection("UserInfo")
          .doc(name.text)
          .set({
        "Name": name.text,
        "Last Name": lastName.text,
        "Email": _emailController.text,
        "Contact no": contactNo.text,
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Technician Sucessfully Booked")));
    } catch (e) {
      print("Erroe:$e");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Technician Booking Rejected")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text(" Booking Confirmation Form "),
          elevation: 0,
        ),
        body: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: name,
                decoration: InputDecoration(
                  hintText: "First Name",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "You Cannot Leave This Field Empty ";
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: lastName,
                decoration: InputDecoration(
                  hintText: "Last Name",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "You Cannot Leave This Field Empty ";
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: "E-mail",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "You Cannot Leave This Field Empty ";
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: contactNo,
                decoration: InputDecoration(
                  hintText: "Contact Number",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "You Cannot Leave This Field Empty ";
                  }
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              child: Container(
                height: 50,
                width: 150,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(16)),
                child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Confirm Booking",
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    )),
              ),
              onTap: sendToFirestore,
            )
          ],
        ),
      ),
    );
  }
}
// Pankaj



