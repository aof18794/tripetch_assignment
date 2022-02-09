import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tripetch/components/hospital_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hospital',
      theme: ThemeData(primarySwatch: Colors.green),
      home: Scaffold(
        appBar: AppBar(
          title:
              const Align(alignment: Alignment.center, child: Text('Hospital')),
        ),
        body: HospitalPage(),
      ),
    );
  }
}

class HospitalPage extends StatefulWidget {
  const HospitalPage({Key? key}) : super(key: key);

  @override
  _HospitalPageState createState() => _HospitalPageState();
}

class _HospitalPageState extends State<HospitalPage> {
  Future getHospitalData() async {
    var url = Uri.https('tripetch-zombie.herokuapp.com', '/hospitals');

    var res = await http.get(url);

    Map jsonData = jsonDecode(res.body);

    List<Hospital> hospitals = [];
    for (var h in jsonData["hospitals"]) {
      Hospital hospital =
          Hospital(h['id'], h['name'], h['waitingList'], h['location']);
      hospitals.add(hospital);
    }

    return hospitals;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Card(
      child: FutureBuilder(
          future: getHospitalData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemBuilder: (context, i) {
                    // return ListTile(
                    //   title: Text((snapshot.data as dynamic)[i].name),
                    // );
                    return HospitalCard(
                        name: (snapshot.data as dynamic)[i].name);
                  },
                  itemCount: (snapshot.data as dynamic).length);
            } else {
              return const Text(
                'Loading hospital data',
                style: TextStyle(fontSize: 20),
              );
            }
          }),
    ));
  }
}

class Hospital {
  final int id;
  final String name;
  final List<dynamic> waitingList;
  final dynamic location;

  Hospital(this.id, this.name, this.waitingList, this.location);
}
