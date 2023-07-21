import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'myInput.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class explore extends StatefulWidget {
  const explore({Key? key}) : super(key: key);

  @override
  State<explore> createState() => _exploreState();
}

class _exploreState extends State<explore> {
  final start = TextEditingController();
  final end = TextEditingController();
  bool isVisible = false;
  List<LatLng> routpoints = [LatLng(52.05884, -1.345583)];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black
        ),
        elevation: 0,
        title: Text('Routing', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700,color: Colors.black),),backgroundColor: Colors.yellow,),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                myInput(controler: start, hint: 'Enter Starting PostCode'),
                SizedBox(height: 15,),
                myInput(controler: end, hint: 'Enter Ending PostCode'),
                SizedBox(height: 15,),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
                    onPressed: () async{
                      List<Location> start_l = await locationFromAddress(start.text);
                      List<Location> end_l = await locationFromAddress(end.text);

                      var v1 = start_l[0].latitude;
                      var v2 = start_l[0].longitude;
                      var v3 = end_l[0].latitude;
                      var v4 = end_l[0].longitude;

                      
                      var url = Uri.parse('http://router.project-osrm.org/route/v1/driving/$v2,$v1;$v4,$v3?steps=true&annotations=true&geometries=geojson&overview=full');
                      var response = await http.get(url);
                      print(response.body);
                      setState(() {                                                     
                        routpoints = [];
                        var ruter = jsonDecode(response.body)['routes'][0]['geometry']['coordinates'];
                        for(int i=0; i< ruter.length; i++){
                          var reep = ruter[i].toString();
                          reep = reep.replaceAll("[","");
                          reep = reep.replaceAll("]","");
                          var lat1 = reep.split(',');
                          var long1 = reep.split(",");
                          routpoints.add(LatLng( double.parse(lat1[1]), double.parse(long1[0])));
                        }
                        isVisible = !isVisible;
                        print(routpoints);
                      });
                    },
                    child: Text('Search',style: TextStyle(color: Colors.black),)),
                SizedBox(height: 10,),
                SizedBox(
                  height: 500,
                  width: 400,
                  child: Visibility(
                    visible: isVisible,
                    child: FlutterMap(options:
                        MapOptions(
                          center: routpoints[0],
                          zoom: 10,
                        ),
                      nonRotatedChildren: [
                        AttributionWidget.defaultWidget(source: 'OpenStreetMap contributors',
                        onSourceTapped: null),
                      ],
                      children: [
                        TileLayer(
                          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.example.app',
                        ),
                        PolylineLayer(
                          polylineCulling: false,
                          polylines: [
                            Polyline(points: routpoints, color: Colors.blue, strokeWidth: 9)
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}