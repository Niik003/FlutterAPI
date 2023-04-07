import 'package:flutter/material.dart';
import 'package:flutter_api/complex_api_without_model.dart';
import 'package:flutter_api/complex_model_api.dart';
import 'package:flutter_api/custome_model_api.dart';
import 'package:flutter_api/home_screen.dart';
import 'package:flutter_api/image_upload_api.dart';
import 'package:flutter_api/sign_up.dart';
import 'package:flutter_api/very_complex_api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const SignUp(),
    );
  }
}
