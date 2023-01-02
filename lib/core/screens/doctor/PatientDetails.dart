import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_3ala5er/core/screens/doctor/lstOfMyPatient.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../service/firebase.service.dart';
import '../loading.dart';

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double y;
}

class Details extends StatefulWidget {
  final String namePa;
  final String idPa;
  final String history;
  const Details({
   required this.idPa,
    required this.namePa,
    required this.history,
  });

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  late TooltipBehavior _tooltipBehavior = TooltipBehavior(enable: true);
  TextEditingController _historyController=new TextEditingController();

  @override
  void initState() {
    // _historyController = TextEditingController();
    //_historyController.text =  widget.history.isEmpty || widget.history == null ? "" : widget.history;
    _tooltipBehavior = TooltipBehavior(enable: true);
  }
  FirebaseServiceDoctor doctor = FirebaseServiceDoctor();
  @override
  Widget build(BuildContext context) {

    CollectionReference users = FirebaseFirestore.instance
        .collection('/doctors')
        .doc(UserSimplePreferencesDoctorID.getDrID())
        .collection('/patient');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(widget.idPa).collection('/weeks').doc('0').get(),
    builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
      if (snapshot.hasError) {
        return Text("ERROR");
      }

      if (snapshot.hasData && !snapshot.data!.exists) {
        return Text("ERROR");
      }

      if (snapshot.connectionState == ConnectionState.done){
        Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
        return Scaffold(
          backgroundColor: Color.fromRGBO(241, 245, 245, 1),
          body: ListView(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 10, 30.0, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => listOfPatient()));
                    },
                    icon: Icon(Icons.arrow_back_ios),
                    color: Color.fromRGBO(139, 170, 177, 1),
                  ),
                  Image.asset(
                    'images/profile.png',
                    color: Color.fromRGBO(139, 170, 177, 1),
                  )
                ],
              ),
            ),
            //TODO chart
            Container(
              height: 300,
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: SfCartesianChart(
                    // primaryXAxis: CategoryAxis(),
                      primaryXAxis:CategoryAxis(),
                      legend: Legend(
                        isVisible: true,
                        position: LegendPosition.top,
                      ),
                      tooltipBehavior: _tooltipBehavior,

                      series: <LineSeries>[
                        LineSeries<ChartData, String>(
                            name: "قبل الاكل",
                            color: Color.fromRGBO(52, 91, 99, 1),
                            dataSource:  <ChartData>[
                              for(int i=0;i< data['BeforeReadings'].length ; i++)
                                ChartData(data['Days_English_before'][i], double.parse(data['BeforeReadings'][i].toString()) ),
                            ],
                            xValueMapper: (ChartData data, _) => data.x,
                            yValueMapper: (ChartData data, _) => data.y,
                            // Enable data label
                            dataLabelSettings: DataLabelSettings(isVisible: true)
                        ),
                        LineSeries<ChartData, String>(
                            name: "بعد الاكل",
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
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Row(
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
            ),
            Container(
              alignment: Alignment.center,
              //color: Colors.red,
              child: SizedBox(width: 200, child: ToggleButtonDoc()),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.85,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    //Image.asset('images/newtest.png'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                         // data['Name'].toString(),
                          widget.namePa,
                          style: TextStyle(
                            fontSize: 36,
                            color: Color.fromRGBO(139, 170, 177, 1),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Image.asset('images/patient.png',
                            color: Color.fromRGBO(139, 170, 177, 1), scale: 2.5),
                      ],
                    ),

                    Text(
                      'سجل',
                      style: TextStyle(
                        fontSize: 25,
                        color: Color.fromRGBO(139, 170, 177, 1),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Container(
                        width: 315,
                        height: 280,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            border: Border.all(
                              color: Color.fromRGBO(139, 170, 177, 1),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            //controller: _historyController ,
                            initialValue: widget.history.isEmpty || widget.history == null ? "" : widget.history,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: InputDecoration(border: InputBorder.none),
                            onChanged: (value){
                              doctor.updateHistoryOfPatient(
                                  userID: widget.idPa,
                                  newHistory: value,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Row(
                        children: [
                          Text(
                            'المختبرات',
                            style: TextStyle(
                              fontSize: 25,
                              color: Color.fromRGBO(139, 170, 177, 1),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          GestureDetector(
                            onTap: (){

                            },
                            child: Text(
                              'عرض الكل',
                              style: TextStyle(
                                fontSize: 10,
                                color: Color.fromRGBO(139, 170, 177, 1),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ]),
        );
      }

      return Loading();
    }
    );
  }
}


class LabCard extends StatelessWidget {
  const LabCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8),
      //color: Color.fromRGBO(218, 228, 229, 1),
      height: 141,
      width: 114,
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
                padding: const EdgeInsets.all(10.0),
                child: Image(
                  image: AssetImage('images/lab.png'),
                  width: 42.5,
                  height: 53,
                )),

            //TODO: change الاول to a number based on number of labs entered
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 3.0),
                child: Text(
                  'نتيحة المختبر \n الاول',
                  style: TextStyle(
                      color: Color.fromRGBO(91, 122, 129, 1), fontSize: 15),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            // PDFViewer(document: widget.document));
          ],
        ),
      ),
    );
  }
}


class ToggleButtonDoc extends StatefulWidget {
  @override
  _ToggleButtonDocState createState() => _ToggleButtonDocState();
}

const double width = 220.0;
const double height = 60.0;
const double loginAlign = -1;
const double signInAlign = 1;
const Color selectedColor = Color.fromRGBO(139, 170, 177, 1);
const Color normalColor = Color.fromRGBO(218, 228, 229, 1);

class _ToggleButtonDocState extends State<ToggleButtonDoc> {
  double? xAlign;
  Color? loginColor;
  Color? signInColor;

  @override
  void initState() {
    super.initState();
    xAlign = loginAlign;
    loginColor = selectedColor;
    signInColor = normalColor;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 40,
      decoration: BoxDecoration(
        color: Color.fromRGBO(139, 170, 177, 1),
        borderRadius: BorderRadius.all(
          Radius.circular(14.0),
        ),
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            alignment: Alignment(xAlign!, 0),
            duration: Duration(milliseconds: 150),
            child: Container(
              width: width * 0.5,
              height: height,
              decoration: BoxDecoration(
                color: Color.fromRGBO(218, 228, 229, 1),
                borderRadius: BorderRadius.all(
                  Radius.circular(14.0),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                xAlign = loginAlign;
                loginColor = selectedColor;
                signInColor = normalColor;
              });
            },
            child: Align(
              alignment: Alignment(-1, 0),
              child: Container(
                width: width * 0.5,
                color: Colors.transparent,
                alignment: Alignment.center,
                child: Text(
                  'شهري',
                  style: TextStyle(
                    color: loginColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                xAlign = signInAlign;
                signInColor = selectedColor;
                loginColor = normalColor;
              });
            },
            child: Align(
              alignment: Alignment(1, 0),
              child: Container(
                width: width * 0.5,
                color: Colors.transparent,
                alignment: Alignment.center,
                child: Text(
                  'اسبوعي',
                  style: TextStyle(
                    color: signInColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
