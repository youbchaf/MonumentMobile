import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

post(id) async {
  final http.Response response = await http.post(Uri.parse('http://127.0.0.1:8080/MonumentProjetWS/Commentaires'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'id': id,

    }),
  );

  if (response.statusCode == 200) {
    print(response.body);
  }else {
    throw Exception('Failed to create album.');
  }

}

var id;
class Overview extends StatefulWidget {


  var items;
  Overview({required this.items});

  @override
  State<Overview> createState() => _OverviewState();


}

class _OverviewState extends State<Overview> {

  @override
  void initState(){
    super.initState();

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xfff4f4f4),
        title: const Text(
          'Monument',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('${widget.items.first.url}'),
                      fit: BoxFit.cover)),
              child: Container(
                width: double.infinity,
                height: 350,
                decoration: BoxDecoration(
                    gradient:
                    LinearGradient(begin: Alignment.bottomCenter, colors: [
                      Colors.black.withOpacity(0.7),
                      Colors.black.withOpacity(0.4),
                    ])),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${widget.items.first.nom}',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.online_prediction,
                                color: Colors.white,
                                size: 30,
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text(
                            "${widget.items.first.zone.nom}".toUpperCase(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "   ${widget.items.first.zone.ville.nom}".toUpperCase(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[200],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.timer,
                              color: Colors.grey[700],
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Créneau",
                              style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            "${widget.items.first.heureOpen} AM - ${widget.items.first.heureClose} PM",
                            style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 18,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[200],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.maps_ugc,
                              color: Colors.grey[700],
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Les coordonnées",
                              style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            "Lat : ${widget.items.first.latitude}  "+ "Long : ${widget.items.first.longitude}",
                            style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 18,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[200],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.category_outlined,
                              color: Colors.grey[700],
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Type",
                              style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            " ${widget.items.first.type.libelle} ",
                            style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 18,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),

                  Container(
                    padding: EdgeInsets.all(20),
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[200],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.supervised_user_circle_outlined,
                              color: Colors.grey[700],
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Creator",
                              style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            " ${widget.items.first.creator.nom} ",
                            style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 13,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),

                  Container(
                    padding: EdgeInsets.all(20),
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[200],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.verified_user_outlined,
                              color: Colors.grey[700],
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Creator story",
                              style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            " ${widget.items.first.creator.description} ",
                            style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 13,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),



                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

