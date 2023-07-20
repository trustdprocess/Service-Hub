import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:servicehub/loginpage/loginpage.dart';



class signup extends StatefulWidget {
  const signup({Key? key}) : super(key: key);

  @override
  _signupState createState() => _signupState();
}

class _signupState extends State<signup> {
  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;
  bool _isObscure1 = true;

  RegExp usernameRegex = RegExp(r'^[a-zA-Z0-9_]{3,20}$');
  RegExp emailRegex = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
  RegExp passwordRegex = RegExp(r'^[a-zA-Z0-9_@]{3,20}$');
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();

  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          title: const Text("Service Hub",style: TextStyle(color: Colors.black),),
          backgroundColor: Colors.yellow,
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: controller3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid username';
                  } else if (!usernameRegex.hasMatch(value)) {
                    return "Enter a username containing alphanumeric values";
                  } else if (value.length <= 4) {
                    return "Enter a username with a length of more than 4";
                  }
                  return null;
                },
                obscureText: false,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person),
                  hintText: "Username",
                  labelText: "Username",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 0,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: controller1,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid email';
                  } else if (!emailRegex.hasMatch(value)) {
                    return "Enter a valid email";
                  }
                  return null;
                },
                obscureText: false,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email),
                  hintText: "Someone@example.com",
                  labelText: "E-mail",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: controller2,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password that contains uppercase, lowercase, and digit';
                  } else if (value.length <= 4) {
                    return "Enter a password of more than 4 characters";
                  }
                  return null;
                },
                obscureText: _isObscure,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.password),
                  hintText: "Password",
                  labelText: "Password",
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                    icon: _isObscure
                        ? const Icon(Icons.visibility_off)
                        : const Icon(Icons.visibility),
                    color: Colors.black,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: controller4,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password that contains uppercase, lowercase, and digit';
                  } else if (value.length <= 4) {
                    return "Enter a password of more than 4 characters";
                  } else if (controller2.text != controller4.text) {
                    return "Passwords do not match";
                  }
                  return null;
                },
                obscureText: _isObscure1,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.password),
                  hintText: "Confirm Password",
                  labelText: "Confirm Password",
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isObscure1 = !_isObscure1;
                      });
                    },
                    icon: _isObscure1
                        ? const Icon(Icons.visibility_off)
                        : const Icon(Icons.visibility),
                    color: Colors.black,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
             // Error message area
            if (errorMessage != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  errorMessage!,
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            InkWell(
              onTap: () async {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Processing Data!")),
                  );
                  try {
                    if (!emailRegex.hasMatch(controller1.text)) {
                      throw 'Please enter a valid email address';
                    }

                    await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                      email: controller1.text.toString(),
                      password: controller2.text.toString(),
                    );

                    // Save the username in Firestore or Firebase Realtime Database
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(controller3.text.toString())
                        .set({'username': controller3.text.toString()});

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => loginpage()),
                    );
                  } catch (error) {
                    print('Error on signing up: $error');
                    String errorMessage = 'Error on Signing Up';

                    if (error is FirebaseAuthException) {
                      if (error.code == 'email-already-in-use') {
                        errorMessage =
                            'The email address is already in use. Please try a different email.';
                      } else if (error.code == 'weak-password') {
                        errorMessage =
                            'The password provided is too weak. Please choose a stronger password.';
                      } else if (error.code == 'username-already-in-use') {
                        errorMessage =
                            'The username is already taken. Please choose a different username.';
                      }
                    }

                    setState(() {
                      this.errorMessage = errorMessage;
                    });
                  }
                }
              },
              child: AnimatedContainer(
                duration: const Duration(seconds: 2),
                child: Container(
                  height: 50,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      "Signup",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),

           
          ],
        ),
      ),
    );
  }
}