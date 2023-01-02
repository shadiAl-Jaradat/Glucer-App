/*import 'package:flutter/material.dart';
import '../../service/firebase.service.dart';
import 'lstOfMyPatient.dart';
 late String firstname_docotr;
 late String lastname_doctor;
 late String code_doctor;

class doctor extends StatefulWidget {
  @override
  _doctorState createState() => _doctorState();
}

class _doctorState extends State<doctor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Doctor page",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              onChanged: (value) {
                firstname_docotr = value;
              },
              autofocus: true,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your name',
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              onChanged: (value) {
                lastname_doctor = value;
              },
              autofocus: true,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your last name',
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextButton(
            onPressed: () {
              FirebaseServiceDoctor().insertData();
              Navigator.push(context, MaterialPageRoute(builder: (context) => info()));
            },
            child: Text("login"),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(16.0),
              primary: Colors.black,
              textStyle: const TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';
import 'package:new_3ala5er/core/screens/doctor/lstOfMyPatient.dart';
import '../../service/firebase.service.dart';

import 'package:intl/intl.dart' as intl;



final intl.DateFormat formatter = intl.DateFormat('dd-MM-yyyy');

bool selected = false;
String time = 'اليوم - الشهر - السنة';
final _time = TextEditingController();

class doctor extends StatefulWidget {
  @override
  _doctorState createState() => _doctorState();
}

class _doctorState extends State<doctor> {
  late String firstnameDoctor = "";
  late String lastnameDoctor = "";
  late String doctorID = "";
  late String DateBirthDoctor = "";
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        //resizeToAvoidBottomInset: false,
        body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/gradient.png"),
                    fit: BoxFit.cover)),
            child: Align(
                alignment: Alignment.bottomLeft,
                child: Scrollbar(
                  child: ListView(shrinkWrap: true, children: [
                    AnimatedContainer(
                        duration: Duration(milliseconds: 1000),
                        curve: Curves.linear,
                        width: double.infinity,
                        //height: selected ? screenHeight * 0.9 : screenHeight * 0.75,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40.0),
                              topRight: Radius.circular(40.0)),
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Form(
                                key: _formKey,
                                child: Container(
                                  color: Colors.white,
                                  margin: EdgeInsets.fromLTRB(25, 25, 25, 10),
                                  height: selected
                                      ? screenHeight * 0.9
                                      : screenHeight * 0.75,
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      textDirection: TextDirection.rtl,
                                      children: [
                                        TextFormField(
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'هذه الخانة مطلوبه';
                                            } else {
                                              firstnameDoctor = value;
                                            }
                                          },
                                          decoration: InputDecoration(
                                            labelText: 'الاسم الأول',
                                            hintText:
                                                'الرجاء ادخال الاسم الأول',
                                            labelStyle: TextStyle(
                                                fontSize: 18,
                                                color: Colors.black),
                                            hintStyle: TextStyle(
                                                fontSize: 18,
                                                color: Color.fromRGBO(
                                                    178, 178, 178, 1)),
                                          ),
                                        ),

                                        TextFormField(
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'هذه الخانة مطلوبه';
                                            } else {
                                              lastnameDoctor = value;
                                            }
                                          },
                                          decoration: InputDecoration(
                                            labelText: 'اسم العائلة',
                                            hintText:
                                                'الرجاء ادخال اسم العائلة',
                                            labelStyle: TextStyle(
                                                fontSize: 18,
                                                color: Colors.black),
                                            hintStyle: TextStyle(
                                                fontSize: 18,
                                                color: Color.fromRGBO(
                                                    178, 178, 178, 1)),
                                          ),
                                        ),

                                        TextFormField(
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'هذه الخانة مطلوبه';
                                            } else {
                                              DateBirthDoctor = value;
                                            }
                                          },
                                          controller: _time,
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            focusColor: Color.fromRGBO(
                                                178, 178, 178, 1),
                                            labelText: 'تاريخ الميلاد',
                                            hintText: 'اليوم - الشهر - السنة',
                                            labelStyle: TextStyle(
                                                fontSize: 18,
                                                color: Colors.black),
                                            hintStyle: TextStyle(
                                                fontSize: 18,
                                                color: Color.fromRGBO(
                                                    178, 178, 178, 1)),
                                            suffixIconColor: Color.fromRGBO(
                                                178, 178, 178, 1),
                                            suffixIcon: IconButton(
                                                onPressed: () async {
                                                  final myDateTime =
                                                      await showDatePicker(
                                                          context: context,
                                                          initialDate:
                                                              DateTime.now(),
                                                          firstDate:
                                                              DateTime(1920),
                                                          lastDate:
                                                              DateTime(2025));
                                                  setState(() {
                                                    time = intl.DateFormat(
                                                            'dd-MM-yyyy')
                                                        .format(myDateTime!);
                                                    _time.text = time;
                                                  });
                                                },
                                                icon:
                                                    Icon(Icons.calendar_today)),
                                          ),
                                          onTap: () async {
                                            final myDateTime =
                                                await showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime(1920),
                                                    lastDate: DateTime(2025));
                                            setState(() {
                                              time =
                                                  intl.DateFormat('dd-MM-yyyy')
                                                      .format(myDateTime!);
                                              _time.text = time;
                                            });
                                          },
                                        ),

                                        TextFormField(
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'هذه الخانة مطلوبه';
                                            } else {
                                              doctorID = value;
                                            }
                                          },
                                          maxLength: 5,
                                          decoration: InputDecoration(
                                            counter: SizedBox.shrink(),
                                            labelText: 'رمز الدكتور',
                                            hintText: 'xxxxx',
                                            labelStyle: TextStyle(
                                                fontSize: 18,
                                                color: Colors.black),
                                            hintStyle: TextStyle(
                                                fontSize: 18,
                                                color: Color.fromRGBO(
                                                    178, 178, 178, 1)),
                                          ),
                                        ),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: Color.fromRGBO(
                                                  189, 208, 201, 1),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(14.0),
                                              ),
                                              minimumSize: Size(308, 35),
                                            ),
                                            onPressed: () {
                                              if (_formKey.currentState!.validate()) {
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(content: Text('Processing data')),
                                                );
                                              }
                                              if (firstnameDoctor.isNotEmpty ||
                                                  lastnameDoctor.isNotEmpty ||
                                                  DateBirthDoctor.isNotEmpty ||
                                                  doctorID.isNotEmpty) {
                                                FirebaseServiceDoctor(
                                                  DateBirthDoctor: DateBirthDoctor,
                                                  lastnameDoctor: lastnameDoctor,
                                                  firstnameDoctor: firstnameDoctor,
                                                  doctorID:doctorID,
                                                ).insertData();
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => listOfPatient()));
                                              } else {
                                                showDialog<String>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          AlertDialog(
                                                    title: Text('ERROR'),
                                                    content: Text('no '),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context, 'OK'),
                                                        child: Text('OK'),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }
                                              ;
                                            },
                                            child: Text(
                                              'التالي',
                                              style: TextStyle(fontSize: 22),
                                            )),
                                        // SizedBox(
                                        //   height: 30,
                                        // )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ])),
                  ]),
                ))));
  }
}
