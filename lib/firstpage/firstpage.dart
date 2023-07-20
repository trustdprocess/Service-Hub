import 'package:flutter/material.dart';
import 'package:servicehub/googleauthentication/google.dart';
import 'package:servicehub/loginpage/loginpage.dart';
import 'package:servicehub/signup/signup.dart';

class firstpage extends StatefulWidget {
  const firstpage({super.key});

  @override
  State<firstpage> createState() => _firstpageState();
}

class _firstpageState extends State<firstpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Text(
            "ServiceHub",
            style: TextStyle(fontSize: 40, color: Colors.black),
          )),
          SizedBox(
            height: 50,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => loginpage()));
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Image.asset(
                        "assets/email.jpg",
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Login With e-mail & Password",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ],
                  )),
            ),
          ),
          InkWell(
            onTap: () {
                      AuthService().signInWithGoogle();
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Image.asset(
                        "assets/google.webp",
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Login With Google",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ],
                  )),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => signup()));
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Image.asset(
                        "assets/person.png",
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Don't Have An Account?",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ],
                  )),
            ),
          ),
         
        ],
      ),
    );
  }
}
