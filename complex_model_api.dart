import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models/user_model.dart';

class ComplexModelApi extends StatefulWidget {
  const ComplexModelApi({Key? key}) : super(key: key);

  @override
  State<ComplexModelApi> createState() => _ComplexModelApiState();
}

class _ComplexModelApiState extends State<ComplexModelApi> {

  List<UserModel> userList = [];

  Future<List<UserModel>> getUserApi () async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body.toString());

    if(response.statusCode == 200) {
      for(Map i in data) {
        userList.add(UserModel.fromJson(i));
      }
      return userList;
    } else {
      return userList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('COMPLEX MODEL API'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getUserApi(),
              builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
                if(!snapshot.hasData) {
                  return CircularProgressIndicator();
                } else {
                  return ListView.builder(
                    itemCount: userList.length,
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
                                value: snapshot.data![index].name.toString(),
                              ),
                              ReusableRow(
                                title: 'Username:',
                                value: snapshot.data![index].username.toString(),
                              ),
                              ReusableRow(
                                title: 'Email:',
                                value: snapshot.data![index].email.toString(),
                              ),
                              ReusableRow(
                                title: 'Address:',
                                value: snapshot.data![index].address!.city.toString(),
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
      padding: const EdgeInsets.all(8.0),
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
