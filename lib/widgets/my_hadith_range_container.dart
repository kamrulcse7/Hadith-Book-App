import 'package:flutter/material.dart';

class MyHadithRangeContainer extends StatelessWidget {
  final dynamic hadith_range;
  final int index;
  const MyHadithRangeContainer({
    Key? key,
    required this.hadith_range,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3.0),
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
      child: ListTile(
        leading: Image.asset("assets/images/logo.png"),
        title: Padding(
          padding: const EdgeInsets.only(bottom: 6.0),
          child: Text("${hadith_range[index]["nameBengali"]}", textAlign: TextAlign.justify,),
        ),
        subtitle: Text(
            "হাদিস নম্বর: ${hadith_range[index]["range_start"]} - ${hadith_range[index]["range_end"]}"),
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
