import 'package:flutter/material.dart';



class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height =  MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(194, 218, 203, 1) ,
        title: Center(child: Text('النتيجة          ', style: TextStyle(color: Colors.white))),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(15.0),
              alignment: Alignment.bottomLeft,
              child: Text(
                'نسبة اصابتك بالسكري  ',
                style: TextStyle(
                  color: Color.fromRGBO(91, 122, 128, 1),
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              width: width* 0.5,
              height: height * 0.4,
              child: Card(
                color: Color.fromRGBO(194, 218, 203, 1) ,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "٢٠ % ",
                      style: TextStyle(
                        color: Color.fromRGBO(91, 122, 128, 1),
                        fontSize: 100.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "ينصح بمراجعة الطبيب و اجراء الفحوصات ",
                      textAlign: TextAlign.center,
                      style:  TextStyle(
                        color:Colors.blueGrey[800],
                        fontSize: 22.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
