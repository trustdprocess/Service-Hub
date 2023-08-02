import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../detailpage/electriciandetail.dart';
class ElectricityPage extends StatefulWidget {
  const ElectricityPage({super.key});

  @override
  State<ElectricityPage> createState() => _ElectricityPageState();
}

class _ElectricityPageState extends State<ElectricityPage> {
    late Stream _electricianStream;
     @override
  void initState() {
    super.initState();
    _electricianStream = FirebaseFirestore.instance.collection('electrician').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black
        ),
        title: Text('Registered Electricians',style: TextStyle(color: Colors.black),),
        
        elevation: 0,
        backgroundColor: Colors.yellow,
      ),
      body: StreamBuilder(
        stream: _electricianStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
             //list of the electricians
          final electricians = snapshot.data!.docs;

          return ListView.builder(
            itemCount: electricians.length,
            itemBuilder: (context, index) {
              //list get 
              final electrician = electricians[index].data() as Map<String, dynamic>;

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => detailPage(electrician: electrician),
                    ),
                  );
                },
                child: Card(
                  margin: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        width: 200,
                        height: 200,
                        child: Image.network(
                          electrician['images'][0],
                          fit: BoxFit.fill,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Name: ${electrician['electricianName']}',
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(height: 10),
                              Text(
                                ' Location: ${electrician['location']}',
                                style: TextStyle(fontSize: 15),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Price: Nrs ${electrician['price']}/Hour',
                                style: TextStyle(fontSize: 15),
                              ),
                              SizedBox(height: 10),
                              Text('Contact No: ${electrician['contactNo']}'),
                              SizedBox(height: 10),
                              Container(
                                alignment: Alignment.bottomRight,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => detailPage(electrician: electrician),
                                      ),
                                    );
                                  },
                                  child: Text("See More ",style: TextStyle(color: Colors.blue),),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}