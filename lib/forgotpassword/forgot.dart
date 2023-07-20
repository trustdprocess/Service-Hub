import 'package:email_otp/email_otp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'otp.dart';

class forgot extends StatefulWidget {
  const forgot({super.key});

  @override
  State<forgot> createState() => _forgotState();
}

class _forgotState extends State<forgot> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    EmailOTP myauth = EmailOTP();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.yellow,
        title: Text(
          "Forgot Password ",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: "Enter Your Email Address",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
          ),
          InkWell(
            onTap: ()async {
              
                myauth.setConfig(
                    appEmail: "pankajpandey.p18@gmail.com",
                    appName: "Travel Eze",
                    userEmail: _emailController.text,
                    otpLength: 4,
                    otpType: OTPType.digitsOnly);
                if (await myauth.sendOTP() == true) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("OTP has been sent"),
                  ));
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => verification(
                                myauth: myauth,
                              )));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("OTP send failed"),
                  ));
                }
             
            },
            child: Container(
              height: 50,
              width: 150,
              decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(16)
              ),
              child:  Container(
                alignment: Alignment.center,
                child: Text("Send OTP",style: TextStyle(fontSize: 15),))
              ),
          ),
        ],
      ),
    );
  }
}
