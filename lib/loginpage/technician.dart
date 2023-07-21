import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:path/path.dart' as path;
import 'package:servicehub/firstpage/firstpage.dart';

class techlogin extends StatefulWidget {
  const techlogin({Key? key}) : super(key: key);

  @override
  State<techlogin> createState() => _techloginState();
}

class _techloginState extends State<techlogin> {
  final formKey = GlobalKey<FormState>();
  bool _isObscure = true;
   String? errorMessage;
 String? _selectedOccupation;
  List<File?> _images = List.generate(1, (_) => null);
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactNoController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  Future getImage(int index) async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return null;
    final imageTemporary = File(image.path);
    setState(() {
      _images[index] = imageTemporary;
    });
  }

  void navigateToTripsPage() async {
    if (formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Processing Data!")),
      );

      try {
        // Upload images to Firebase Storage
        List<String> imageUrls = await uploadImagesToFirebaseStorage();

        // Check if _expertiseController has a valid value before proceeding

        // Create a new document in the "Technician" collection with the expertise as the document ID
        await FirebaseFirestore.instance
            .collection(_selectedOccupation.toString())
            .doc(_nameController.text)
            .set({
          "Name": _nameController.text,
          "email": _emailController.text,
          "address": _addressController.text,
          "contactNo": _contactNoController.text,
          "Description": _descController.text.trim(),
          "images": imageUrls,
          "price": _priceController.text,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Technician Added Successfully!")),
        );

        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        Navigator.push(context, MaterialPageRoute(builder: (_) => firstpage()));
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
  }

  Future<List<String>> uploadImagesToFirebaseStorage() async {
    List<String> imageUrls = [];

    try {
      for (File? image in _images) {
        if (image != null) {
          String fileName = DateTime.now().millisecondsSinceEpoch.toString() +
              path.basename(image.path);

          Reference ref =
              FirebaseStorage.instance.ref().child("images/$fileName");
          UploadTask uploadTask = ref.putFile(image);
          TaskSnapshot taskSnapshot = await uploadTask;

          String imageUrl = await taskSnapshot.ref.getDownloadURL();

          imageUrls.add(imageUrl);
        }
      }
    } catch (e) {
      print("Error uploading images: $e");
      rethrow;
    }

    return imageUrls;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellow,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            "Register Technicians",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 40,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (int i = 0; i < _images.length; i++)
                      GestureDetector(
                        onTap: () => getImage(i),
                        child: Container(
                          width: 250,
                          height: 250,
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                          child: _images[i] != null
                              ? Image.file(
                                  _images[i]!,
                                  height: 300,
                                  width: 300,
                                  fit: BoxFit.fill,
                                )
                              : Image.network(
                                  "https://t4.ftcdn.net/jpg/04/99/93/31/360_F_499933117_ZAUBfv3P1HEOsZDrnkbNCt4jc3AodArl.jpg",
                                  height: 250,
                                  width: 250,
                                ),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Center(
                child: CustomButton(
                  title: "Pick From Gallery",
                  icon: Icons.photo,
                  onClick: () => getImage(0),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: _nameController,
                title: "Name",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "You Cannot Leave This Field Empty";
                  }
                  return null;
                },
              ),
              CustomTextField(
                controller: _emailController,
                title: "E-mail",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "You Cannot Leave This Field Empty";
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  obscureText: _isObscure,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: "Password",
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
                  ),
                ),
              ),
              CustomTextField(
                controller: _contactNoController,
                title: "Contact No",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "You Cannot Leave This Field Empty";
                  }
                  return null;
                },
              ),
              CustomTextField(
                controller: _addressController,
                title: "Location(District/City/Street-no)",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "You Cannot Leave This Field Empty";
                  }
                  return null;
                },
              ),
              CustomTextField(
                controller: _priceController,
                title: "Pricing/Hr",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "You Cannot Leave This Field Empty";
                  }
                  return null;
                },
              ),
              CustomTextField(
                controller: _descController,
                title: "Description About Yourself",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "You Cannot Leave This Field Empty";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              RadioListTile<String>(
            title: Text("Electrician"),
            value: "electrician",
            groupValue: _selectedOccupation,
            onChanged: (String? value) {
              setState(() {
                _selectedOccupation = value;
              });
            },
          ),
          RadioListTile<String>(
            title: Text("Plumber"),
            value: "plumber",
            groupValue: _selectedOccupation,
            onChanged: (String? value) {
              setState(() {
                _selectedOccupation = value;
              });
            },
          ),
          RadioListTile<String>(
            title: Text("Carpenter"),
            value: "carpenter",
            groupValue: _selectedOccupation,
            onChanged: (String? value) {
              setState(() {
                _selectedOccupation = value;
              });
            },
          ),
          RadioListTile<String>(
            title: Text("Barber"),
            value: "barber",
            groupValue: _selectedOccupation,
            onChanged: (String? value) {
              setState(() {
                _selectedOccupation = value;
              });
            },
          ),
          RadioListTile<String>(
            title: Text("Painter"),
            value: "painter",
            groupValue: _selectedOccupation,
            onChanged: (String? value) {
              setState(() {
                _selectedOccupation = value;
              });
            },
          ),
          RadioListTile<String>(
            title: Text("Cleaning"),
            value: "cleaning",
            groupValue: _selectedOccupation,
            onChanged: (String? value) {
              setState(() {
                _selectedOccupation = value;
              });
            },
          ),
            
              InkWell(
                onTap: navigateToTripsPage,
                child: Container(
                  height: 50,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      "Register",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ),
                ),
              ),
             
            ],
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onClick;

  const CustomButton({
    required this.title,
    required this.icon,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.black,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        onPressed: onClick,
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String title;
  final String? Function(String?)? validator;
  final TextEditingController controller;

  const CustomTextField({
    required this.title,
    required this.validator,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        decoration: InputDecoration(hintText: title),
        validator: validator,
        controller: controller,
      ),
    );
  }
}
