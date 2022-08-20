import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HadithsScreen extends StatelessWidget {
  final String chapterNo;
  final String bookName;
  final String bookNameBangla;
  final String chNameBangla;
  const HadithsScreen({
    Key? key,
    required this.chapterNo,
    required this.bookName,
    required this.bookNameBangla,
    required this.chNameBangla,
  }) : super(key: key);

  Future getHadiths(String bookname, String chapterNo) async {
    http.Response response = await http.get(
        Uri.parse("https://alquranbd.com/api/hadith/$bookname/$chapterNo"));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Data Loading Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "$bookNameBangla > $chNameBangla",
          style: TextStyle(fontSize: 16.0),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.only(top: 12.0),
        child: FutureBuilder(
            future: getHadiths(bookName, chapterNo),
            builder: (BuildContext context, AsyncSnapshot sn) {
              if (sn.hasData) {
                List hadits = sn.data;
                return ListView.builder(
                    itemCount: hadits.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 16.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                              width: 0.8,
                              color: Colors.teal,
                            ),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 6.0,
                                offset: Offset(2.0, 2.5),
                                color: Colors.black.withOpacity(0.3),
                              )
                            ],
                          ),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                child: Column(
                                  children: [
                                    Text(
                                      "${hadits[index]["hadithBengali"]}",
                                      textAlign: TextAlign.justify,
                                    ),
                                    Text(
                                      "${hadits[index]["hadithArabic"]}",
                                      textAlign: TextAlign.justify,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Colors.teal, width: 1.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      );
                    });
              }
              if (sn.hasError) {
                return Center(
                  child: Container(
                    width: 35.0,
                    child: CircularProgressIndicator(
                      color: Color(0xFF08a180),
                    ),
                  ),
                );
              }
              return Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF08a180),
                ),
              );
            }),
      ),
    );
  }
}
