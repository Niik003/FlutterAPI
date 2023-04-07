import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models/Product_model.dart';

class VeryComplexApi extends StatefulWidget {
  const VeryComplexApi({Key? key}) : super(key: key);

  @override
  State<VeryComplexApi> createState() => _VeryComplexApiState();
}

class _VeryComplexApiState extends State<VeryComplexApi> {
  
  Future<ProductModel> getProductApi() async {
    final response = await http.get(Uri.parse('https://webhook.site/427b1966-bfb9-49cb-9bdf-10d21fe6cb3b'));
    var data = jsonDecode(response.body.toString());

    if(response.statusCode == 200) {
      return ProductModel.fromJson(data);
    } else {
      return ProductModel.fromJson(data);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('VERY COMPLEX API'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<ProductModel>(
              future: getProductApi(),
              builder: (context, snapshot) {
                if(snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.data!.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width*.1,
                            height: MediaQuery.of(context).size.height*.3,
                            child: ListView.builder(
                              itemCount: snapshot.data!.data![index].image!.length,
                              itemBuilder: (context, position) {
                                return Container(
                                  width: MediaQuery.of(context).size.width*.5,
                                  height: MediaQuery.of(context).size.height*.25,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(snapshot.data!.data![index].image![position].toString()),
                                    )
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
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
