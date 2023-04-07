import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CustomeModelApi extends StatefulWidget {
  const CustomeModelApi({Key? key}) : super(key: key);

  @override
  State<CustomeModelApi> createState() => _CustomeModelApiState();
}

class _CustomeModelApiState extends State<CustomeModelApi> {

  List<Photos> photoList = [];
  
  Future<List<Photos>> getPhotos () async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data = jsonDecode(response.body.toString());

    if(response.statusCode == 200) {
      for(Map i in data) {
        Photos photos = Photos(title: i['title'], url: i['url'], id: i['id']);
        photoList.add(photos);
      }
      return photoList;
    } else {
      return photoList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('CUSTOME MODEL API'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPhotos(),
              builder: (context, AsyncSnapshot<List<Photos>> snapshot){
                return ListView.builder(
                  itemCount: photoList.length,
                  itemBuilder: (context, index){
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(snapshot.data![index].url.toString()),
                      ),
                      title: Text('Notes ID: '+snapshot.data![index].id.toString()),
                      subtitle: Text(snapshot.data![index].title.toString()),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Photos {
  String title, url;
  int id;
  Photos({required this.title, required this.url, required this.id});
}