import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../widgets/my_book_name_container.dart';
import 'hadiths_range_screen.dart';

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

  bookName(hadiths) {
    return GridView.builder(
      itemCount: 8,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 4,
        childAspectRatio: 0.8,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => HadithsRangeScreen(
                  bookname: hadiths[index]["book_key"],
                  bookNameBangla: hadiths[index]["nameBengali"],
                ),
              ),
            );
          },
          child: MyBookNameContainer(
            hadiths: hadiths,
            index: index,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.green[50],
        appBar: AppBar(
          title: Text('হাদিস বইসমূহ', style: TextStyle(fontSize: 16.0),),
          elevation: 0,
          centerTitle: true,
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          padding: EdgeInsets.only(top: 16, left: 6, right: 6),
          child: FutureBuilder(
            future: getHadiths(),
            builder: (BuildContext context, AsyncSnapshot sn) {
              if (sn.hasData) {
                List hadiths = sn.data;
                return bookName(hadiths);
              }
              if (sn.hasError) {
                return Center(
                  child: Container(
                    width: 35.0,
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
