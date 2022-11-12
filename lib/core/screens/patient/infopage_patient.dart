import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_3ala5er/core/screens/patient/bar.dart';
import 'package:new_3ala5er/core/screens/patient/patient_page.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:intl/intl.dart' as intl;
import 'package:new_3ala5er/core/service/firebase.service.dart';
import 'package:new_3ala5er/main.dart';

import '../loading.dart';

//test new branch
late double before;
late double after;
late int tag;
late String period;
late String cardDay;
late String amPm;
late String wa2t;
late String arabicDay;
late String englishDay;
FirebaseServiceDoctor doctor = FirebaseServiceDoctor();

class patientInformation extends StatefulWidget {
  @override
  _patientInformationState createState() => _patientInformationState();
}

DateTime dt = DateTime.now();
intl.DateFormat formatter = intl.DateFormat('dd-MM-yyyy');
DateTime day = DateTime.now();
intl.DateFormat ww = intl.DateFormat('EEEE');

void checkDate() {
  /// 1st step :
  if (UserSimplePreferencesUser.getLastOpen() == null) return;
  DateTime lastOpen =
      DateTime.parse(UserSimplePreferencesUser.getLastOpen().toString());
  DateTime currentOpen = DateTime.now();
  int difference = currentOpen.difference(lastOpen).inDays;
  //int difference = 8;

  if (difference >= 7 || currentOpen.day < lastOpen.day) {
    //set new last open
    UserSimplePreferencesUser.setLastOpen(DateTime.now().toString());

    //counter of week ++
    UserSimplePreferencesUser.setCtOfWeek(
        (int.parse(UserSimplePreferencesUser.getCtOfWeek()!.toString()) + 1)
            .toString());
    FirebaseServiceDoctor().createNewWeek();
  }
}

class _patientInformationState extends State<patientInformation> {
  final _reading = TextEditingController();

  bool loading = true;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    CollectionReference users = FirebaseFirestore.instance
        .collection('/doctors')
        .doc(UserSimplePreferencesDoctorID.getDrID())
        .collection('/patient');

    return FutureBuilder<DocumentSnapshot>(
      future: users
          .doc(UserSimplePreferencesUser.getUserID() ?? uid)
          .collection('/weeks')
          .doc(UserSimplePreferencesUser.getCtOfWeek())
          .get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.data == null) return Loading();

        if (snapshot.hasError) {
          return Text("ERROR");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("ERROR");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          return Scaffold(
            backgroundColor: Colors.white,
            body: ListView(children: [
              Directionality(
                textDirection: TextDirection.rtl,
                child: Padding(
                  padding: EdgeInsets.only(right: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      /// welcome statement with name of user
                      Padding(
                        padding: const EdgeInsets.only(bottom: 25.0),
                        child: Center(
                          child: Row(
                            children: [
                              ImageIcon(
                                AssetImage('images/profile.png'),
                                size: 80,
                                color: Color.fromRGBO(117, 121, 122, 1),
                              ),
                              Column(
                                children: [
                                  Text(
                                    'مرحبا',
                                    style: TextStyle(
                                        fontSize: 24,
                                        color:
                                            Color.fromRGBO(139, 139, 139, 1)),
                                  ),
                                  Text(
                                    UserSimplePreferencesUser.getPaName()
                                        .toString(),
                                    style: TextStyle(fontSize: 24),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),

                      ///Tow buttons "before" & "after"
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Column(
                              children: [
                                Text(
                                  'صائم',
                                  style: TextStyle(fontSize: 18),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.white,
                                      elevation: 0,
                                      shape: CircleBorder()),
                                  child: Container(
                                    child: Image(
                                      image:
                                          AssetImage('images/afterButton.png'),
                                    ),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.4),
                                          spreadRadius: 2,
                                          blurRadius: 10,
                                          offset: Offset(0,
                                              8), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      showMaterialModalBottomSheet(
                                        context: context,
                                        backgroundColor: Colors.transparent,
                                        expand: true,
                                        builder: (context) => BackdropFilter(
                                          filter: ImageFilter.blur(
                                              sigmaX: 15, sigmaY: 15),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                height: screenHeight * 0.7,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft: Radius
                                                                .circular(30),
                                                            topRight:
                                                                Radius.circular(
                                                                    30))),
                                                child: ListView(
                                                  children: <Widget>[
                                                    Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 30.0),
                                                            child: IconButton(
                                                              onPressed: () =>
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop(),
                                                              icon: Icon(
                                                                Icons.close,
                                                                size: 16,
                                                              ),
                                                            ))),
                                                    ListTile(
                                                        title: Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                bottom: 15.0),
                                                        child: Text(
                                                          'ادخال القراءة و انت صائم',
                                                          style: TextStyle(
                                                              fontSize: 24,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      52,
                                                                      91,
                                                                      99,
                                                                      1)),
                                                        ),
                                                      ),
                                                    )),
                                                    Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: SizedBox(
                                                        width: 204,
                                                        child: TextField(
                                                          textAlign:
                                                              TextAlign.center,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          controller: _reading,
                                                          decoration:
                                                              InputDecoration(
                                                            contentPadding:
                                                                EdgeInsets
                                                                    .symmetric(
                                                                        vertical:
                                                                            22.0),
                                                            border:
                                                                OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          219,
                                                                          228,
                                                                          230,
                                                                          1),
                                                                  width: 1.5),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          18.0),
                                                            ),
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          219,
                                                                          228,
                                                                          230,
                                                                          1),
                                                                  width: 3.0),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          18.0),
                                                            ),
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderSide: const BorderSide(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          133,
                                                                          165,
                                                                          171,
                                                                          1),
                                                                  width: 3.0),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          18.0),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 20.0),
                                                          child: SizedBox(
                                                            height: 54,
                                                            child:
                                                                ElevatedButton(
                                                              style: ElevatedButton
                                                                  .styleFrom(
                                                                      fixedSize:
                                                                          Size(204,
                                                                              37),
                                                                      textStyle: TextStyle(
                                                                          fontSize:
                                                                              18),
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(52),
                                                                      ),
                                                                      primary: Color
                                                                          .fromRGBO(
                                                                              52,
                                                                              91,
                                                                              99,
                                                                              1)),
                                                              onPressed: () {
                                                                setState(() {
                                                                  time();
                                                                  timeInEnglish();
                                                                  tag = 1;
                                                                  before = double
                                                                      .parse(_reading
                                                                          .text);
                                                                  if (before <=
                                                                      0) {
                                                                    showDialog<
                                                                        String>(
                                                                      context:
                                                                          context,
                                                                      builder: (BuildContext
                                                                              context) =>
                                                                          AlertDialog(
                                                                        title: const Text(
                                                                            'ERROR'),
                                                                        content:
                                                                            const Text('الرقم الذي ادخلته خاطئ  , الرجاء اعادة ادخال الرقم '),
                                                                        actions: <
                                                                            Widget>[
                                                                          TextButton(
                                                                            onPressed: () =>
                                                                                Navigator.pop(context, 'OK'),
                                                                            child:
                                                                                const Text('OK'),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    );
                                                                  } else {
                                                                    // if (oldPA == true)
                                                                    //   doctor.writeReadingsBeforeOLD(
                                                                    //       data['BeforeReadings'], before,
                                                                    //       arabicDay,
                                                                    //       period,
                                                                    //       wa2t,data['Days_English_before'],englishDay
                                                                    //   );
                                                                    // else
                                                                    doctor
                                                                        .writeReadingsBefore(
                                                                      before,
                                                                      arabicDay,
                                                                      period,
                                                                      wa2t,
                                                                      englishDay,
                                                                      data[
                                                                          'BeforeReadings'],
                                                                      data[
                                                                          'Days_English_before'],
                                                                      DateTime
                                                                          .now(),
                                                                    );
                                                                    _reading
                                                                        .clear();
                                                                    Navigator.pop(
                                                                        context);
                                                                  }
                                                                });
                                                              },
                                                              child: Text(
                                                                'ادخال القراءة',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                            ),
                                                          ),
                                                        )),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                                  },
                                  // icon: Icon(Icons.add),
                                  // label: Text(''),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Column(
                              //mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'غير صائم',
                                  style: TextStyle(fontSize: 18),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.white,
                                      elevation: 0,
                                      shape:
                                          CircleBorder() //elevated btton background color
                                      ),
                                  child: Container(
                                    child: Image(
                                      image:
                                          AssetImage('images/beforeButton.png'),
                                    ),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.4),
                                          spreadRadius: 2,
                                          blurRadius: 10,
                                          offset: Offset(0,
                                              8), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      showMaterialModalBottomSheet(
                                        context: context,
                                        backgroundColor: Colors.transparent,
                                        expand: true,
                                        builder: (context) => BackdropFilter(
                                          filter: ImageFilter.blur(
                                              sigmaX: 15, sigmaY: 15),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                height: screenHeight * 0.7,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft: Radius
                                                                .circular(30),
                                                            topRight:
                                                                Radius.circular(
                                                                    30))),
                                                //color: Colors.white,
                                                child: ListView(
                                                  children: <Widget>[
                                                    Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 30.0),
                                                            child: IconButton(
                                                              onPressed: () =>
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop(),
                                                              icon: Icon(
                                                                Icons.close,
                                                                size: 16,
                                                              ),
                                                            ))),
                                                    ListTile(
                                                        title: Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 15.0),
                                                        child: Text(
                                                          'ادخال القراءة و انت غير صائم ',
                                                          style: TextStyle(
                                                              fontSize: 24,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      52,
                                                                      91,
                                                                      99,
                                                                      .6)),
                                                          // Color.fromRGBO(
                                                          //     187, 214, 197, 1)),
                                                        ),
                                                      ),
                                                    )),
                                                    Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: SizedBox(
                                                        width: 204,
                                                        child: TextField(
                                                          textAlign:
                                                              TextAlign.center,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          controller: _reading,
                                                          decoration:
                                                              InputDecoration(
                                                            contentPadding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        22.0),
                                                            border:
                                                                OutlineInputBorder(
                                                              borderSide: const BorderSide(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          219,
                                                                          228,
                                                                          230,
                                                                          1),
                                                                  width: 1.5),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          18.0),
                                                            ),
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderSide: const BorderSide(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          187,
                                                                          214,
                                                                          197,
                                                                          .54),
                                                                  width: 1.5),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          18.0),
                                                            ),
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderSide: const BorderSide(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          187,
                                                                          214,
                                                                          197,
                                                                          1),
                                                                  width: 3.0),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          18.0),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 20.0),
                                                        child: SizedBox(
                                                          height: 54,
                                                          child: ElevatedButton(
                                                              style: ElevatedButton
                                                                  .styleFrom(
                                                                      fixedSize:
                                                                          Size(204,
                                                                              37),
                                                                      textStyle: TextStyle(
                                                                          fontSize:
                                                                              18),
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(52),
                                                                      ),
                                                                      primary: Color.fromRGBO(
                                                                          187,
                                                                          214,
                                                                          197,
                                                                          1)),
                                                              onPressed: () {
                                                                setState(() {
                                                                  time();
                                                                  timeInEnglish();
                                                                  tag = 0;
                                                                  after = double
                                                                      .parse(_reading
                                                                          .text);
                                                                  if (after <=
                                                                      0) {
                                                                    showDialog<
                                                                        String>(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (BuildContextcontext) =>
                                                                              AlertDialog(
                                                                        title: const Text(
                                                                            'ERROR'),
                                                                        content:
                                                                            const Text('الرقم الذي ادخلته خاطئ  , الرجاء اعادة ادخال الرقم '),
                                                                        actions: <
                                                                            Widget>[
                                                                          TextButton(
                                                                            onPressed: () =>
                                                                                Navigator.pop(context, 'OK'),
                                                                            child:
                                                                                const Text('OK'),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    );
                                                                  } else {
                                                                    doctor
                                                                        .writeReadingsAfter(
                                                                      after,
                                                                      arabicDay,
                                                                      period,
                                                                      wa2t,
                                                                      englishDay,
                                                                      data[
                                                                          'AfterReadings'],
                                                                      data[
                                                                          'Days_English_after'],
                                                                      DateTime
                                                                          .now(),
                                                                    );
                                                                    _reading
                                                                        .clear();
                                                                    Navigator.pop(
                                                                        context);
                                                                  }
                                                                });
                                                              },
                                                              // icon: Icon(Icons.add),
                                                              child: const Text(
                                                                'ادخال القراءة ',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              )),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                                  },
                                  //label: Text(''),
                                )
                              ],
                            ),
                          )
                        ],
                      ),

                      ///title of readings
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Directionality(
                              textDirection: TextDirection.rtl,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(right: 8.0, top: 25),
                                child: Text(
                                  'القراءات',
                                  style: TextStyle(fontSize: 30),
                                ),
                              ))
                        ],
                      ),

                      /// row of "before readings"
                      SingleChildScrollView(
                        physics: PageScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: callingListBefore(data['BeforeReadings'],
                              data['BeforeReadingsDateArabic']),
                        ),
                      ),

                      /// row of "after readings"
                      SingleChildScrollView(
                        physics: PageScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: callingListAfter(data['AfterReadings'],
                              data['AfterReadingsDateArabic']),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ]),
          );
        }

        return Text("loading");
      },
    );
  }

  /// before :

  List<Widget> callingListBefore(List<dynamic> array11, List<dynamic> array22) {
    cardListBefore.clear();
    fillCardsBefore(array11, array22);
    return cardListBefore;
  }

  void fillCardsBefore(
      List<dynamic> arrayBeforeRead, List<dynamic> arrayBeforeDate) {
    for (var i = 0; i < arrayBeforeRead.length; i++) {
      String read = arrayBeforeRead[i].toString();
      String date = arrayBeforeDate[i].toString();
      print("**** " + read + "  " + date);
      cardListBefore.add(beforeCard(read, date));
    }
  }

  Widget beforeCard(final String read, final String dateC) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0, bottom: 10.0, left: 20),
        child: Card(
          margin: const EdgeInsets.only(bottom: 8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          color: Color.fromRGBO(52, 91, 99, 0.81),
          elevation: 10.0,
          child: SizedBox(
            height: 115.0,
            width: 315,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, right: 15.0),
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'صائم',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        //TODO this should be a variable depending on the users reading , compare to baseline thr print the state , normal , high, low
                        double.parse(read) >= 130.0 ? 'مرتفع'
                            : double.parse(read) <= 80.0 ? 'منخفض' : 'طبيعي'  ,
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '$dateC',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '$read',
                  style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// after :

  List<Widget> callingListAfter(List<dynamic> array1, List<dynamic> array2) {
    cardListAfter.clear();
    fillCardsAfter(array1, array2);
    return cardListAfter;
  }

  void fillCardsAfter(
      List<dynamic> arrayAfterRead, List<dynamic> arrayAfterDate) {
    for (var i = 0; i < arrayAfterRead.length; i++) {
      String read = arrayAfterRead[i].toString();
      String date = arrayAfterDate[i].toString();
      print("**** " + read + "  " + date);
      cardListAfter.add(afterCard(read, date));
    }
  }

  Widget afterCard(final String read, final String dateC) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, bottom: 10.0, left: 20),
      child: Card(
        margin: const EdgeInsets.only(bottom: 14.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        color: Color.fromRGBO(187, 214, 197, 0.9),
        elevation: 10.0,
        child: SizedBox(
          height: 115.0,
          width: 315,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0, right: 15.0),
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'غير صائم',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      //TODO this should be a variable depending on the users reading , compare to baseline thr print the state , normal , high, low
                      double.parse(read) >= 180.0 ? 'مرتفع'
                          : double.parse(read) <= 130.0 ? 'منخفض' : 'طبيعي'  ,
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '$dateC',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '$read',
                style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),

              // Text(formattedDate(
              //     document.data()['data']
              // )
              // ),
            ],
          ),
        ),
      ),
    );
  }

  String time() {
    dt = DateTime.now();
    period = formatDate(dt, [
      HH,
      ':',
      mm,
    ]);
    amPm = intl.DateFormat('a').format(dt).toString();

    if (amPm == 'AM')
      wa2t = 'صباحا';
    else
      wa2t = 'مساءا';

    if (dt.weekday == 1)
      arabicDay = 'الاثنين'; //monday
    else if (dt.weekday == 2)
      arabicDay = 'الثلثاء'; //tues
    else if (dt.weekday == 3)
      arabicDay = 'الاربعاء'; //wed
    else if (dt.weekday == 4)
      arabicDay = 'الخميس'; //thurs
    else if (dt.weekday == 5)
      arabicDay = 'الحمعة'; //fri
    else if (dt.weekday == 6)
      arabicDay = 'السبت'; //sat
    else if (dt.weekday == 7) arabicDay = 'الاحد';
    //sun
    return cardDay = '$arabicDay' + ' - ' + '$period' + ' - ' + '$wa2t';
  }

  String timeInEnglish() {
    dt = DateTime.now();
    if (dt.weekday == 1)
      englishDay = 'mon'; //monday
    else if (dt.weekday == 2)
      englishDay = 'tues'; //tues
    else if (dt.weekday == 3)
      englishDay = 'wed'; //wed
    else if (dt.weekday == 4)
      englishDay = 'thurs'; //thurs
    else if (dt.weekday == 5)
      englishDay = 'fri'; //fri
    else if (dt.weekday == 6)
      englishDay = 'sat'; //sat
    else if (dt.weekday == 7) englishDay = 'sun';
    //sun
    return '$englishDay';
  }

  @override
  void initState() {
    super.initState();
    checkDate();
    //WidgetsBinding.instance.addPostFrameCallback((_) => checkDate());
    beforeCard;
    afterCard;
    callingListBefore;
    fillCardsAfter;
    callingListAfter;
    fillCardsBefore;
    cardListBefore;
    cardListAfter;
  }

  @override
  void dispose() {
    _reading.clear();
    _reading.dispose();
    super.dispose();
  }
}

List<Widget> cardListBefore = [];
List<Widget> cardListAfter = [];
