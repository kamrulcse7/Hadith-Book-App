import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  Future getHadiths() async {
    http.Response response =
        await http.get(Uri.parse("http://alquranbd.com/api/hadith"));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Data Loading Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.green[50],
        appBar: AppBar(
          title: Text('হাদিসের বইসমূহ'),
          elevation: 0,
        ),
        body: Container(
          height: size.height,
          width: size.width,
          padding: EdgeInsets.only(top: 16, left: 6, right: 6),
          
        ),
      ),
    );
  }
}
