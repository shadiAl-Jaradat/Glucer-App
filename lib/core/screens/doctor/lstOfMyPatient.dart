/*import 'package:flutter/material.dart';
import 'regestrationDrPage.dart';
class info extends StatefulWidget {
  @override
  _infoState createState() => _infoState();
}

class _infoState extends State<info> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text("I am a doctor",style: TextStyle(fontSize: 20),),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text("my name is "+  firstname_docotr + " " + lastname_doctor,style: TextStyle(fontSize: 20),),
          ),
        ],
      ) ,
    );
  }
}
*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_3ala5er/core/screens/doctor/PatientDetails.dart';
import 'package:new_3ala5er/core/screens/doctor/regestrationDrPage.dart';

import '../../service/firebase.service.dart';
import '../loading.dart';


class listOfPatient extends StatefulWidget {
  @override
  _listOfPatientState createState() => _listOfPatientState();
}

class _listOfPatientState extends State<listOfPatient> {
  // final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  late List<String> listOfName = [];
  late List<String> listOfIDs = [];
  late List<double> listOfLastReading = [];
  late List<bool> listOfIsHaveNewRead = [];
  late List<String> listOfHistories = [];

  String searchString = "";

  @override
  void initState() {
    super.initState();
    Future<QuerySnapshot<Map<String, dynamic>>> pa = FirebaseFirestore.instance.collection('/doctors').doc(UserSimplePreferencesDoctorID.getDrID()).collection('/patient').get();
    pa.then((value) {
      var x = value.docs;
      listOfName.clear();
      listOfLastReading.clear();
      for(int i=0;i<x.length;i++){
        final user = x[i].data();
        setState(() {
          print("shoooo ?? ");
          print(user['Name']);
          listOfName.add(user['Name'].toString());
          listOfIDs.add(user['User'].toString());
          listOfLastReading.add(double.parse(user['lastRead'].toString()));
          listOfIsHaveNewRead.add(user['isHaveNewRead']);
          listOfHistories.add(user['history']);
        });
        Future<QuerySnapshot<Map<String, dynamic>>> re = FirebaseFirestore.instance.collection('/doctors')
            .doc(UserSimplePreferencesDoctorID.getDrID()).collection('/patient')
            .doc(user['User'].toString()).collection('/weeks').get();
        re.then((value) {
          var y = value.docs;
          // List<dynamic> listRA = y.last.data()['BeforeReadings'];
          // List<dynamic> listRB = y.last.data()['AfterReadings'];
          // if(listRA.isEmpty && listRB.isEmpty){
          //   setState(() {
          //     listOfLastReading.add('no');
          //   });
          // }
          // else if(listRA.isEmpty && listRB.isNotEmpty){
          //   setState(() {
          //     dynamic lastRB = listRB[listRB.length-1];
          //     listOfLastReading.add(lastRB.toString());
          //   });
          // }
          // else if(listRB.isEmpty && listRA.isNotEmpty){
          //   setState(() {
          //     dynamic lastRA = listRA[listRA.length-1];
          //     listOfLastReading.add(lastRA.toString());
          //   });
          // }
          // else {
          //   setState(() {
          //     dynamic lastRA = listRA[listRA.length-1];
          //     dynamic lastRB = listRB[listRB.length-1];
          //     listOfLastReading.add(lastRB > lastRA ? lastRB.toString() : lastRA.toString());
          //   });
          // }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    final drawerHeader = UserAccountsDrawerHeader(
      decoration: BoxDecoration(
        color: Color.fromRGBO(135, 165, 171, 0.63),
      ),
      accountName: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ImageIcon(
            AssetImage('images/profile.png'),
            color: Colors.white,
            size: 68,
          ),
          Text(
            UserSimplePreferencesDoctorID.getDrName() ?? 'name',
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
        ],
      ),
      accountEmail: Text(''),
      // currentAccountPicture: ImageIcon(
      //   AssetImage('images/profile.png'),
      //   color: Colors.white,
      // ),
    );
    final drawerItems = ListView(
      children: <Widget>[
        drawerHeader,
        ListTile(
          title: Row(
            children: [
              ImageIcon(
                AssetImage('images/info.png'),
                color: Colors.white,
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                'تعديل بيانات',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ],
          ),
          onTap: () {},
        ),
        Divider(
          thickness: 1,
          color: Colors.white,
          indent: 30,
          endIndent: 30,
        ),
        ListTile(
          title: Row(
            children: [
              ImageIcon(
                AssetImage('images/call.png'),
                color: Colors.white,
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                'تواصل معنا',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ],
          ),
          onTap: () {},
        ),
        Divider(
          thickness: 1,
          color: Colors.white,
          indent: 30,
          endIndent: 30,
        ),
      ],
    );
    return Scaffold(
      // key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(218, 228, 229, 30),
        automaticallyImplyLeading: false,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(14),
                bottomLeft: Radius.circular(14))),
        elevation: 0,
        iconTheme: IconThemeData(color: Color.fromRGBO(133, 165, 177, 1), size: 30),
      ),
      endDrawer: Directionality(
        textDirection: TextDirection.rtl,
        child: Drawer(
          backgroundColor: Color.fromRGBO(135, 165, 171, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(14), bottomLeft: Radius.circular(14)),
          ),
          //shape: Icon(Icons.menu),
          child: drawerItems,
        ),
      ),

      backgroundColor: Color.fromRGBO(241, 245, 245, 1),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'مرحبا',
                    style: TextStyle(
                        fontSize: 20, color: Color.fromRGBO(139, 170, 176, 1)),
                  ),
                  Text(
                    UserSimplePreferencesDoctorID.getDrName() ?? "Name",
                    style: TextStyle(
                        fontSize: 20, color: Color.fromRGBO(139, 170, 176, 1)),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Image.asset(
                  'images/profile.png',
                  color: Color.fromRGBO(139, 170, 176, 1),
                ),
              )
            ],
          ),

          //TODO Change into actual search box
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: SizedBox(
              width: 331,
              height: 50,
              child: Container(
                //padding: EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: Color.fromRGBO(218, 228, 229, 1),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        searchString = value.toLowerCase();
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'بحث',
                      suffixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                // child: Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.end,
                //     children: [
                //       Text(
                //         'بحث',
                //         style: TextStyle(
                //             color: Colors.white,
                //             fontWeight: FontWeight.bold,
                //             fontSize: 20),
                //       ),
                //       Padding(
                //         padding: const EdgeInsets.only(left: 8.0),
                //         child: Icon(
                //           Icons.search_outlined,
                //           color: Colors.white,
                //         ),
                //       )
                //     ],
                //   ),
                // ),
              ),
            ),
          ),
          listOfName.isNotEmpty || listOfName != null ?
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(18.0),
              child: ListView.builder(
                  itemCount: listOfName.length,
                  itemBuilder: (context,index){
                    print("ana hon");
                    print(listOfName);
                    return listOfName[index].contains(searchString)?
                    PatientCard(
                      name: listOfName[index] ,
                      id: listOfIDs[index],
                      lastRead: listOfLastReading[index],
                      isHaveNewRead: listOfIsHaveNewRead[index],
                      history: listOfHistories[index],
                    )
                        : Container();
                  }
              ),
            ),
          ) : Container(),
        ],
      ),
    );

  }
}

FirebaseServiceDoctor doctor = FirebaseServiceDoctor();
class PatientCard extends StatelessWidget {
  final String name;
  final String id;
  final double lastRead;
  final bool isHaveNewRead;
  final String history;
  const PatientCard({
    required this.name,
    required this.id,
    required this.lastRead,
    required this.isHaveNewRead,
    required this.history,
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    print("esmaaaaa3 " + name +'  ' + id  + ' '+ lastRead.toString());
    return GestureDetector(
      onTap: () {
        doctor.makePatientHasNewReadFalse(userID: id);
        Navigator.push(context, MaterialPageRoute(builder: (context) => Details(idPa: id,namePa: name,history: history,)));
      },
      child: Card(
        margin: EdgeInsets.only(bottom: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            isHaveNewRead == true ?
            Padding(
              padding: const EdgeInsets.all(40),
              child: Container(
                width: 11,
                height: 11,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                     color: Color.fromRGBO(212, 240, 222, 0.90)
                  //color: Colors.amber,
                ),
              ),
            )
            :Padding(
              padding: const EdgeInsets.all(40),
              child: Container(
                width: 11,
                height: 11,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(212, 240, 222, 0)
                  //color: Colors.amber,
                ),
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  name,
                  style: TextStyle(
                      color: Color.fromRGBO(135, 165, 171, 1), fontSize: 22),
                ),
                //TODO automate from readings
                Text(
                    lastRead == 0 ? '' :
                    (lastRead >= 130.0 ? 'مرتفع'
                        : lastRead <= 80.0 ? 'منخفض' : 'طبيعي'),
                  style: TextStyle(
                      color: Color.fromRGBO(135, 165, 171, 0.63), fontSize: 13),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Icon(Icons.account_circle_outlined,size: 60,color: Color.fromRGBO(135, 165, 171, 0.63),)
            ),
            SizedBox(
              width: 3,
              height: 60,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: lastRead == 0 ? null :
                  (lastRead >= 130.0 ?  Colors.red
                      : lastRead <= 80.0 ? Colors.red : Colors.green),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//green: Color.fromRGBO(170, 222, 190, 1),
//yellow:  Color.fromRGBO(253, 191, 111, 1),