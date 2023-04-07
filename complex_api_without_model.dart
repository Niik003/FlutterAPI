import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ComplexApiWithoutModel extends StatefulWidget {
  const ComplexApiWithoutModel({Key? key}) : super(key: key);

  @override
  State<ComplexApiWithoutModel> createState() => _ComplexApiWithoutModelState();
}

class _ComplexApiWithoutModelState extends State<ComplexApiWithoutModel> {

  var data;

  Future<void> getUserApi() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    if(response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
    } else {

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('COMPLEX API WITHOUT MODEL'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getUserApi(),
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
                        child: Card(
                          elevation: 5.0,
                          shape: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          child: Column(
                            children: [
                              ReusableRow(
                                title: 'Name:',
                                value: data[index]['name'].toString(),
                              ),
                              ReusableRow(
                                title: 'Username:',
                                value: data[index]['username'].toString(),
                              ),
                              ReusableRow(
                                title: 'Email:',
                                value: data[index]['email'].toString(),
                              ),
                              Divider(
                                color: Colors.black,
                                indent: 5,
                                endIndent: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Address:',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              ReusableRow(
                                title: 'Street:',
                                value: data[index]['address']['street'].toString(),
                              ),
                              ReusableRow(
                                title: 'City:',
                                value: data[index]['address']['city'].toString(),
                              ),
                              ReusableRow(
                                title: 'Zipcode:',
                                value: data[index]['address']['zipcode'].toString(),
                              ),
                              ReusableRow(
                                title: 'Geo:',
                                value: data[index]['address']['geo'].toString(),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String title, value;
  ReusableRow({Key? key, required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.bold),),
          Text(value),
        ],
      ),
    );
  }
}