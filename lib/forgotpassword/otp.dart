// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:servicehub/forgotpassword/passwordreset.dart';



class verification extends StatefulWidget {
  final EmailOTP myauth;
  const verification({
    Key? key,
    required this.myauth,
  }) : super(key: key);

  @override
  _verificationState createState() => _verificationState();
}

class _verificationState extends State<verification> {
  TextEditingController otpDigit1Controller = TextEditingController();
  TextEditingController otpDigit2Controller = TextEditingController();
  TextEditingController otpDigit3Controller = TextEditingController();
  TextEditingController otpDigit4Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.yellow,
        title: Text("OTP Verification",style: TextStyle(color:Colors.black),),
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  height: 68,
                  width: 64,
                  child: TextFormField(
                    controller: otpDigit1Controller,
                    onChanged: (value) {
                      FocusScope.of(context).nextFocus();
                    },
                    style: Theme.of(context).textTheme.headlineSmall,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  height: 68,
                  width: 64,
                  child: TextFormField(
                    controller: otpDigit2Controller,
                    onChanged: (value) {
                      FocusScope.of(context).nextFocus();
                    },
                    style: Theme.of(context).textTheme.headlineSmall,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  height: 68,
                  width: 64,
                  child: TextFormField(
                    controller: otpDigit3Controller,
                    onChanged: (value) {
                      FocusScope.of(context).nextFocus();
                    },
                    style: Theme.of(context).textTheme.headlineSmall,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  height: 68,
                  width: 64,
                  child: TextFormField(
                    controller: otpDigit4Controller,
                    onChanged: (value) {
                      FocusScope.of(context).nextFocus();
                    },
                    style: Theme.of(context).textTheme.headlineSmall,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
               ElevatedButton(
                
                style: ButtonStyle(
                  backgroundColor:MaterialStateProperty.all(Colors.yellow)
                ),
            onPressed: () async {
            if (await widget.myauth.verifyOTP(otp: otpDigit1Controller.text +
                    otpDigit2Controller.text +
                    otpDigit3Controller.text +
                    otpDigit4Controller.text) == true) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("OTP is verified"),
                ));
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => forpass()));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Invalid OTP"),
                ));
              }
            },
            child: const Text(
              "Verify",
              style: TextStyle(fontSize: 15,color: Colors.black),
            ),
               ),
        ],
      ),
    );
  }
}
