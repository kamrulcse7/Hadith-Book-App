import 'package:flutter/material.dart';

class MyBookNameContainer extends StatelessWidget {
  const MyBookNameContainer({
    Key? key,
    this.hadiths,
    this.index,
  }) : super(key: key);
  final dynamic hadiths;
  final int? index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.only(bottom: 26.0, left: 10.0, right: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            blurRadius: 8.0,
            offset: Offset(3.0, 3.5),
            color: Colors.black.withOpacity(0.5),
          )
        ],
      ),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Image.asset(
              "assets/images/logo.png",
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "${hadiths[index]["nameBengali"]}",
                    style: TextStyle(
                        fontSize: 14.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "সর্বমোট হাদিস: ${hadiths[index]["hadith_number"]}",
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
