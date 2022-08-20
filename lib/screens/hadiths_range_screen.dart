import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hadith_book/screens/hadiths_screen.dart';
import 'package:hadith_book/widgets/my_hadith_range_container.dart';
import 'package:http/http.dart' as http;

class HadithsRangeScreen extends StatelessWidget {
  final String bookname;
  final String bookNameBangla;

  const HadithsRangeScreen({
    required this.bookname,
    required this.bookNameBangla,
    Key? key,
  }) : super(key: key);

  Future getHadithsRange(String bookname) async {
    http.Response response =
        await http.get(Uri.parse("https://alquranbd.com/api/hadith/$bookname"));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Data Loading Error");
    }
  }

  hadithRange(hadith_range) {
    return ListView.builder(
      itemCount: hadith_range.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 5.0,
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => HadithsScreen(
                    chapterNo: hadith_range[index]["chSerial"],
                    bookName: hadith_range[index]["bookInitial"],
                    bookNameBangla: bookNameBangla,
                    chNameBangla: hadith_range[index]["nameBengali"],
                  ),
                ),
              );
            },
            child: MyHadithRangeContainer(
              hadith_range: hadith_range,
              index: index,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("$bookNameBangla", style: TextStyle(fontSize: 16.0),),
          centerTitle: true,
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          padding: EdgeInsets.only(top: 12.0),
          child: FutureBuilder(
              future: getHadithsRange(bookname),
              builder: (BuildContext context, AsyncSnapshot sn) {
                if (sn.hasData) {
                  List hadith_range = sn.data;
                  return hadithRange(hadith_range);
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
              }),
        ),
      ),
    );
  }
}
