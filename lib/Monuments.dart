
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_in_flutter/src/monuments.dart';
import 'overview.dart';
import 'src/mp.dart' as locations;
import 'src/mp.dart';

import 'dart:math' as math;

void main() {
  runApp(const monumentsLocation());
}
List<mp> result = locations.fetchMonumentsP() as List<mp>;
class monumentsLocation extends StatefulWidget {
  const monumentsLocation({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}


class _MyAppState extends State<monumentsLocation> {
  double range=3000;
  late GoogleMapController googleMapController;
  late TextEditingController textEditingController;
  @override
  void initState(){
    super.initState();
    textEditingController = TextEditingController();

  }

  @override
  void dispose(){
    textEditingController.dispose();
    super.dispose();
  }
  final Map<String, Marker> _markers = {};
  final Map<String, Circle> _circles = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {
    googleMapController = controller;
    result = await locations.fetchMonumentsP();
    setState(() {
      _markers.clear();
      for (final monument in result) {

        final marker = Marker(
          markerId: MarkerId(monument.id.toString()),
          position: LatLng(monument.latitude!,monument.longitude!),
          infoWindow: InfoWindow(
            title: monument.nom!,
            snippet: monument.zone?.nom,
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Overview(items: [monument],)),
              );
            }
          ),

        );
        _markers[monument.nom!] = marker;

      }
    });
  }

  double getZoomLevel(double radius) {
    double zoomLevel = 11;
    if (radius > 0) {
      double radiusElevated = radius + radius / 2;
      double scale = radiusElevated / 500;
      zoomLevel = 16 - math.log(scale) / math.log(2);
    }
    zoomLevel = num.parse(zoomLevel.toStringAsFixed(2)) as double;
    return zoomLevel;
  }
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
        body:
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(2.10),

              child: Column(
                children: [

                  AnimSearchBar(
                    width: 500,
                    textController: textController,
                    onSuffixTap: () {
                      setState(() {
                        textController.clear();
                      });
                    }, onSubmitted: (String s) async {
                      print(s);
                      final http.Response response = await http.post(Uri.parse('http://127.0.0.1:8080/MonumentProjetWS/Monument/searchM'),
                        headers: <String, String>{
                          'Content-Type': 'application/json; charset=UTF-8',
                        },
                        body: jsonEncode(<String, String>{
                          'zone': s,
                          'ville':s,
                          'nom':s
                        }),
                      );

                      if (response.statusCode == 200) {
                        print(response.body);
                        result = jsonDecode(response.body).map<mp>((roomJson)
                        => mp.fromJson(roomJson)).toList();
                        setState(() {
                          _markers.clear();
                          for (final monument in result) {

                            final marker = Marker(
                              markerId: MarkerId(monument.id.toString()),
                              position: LatLng(monument.latitude!,monument.longitude!),
                              infoWindow: InfoWindow(
                                title: monument.nom!,
                                snippet: monument.zone?.nom,
                                  onTap: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Overview(items: [monument],)),
                                    );
                                  }

                              ),
                            );
                            _markers[monument.nom!] = marker;
                          }
                        });

                      } else {
                        throw Exception('Failed to create album.');
                      }

                  },
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5.0),
              width: double.infinity,
              height: 600,
              child:
              GoogleMap(

                onLongPress:(LatLng) async{
                  final trange = await openDialog();

                  setState(() {
                    this.range = num.parse(trange as String).toDouble();
                    print("RaNge "+this.range.toString());
                  });
                },
                onMapCreated: _onMapCreated,
                initialCameraPosition: const CameraPosition(
                  target: LatLng(0, 0),
                  zoom: 2,
                ),
                markers: _markers.values.toSet(),
                circles: _circles.values.toSet(),

              ),


            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed:() async {
            Position position = await getPostion();
            googleMapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target:LatLng(position.latitude, position.longitude),zoom: getZoomLevel(this.range))));
            final marker = Marker(
              markerId: MarkerId("cPos"),
              position: LatLng(position.latitude, position.longitude),
              infoWindow: InfoWindow(
                title: "You Are Here",
              ),
            );


            final circle = Circle(
              circleId: CircleId("area"),
              center: LatLng(position.latitude,position.longitude),
              radius: this.range,
              strokeColor: Color.fromRGBO(24,233, 111, 0.6),
              strokeWidth: 1,
              fillColor: Color.fromRGBO(24,233, 111, 0.2),
            );

            setState(() {
              _markers["cPos"]=marker;
              _circles["area"]=circle;
            });

          },
          backgroundColor: Colors.green[700], label: Text("Nearby"),icon: Icon(Icons.location_history),
        ),
        floatingActionButtonLocation:    FloatingActionButtonLocation.startFloat,
      ),
    );
  }


  Future<Position> getPostion() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await  Geolocator.isLocationServiceEnabled();

    if(!serviceEnabled){
      return Future.error("Locations services are disabled");
    }

    permission = await Geolocator.checkPermission();

    if(permission==LocationPermission.denied){
      permission = await Geolocator.requestPermission();

      if(permission==LocationPermission.denied){
        return Future.error("Locations permission denied");
      }
    }

    if(permission == LocationPermission.deniedForever){
      return Future.error("Locations permission are permanently denied");
    }

    Position position = await Geolocator.getCurrentPosition();

    return position;
  }

  Future<String?> openDialog() => showDialog<String>(
    context: context,
    builder: (context)=>AlertDialog(
      title: Text("Edit Raduis"),
      content: TextField(
        keyboardType: TextInputType.number,
        autofocus: true,
        decoration: InputDecoration(hintText: "Raduis"),
        controller: textEditingController,
      ),
      actions: [
        TextButton(onPressed: ()async{
          Navigator.of(context).pop(textEditingController.text);
        }, child: Text("Ok"))
      ],
    ),

  );

}