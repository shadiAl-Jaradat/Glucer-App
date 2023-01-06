import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_3ala5er/core/screens/loading.dart';
import 'package:new_3ala5er/core/service/firebase.service.dart';
import 'package:new_3ala5er/core/service/firebase.service.dart';
import 'package:intl/intl.dart' as intl;

import '../bar.dart';
import '../list.dart';
import '../patient_page.dart';


final intl.DateFormat formatter = intl.DateFormat('dd-MM-yyyy');

bool selected = false;
String time = 'اليوم - الشهر - السنة';
final _time = TextEditingController();





class EditPatientPage extends StatefulWidget {
  const EditPatientPage({Key? key}) : super(key: key);

  @override
  _EditPatientPageState createState() => _EditPatientPageState();
}

class _EditPatientPageState extends State<EditPatientPage> {

  @override
  Widget build(BuildContext context) {


    CollectionReference users = FirebaseFirestore.instance
        .collection('/doctors')
        .doc(UserSimplePreferencesDoctorID.getDrID())
        .collection('/patient');

    return FutureBuilder(
        future: users
            .doc(UserSimplePreferencesUser.getUserID() ?? uid)
            .get(),

        builder:  (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.data == null) return Loading();

          if (snapshot.hasError) {
            return Text("ERROR");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return Text("ERROR");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
            return ScreenLoaded(data: data);
          }

          return Loading();
        }

    );



  }
}


class ScreenLoaded extends StatefulWidget {
  Map<String, dynamic> data;
  ScreenLoaded({required this.data, Key? key}) : super(key: key);

  @override
  State<ScreenLoaded> createState() => _ScreenLoadedState();
}

class _ScreenLoadedState extends State<ScreenLoaded> {
  final _formKey = GlobalKey<FormState>();
  late double screenHeight;
  late double screenWidth;
  late double textScale;
  late String namePatient;
  late String heightPatient;
  late String weightPatient;
  late String doctorId;
  late String DateOfPatient;
  late String nationalNumberPatient;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    textScale = MediaQuery.of(context).textScaleFactor;

    return Scaffold(
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
                                            namePatient = value;
                                          }
                                        },
                                        initialValue: widget.data['Name'] ?? "name",
                                        decoration: InputDecoration(
                                          labelText: 'الاسم',
                                          hintText: 'الرجاء ادخال الاسم الثلاثي',
                                          labelStyle: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black
                                          ),
                                          hintStyle: TextStyle(
                                              fontSize: 18,
                                              color: Color.fromRGBO(
                                                  178, 178, 178, 1)),
                                        ),
                                      ),


                                      TextFormField(
                                        validator: (value) {
                                          if (value == null ||
                                              value.isEmpty &&
                                                  value.length < 10) {
                                            return 'هذه الخانة مطلوبه';
                                          } else {
                                            nationalNumberPatient = value;
                                          }
                                        },
                                        //TODO:GG
                                        maxLength: 10,
                                        keyboardType: TextInputType.number,
                                        initialValue: widget.data['National ID'] ?? "dd",
                                        decoration: InputDecoration(
                                          counter: SizedBox.shrink(),
                                          labelText: 'الرقم الوطني',
                                          hintText: 'xxxxxxxxxx',
                                          labelStyle: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black),
                                          hintStyle: TextStyle(
                                              fontSize: 18,
                                              color: Color.fromRGBO(
                                                  178, 178, 178, 1)),
                                        ),
                                      ),


                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              "نوع السكري",
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.black,
                                              )),
                                          DiabetesType(firstValue: widget.data['Diabetes Type']),
                                        ],
                                      ),


                                      TextFormField(
                                        validator: (value) {
                                          if (value == null ||
                                              value.isEmpty) {
                                            return 'هذه الخانة مطلوبه';
                                          } else {
                                            DateOfPatient = value;
                                          }
                                        },
                                        //controller: _time,
                                        readOnly: true,
                                        initialValue: widget.data['Date of birth'].toString(),
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


                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: 140,
                                            child: TextFormField(
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'هذه الخانة مطلوبه';
                                                } else {
                                                  heightPatient = value;
                                                }
                                              },
                                              keyboardType:
                                              TextInputType.number,
                                              initialValue: widget.data['Hieght'] ?? "dd",
                                              decoration: InputDecoration(
                                                labelText: 'الطول',
                                                labelStyle: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black),
                                                hintStyle: TextStyle(
                                                    fontSize: 18,
                                                    color: Color.fromRGBO(
                                                        178, 178, 178, 1)),
                                                hintText: 'م',
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 140,
                                            child:
                                            TextFormField(
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'هذه الخانة مطلوبه';
                                                } else {
                                                  weightPatient = value;
                                                }
                                              },
                                              keyboardType: TextInputType.number,
                                              initialValue: widget.data['weight'] ?? " dd",
                                              decoration: InputDecoration(
                                                labelText: 'الوزن',
                                                labelStyle: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black,
                                                ),
                                                hintStyle: TextStyle(
                                                    fontSize: 18,
                                                    color: Color.fromRGBO(
                                                        178, 178, 178, 1)),
                                                hintText: 'كج',
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),


                                      TextFormField(
                                        validator: (value) {
                                          if (value == null ||
                                              value.isEmpty) {
                                            return 'هذه الخانة مطلوبه';
                                          } else {
                                            doctorId = value;
                                          }
                                        },
                                        maxLength: 5,
                                        initialValue: widget.data['Doctor code'] ?? "dd",
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
                                          onPressed: () async {
                                            if (_formKey.currentState!.validate()) {
                                              await FirebaseServiceDoctor()
                                                  .updateData();
                                              Navigator.push( context,MaterialPageRoute( builder: (context) => barhome()));


                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                    content: Text('Processing data')),
                                              );

                                            }

                                            if (_formKey.currentState!
                                                .validate()) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                    content: Text(
                                                        'Processing data')),
                                              );
                                            }
                                            if (
                                                doctorId != null ||
                                                DateOfPatient != null ||
                                                namePatient != null ||
                                                heightPatient != null ||
                                                weightPatient != null ||
                                                nationalNumberPatient != null) {
                                              FirebaseServiceDoctor(
                                                DateOfPatient: DateOfPatient,
                                                doctorId: doctorId,
                                                heightPatient: heightPatient,
                                                namePatient: namePatient,
                                                nationalNumberPatient: nationalNumberPatient,
                                                weightPatient: weightPatient,
                                                patentPhone: widget.data['phone'],
                                              ).insertDataCollection();
                                              //Navigator.push(context, MaterialPageRoute(builder: (context) => barhome()));
                                              Navigator.pop(context);
                                              //Navigator.pop(context);
                                            } else {
                                              showDialog<String>(
                                                context: context,
                                                builder: (BuildContext context) => AlertDialog(
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
                                            };
                                          },
                                          child: Text(
                                            'تعديل',
                                            style: TextStyle(fontSize: 22),
                                          )),


                                    ],
                                  ),
                                ),
                              ),
                            )
                          ])),
                ]),
              ))),
    );
  }
}
