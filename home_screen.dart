import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models/photo_model.dart';
import 'models/posts_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  List<PostsModel> postList = [];
  List<PhotoModel> photoList = [];
  
  Future<List<PostsModel>> getPostApi () async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200) {
      postList.clear();
      for(Map i in data) {
        postList.add(PostsModel.fromJson(i));
      }
      return postList;
    } else {
      return postList;
    }
  }

  Future<List<PhotoModel>> getPhotoApi () async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200) {
      photoList.clear();
      for(Map i in data) {
        photoList.add(PhotoModel.fromJson(i));
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
        title: Text("FLUTTER API's"),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPhotoApi(),
              builder: (context, snapshot) {
                if(!snapshot.hasData) {
                  return Center(
                    child: Text(
                    'Loading...',
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: photoList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: Card(
                          child: ListTile(
                            leading: Text(index.toString()),
                            trailing: Image.network(photoList[index].thumbnailUrl.toString()),
                            title: Text(photoList[index].title.toString()),
                          ),
                        ),
                      );
                    }
                  );
                }
              }
            ),
          ),
        ],
      ),
    );
  }
}
