import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:new_3ala5er/core/screens/patient/CHART_PAGES/toggle.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:open_file/open_file.dart';

import '../../../service/firebase.service.dart';
import '../../loading.dart';
import '../bar.dart';
import '../patient_page.dart';

late String fileName;
final String sun = 'ح';
final String mon = 'ن';
final String tues = 'ت';
final String wed = 'ر';
final String thurs = 'خ';
final String fri = 'ج';
final String sat = 'س';

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double y;
}

class ChartLabsPage extends StatefulWidget {
  @override
  _ChartLabsPageState createState() => _ChartLabsPageState();
}

class _ChartLabsPageState extends State<ChartLabsPage> {
  late File? file;

  late TooltipBehavior _tooltipBehavior;
  bool isSwitched = false;

  int getNumOfDay(String day) {
    if (day == 'sat')
      return 0;
    else if (day == 'sun')
      return 1;
    else if (day == 'mon')
      return 2;
    else if (day == 'tues')
      return 3;
    else if (day == 'wed')
      return 4;
    else if (day == 'thurs')
      return 5;
    else
      return 6;
  }

  List<ChartData> chartDataBefore = [];
  List<ChartData> chartDataAfter = [];


  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    getLabs();
    //_Call_list_files();
    super.initState();
  }


  void getLabs() async {
    listOfLabs = await getFilesList();
    for(int index =0 ; index< listOfLabs.length ; index++){
      setState(() {
        _cardListFiles.add(createCardFile(listOfLabs[index]));
      });
    }
  }

  Future<firebase_storage.UploadTask> uploadFile(File file) async {
    if (file == null) {
      print("no");
    }

    firebase_storage.UploadTask uploadTask;

    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('Patients_labs')
        .child('/'+UserSimplePreferencesUser.getUserID().toString())
        .child('/' + file.path.split('/').last);


    final metadata = firebase_storage.SettableMetadata(
        contentType: 'patient/pdf',
        customMetadata: {'picked-file-path': file.path}
    );

    print("Uploading..!");

    uploadTask = ref.putData(await file.readAsBytes(), metadata);

    print("done..!");
    return Future.value(uploadTask);
  }


  ///***********************************************

  Future<List<String>> getFilesList() async {

    List<String> filePaths = [];
    Reference storageRef = FirebaseStorage.instance.ref()
        .child('Patients_labs')
        .child('/'+UserSimplePreferencesUser.getUserID().toString());

    dynamic listOfFiles = await storageRef.listAll();

    for (var file in listOfFiles.items) {
      String downloadURL = await file.getDownloadURL();
      filePaths.add(downloadURL);
     // _cardListFiles.add(createCardFile(downloadURL));
    }


    print(filePaths);
    return filePaths;
  }


  late double screenHeight;
  late double screenWidth;
  late double textScale;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    textScale = MediaQuery.of(context).textScaleFactor;

    CollectionReference users = FirebaseFirestore.instance
        .collection('/doctors')
        .doc(UserSimplePreferencesDoctorID.getDrID())
        .collection('/patient');

    return FutureBuilder<DocumentSnapshot>(
      future: users
          .doc(UserSimplePreferencesUser.getUserID() ?? uid)
          .collection('/weeks')
          .doc(UserSimplePreferencesUser.getCtOfWeek() ?? "0")
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
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return SafeArea(
            child: Scaffold(
              body: Align(
                alignment: Alignment.center,
                child: ListView(
                  children: [
                    Container(
                      height: screenHeight * 0.42,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: SfCartesianChart(
                              // primaryXAxis: CategoryAxis(),
                              primaryXAxis: CategoryAxis(),
                              legend: Legend(
                                isVisible: true,
                                position: LegendPosition.top,
                              ),
                              tooltipBehavior: _tooltipBehavior,
                              series: <LineSeries>[
                                LineSeries<ChartData, String>(
                                    name: "صائم",
                                    color: Color.fromRGBO(52, 91, 99, 1),
                                    dataSource: <ChartData>[
                                      for (int i = 0;
                                          i < data['BeforeReadings'].length;
                                          i++)
                                        ChartData(
                                            data['Days_English_before'][i],
                                            double.parse(data['BeforeReadings']
                                                    [i]
                                                .toString())),
                                    ],
                                    xValueMapper: (ChartData data, _) => data.x,
                                    yValueMapper: (ChartData data, _) => data.y,
                                    // Enable data label
                                    dataLabelSettings:
                                        DataLabelSettings(isVisible: true)),
                                LineSeries<ChartData, String>(
                                    name: "غير صائم",
                                  color: Color.fromRGBO(187, 214, 197, 1),
                                  dataSource:  <ChartData>[
                                    for(int i=0;i< data['AfterReadings'].length ; i++)
                                      ChartData(data['Days_English_after'][i], double.parse(data['AfterReadings'][i].toString()) ),
                                  ],
                                  xValueMapper: (ChartData data, _) => data.x,
                                  yValueMapper: (ChartData data, _) => data.y,
                                  // Enable data label
                                  dataLabelSettings: DataLabelSettings(isVisible: true)
                              )
                            ]
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.arrow_back_ios),
                          color: Color.fromRGBO(52, 91, 99, 1),
                          iconSize: 18,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
                          child: Text(
                            'الاسبوع الاول',
                            style: TextStyle(
                              color: Color.fromRGBO(52, 91, 99, 1),
                              fontSize: 20,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.arrow_forward_ios),
                          color: Color.fromRGBO(52, 91, 99, 1),
                          iconSize: 18,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),

                    //TODO toggle Button

                    //TODO:this Container is only for testing we should replace it with the info below the chart such as (what week and monthly,yearly)

                    SizedBox(
                      height: 5,
                    ),

                    Container(
                      // color: Colors.amber,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Text(
                          "المختبرات",
                          style: TextStyle(color: Colors.black, fontSize: 30),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ),

                    Container(
                      //color: Colors.red,
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 20, top: 10, left: 0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(14)),
                                        border: Border.all(
                                          color: Color.fromRGBO(218, 228, 229, 1),
                                          width: 2,
                                        ),
                                        //color: Colors.black,
                                      ),

                                      //color: Colors.black,
                                      height: screenHeight * 0.22,
                                      width: screenWidth * 0.30,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 27),
                                        child: Column(
                                          children: [
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                primary:
                                                Color.fromRGBO(91, 122, 129, 1),
                                                shape: CircleBorder(),
                                                padding: EdgeInsets.all(10),
                                              ),
                                              onPressed: () async {
                                                final result = await FilePicker.platform.pickFiles();
                                                if (result == null) return;
                                                final path = result.files.single.path!;
                                                setState(() => file = File(path));
                                                uploadFile(file!);
                                                _cardListFiles.add(createCardFile(path));
                                              },
                                              //icon: Icon(Icons.add),
                                              child: Icon(Icons.add, size: 40 * textScale),
                                            ),
                                            Align(
                                              alignment: Alignment.center,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 3.0),
                                                child: Text(
                                                  //'اضف نتيجة جديدة',
                                                  'اضف نتيجة\nجديدة',
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          91, 122, 129, 1),
                                                      fontSize: 25 * textScale),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: Row(
                                  children: _Call_list_files(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        };
        return Text("loading");
      },
    );
  }

  List<Widget> _cardListFiles = [];
  List<String> listOfLabs = [];
  List<Widget> _Call_list_files() {
    return _cardListFiles;
  }

  Widget createCardFile(String path) {
    //String? ext = Plt_file.extension;

    return InkWell(
      onTap: () => OpenFile.open(path),
      child: Padding(
        padding: const EdgeInsets.only(top: 10, right: 5, left: 5),
        child: Container(
          //color: Color.fromRGBO(218, 228, 229, 1),
          height: screenHeight * 0.22,
          width: screenWidth * 0.30,
          decoration: BoxDecoration(
            color: Color.fromRGBO(218, 228, 229, 1),
            borderRadius: BorderRadius.all(Radius.circular(14)),
            //border: Colors.black,
            border: Border.all(
              color: Color.fromRGBO(218, 228, 229, 1),
              width: 2,
            ),
          ),
          child: Card(
            elevation: 0,
            color: Color.fromRGBO(218, 228, 229, 1),
            //shape: RoundedRectangleBorder( Radius.circular(14)),
            child: Column(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Image(
                      image: AssetImage('images/lab.png'),
                      height: screenHeight * 0.1,
                      width: screenWidth * 0.1,
                    )),

                //TODO: change الاول to a number based on number of labs entered
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 3.0),
                    child: Text(
                      'نتيحة المختبر ',
                      style: TextStyle(
                          color: Color.fromRGBO(91, 122, 129, 1), fontSize: 25 * textScale),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),

                // PDFViewer(document: widget.document));
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DataAfterReadings {
  DataAfterReadings(List<dynamic> pastA, List<dynamic> pastD) {
    var pastR;
    var pastD;

    if (pastA == null) {
      for (var i = 0; i < pastR.length && pastR[i] != null; i++) {
        After.add(0);
      }
    } else {
      for (var i = 0; i < pastR.length && pastR[i] != null; i++) {
        After.add(pastR[i]);
      }
    }

    if (pastD == null) {
      for (var i = 0; i < pastD.length && pastD[i] != null; i++) {
        day.add(' ');
      }
    } else {
      for (var i = 0; i < pastD.length && pastD[i] != null; i++) {
        day.add(pastD[i]);
      }
    }
  }
  late List<double> After;
  late List<String> day;
}

class Data_Before_Readings {
  Data_Before_Readings(List<dynamic> pastA, List<dynamic> pastD) {
    var pastR;
    var pastD;
    if (pastA == null) {
      for (var i = 0; i < pastR.length && pastR[i] != null; i++) {
        Before.add(0);
      }
    } else {
      for (var i = 0; i < pastR.length && pastR[i] != null; i++) {
        Before.add(pastR[i]);
      }
    }

    if (pastD == null) {
      for (var i = 0; i < pastD.length && pastD[i] != null; i++) {
        day.add(' ');
      }
    } else {
      for (var i = 0; i < pastD.length && pastD[i] != null; i++) {
        day.add(pastD[i]);
      }
    }
  }
  late List<double> Before;
  late List<String> day;
}
//TODO:TO GET THE READINGS

List<double> Readings_chart_before(List<dynamic> pastR) {
  List<double> read_double_before = [];
  for (var i = 0; i < pastR.length && pastR[i] != null; i++) {
    read_double_before.add(pastR[i]);
  }
  return read_double_before;
}

List<double> Readings_chart_after(List<dynamic> pastR) {
  List<double> read_double_after = [];
  for (var i = 0; i < pastR.length && pastR[i] != null; i++) {
    read_double_after.add(pastR[i]);
  }

  return read_double_after;
}

//TODO:TOO GET THE DAY OF THE READINGS

List<String> Readings_day(List<dynamic> pastR) {
  List<String> read_days = [];
  for (var i = 0; i < pastR.length && pastR[i] != null; i++) {
    read_days.add(pastR[i]);
  }
  return read_days;
}


//   print(_cardList_8bl.length);
//   _cardList_8bl.add(_card_8bl());
//   print(_cardList_8bl.length);