// import 'dart:convert';
//
// import 'package:flutter/material.dart';
//
// import 'models/test_model.dart';
// import 'package:http/http.dart'as http;
// class TestModelApi extends StatefulWidget {
//   const TestModelApi({Key? key}) : super(key: key);
//
//   @override
//   State<TestModelApi> createState() => _TestModelApiState();
// }
//
// class _TestModelApiState extends State<TestModelApi> {
//   List<TestModel> listmodel = [];
//
//   Future<TestModel> getApi() async{
//     final  response =await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
//     var data = jsonDecode(response.body.toString());
//     if(response.statusCode == 200){
//       for(Map i in data){
//         listmodel.add(TestModel.fromJson(i));
//         return TestModel;
//       }
//     } else{
//         return TestModel;
//     }
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('api'),
//       ),
//       body: Column(
//         children: [
//           Expanded(child: FutureBuilder(
//             future: getApi(),
//             builder: (context,snapshot){
//               if(!snapshot.hasData){
//                 return Center(
//                   child: Text(
//                     'Loading...',
//                   ),
//                 ),
//               }
//             }
//           ))
//         ],
//       ),
//     );
//   }
// }
