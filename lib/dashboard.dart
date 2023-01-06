import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_in_flutter/src/monuments.dart';
import 'package:intl/intl.dart';

import 'package:google_maps_in_flutter/src/mp.dart';
import 'overview.dart';
import 'src/mp.dart' as locations;

Future<List<mp>> result = locations.fetchMonumentsP();

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState(){
    super.initState();
    result = locations.fetchMonumentsP();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: unnecessary_new
      body: FutureBuilder<List<mp>>(
        future: result,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);

            return GridView.builder(
              padding: EdgeInsets.all(20),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 150,
                  height: 500,
                  decoration: BoxDecoration(
                    color: Color(0xfff4f4f4),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(3.0, 5.0),
                        blurRadius: 10.0,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // ignore: prefer_const_constructors
                      Text(
                        ('${snapshot.data![index].nom}').toUpperCase(),
                        textAlign: TextAlign.center,

                        // ignore: prefer_const_constructors
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),

                      Image.asset("${snapshot.data![index].url}",width: double.infinity, height: 100),
                      Text(
                        '${snapshot.data![index].zone!.ville!.nom}'+' '+'${snapshot.data![index].zone!.nom}',
                        textAlign: TextAlign.center,
                        // ignore: prefer_const_constructors
                        style:
                        TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                      ),
                      Column(
                        children: [
                          Container(
                            width: 170,
                            height: 20,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(0),
                                    topRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(
                                      20,
                                    ),
                                    bottomRight: Radius.circular(
                                      20,
                                    ))),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Overview(items: [snapshot.data![index]],)),
                                );
                              },
                              child: Center(
                                  child: Text(
                                    'Discover',
                                    style:
                                    TextStyle(color: Colors.white, fontSize: 15),
                                  )),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                );
              }, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing:20,
              mainAxisSpacing: 20,
            ),
            );
          } else if (snapshot.hasError) {

            return Text("Error");
          }
          return Text("Loading...");
        },
      ),
    );
  }
}

