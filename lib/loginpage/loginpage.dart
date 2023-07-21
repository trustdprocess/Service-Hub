import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:servicehub/firstpage/firstpage.dart';
import 'package:servicehub/forgotpassword/forgot.dart';
import 'package:servicehub/homepage/homepage.dart';

import '../signup/signup.dart';

class loginpage extends StatefulWidget {
  const loginpage({Key? key}) : super(key: key);

  @override
  _loginpageState createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;
  bool _isAdmin = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  RegExp _emailRegex = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
  RegExp _passwordRegex = RegExp(r'^[a-zA-Z0-9_@.\-]{3,20}$');

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signInWithEmailPassword() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.toString(),
        password: _passwordController.text.toString(),
      );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_emailController.text)
          .set({
        'email': _emailController.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login Successful!")),
      );
      Navigator.push(context, MaterialPageRoute(builder: (_) => homepage()));

      // Navigate to the home screen
      // Replace `HomeAnimation` with your desired home screen
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login Failed: Email and Password Incorrect")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
        
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          title: const Text(
            "Service Hub",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.yellow,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a valid email';
                    } else if (!_emailRegex.hasMatch(value)) {
                      return 'Enter a valid email address';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    hintText: "someone@gmail.com",
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
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    } else if (!_passwordRegex.hasMatch(value)) {
                      return 'Enter a valid password';
                    }
                    return null;
                  },
                  obscureText: _isObscure,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.password),
                    hintText: "Password",
                    labelText: "Password",
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                      icon: _isObscure
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility),
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => forgot()));
                        },
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(color: Colors.black),
                        ))),
              ),
              InkWell(
                onTap: _signInWithEmailPassword,
                child: AnimatedContainer(
                  duration: Duration(seconds: 2),
                  child: Container(
                    height: 50,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Text(
                        "Login",
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
              SizedBox(height: 5),
              SizedBox(height: 0),
              SizedBox(width: 10),
            ],
          ),
        ),
      ),
    );
  }
}
