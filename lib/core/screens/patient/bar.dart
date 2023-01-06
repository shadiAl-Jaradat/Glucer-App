import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_3ala5er/core/screens/patient/patient_page.dart';
import '../../service/firebase.service.dart';
import 'CHART_PAGES/char_patient.dart';
import 'infopage_patient.dart';

import 'menu/edit_patient_page.dart';
import 'menu/twasel.dart';

//String nn = name_patient;

final User? user = FirebaseAuth.instance.currentUser;
final uid = user?.uid;


Future<String> getName() async{
  final User? user = FirebaseAuth.instance.currentUser;
  final uid = user?.uid;
  return (FirebaseFirestore.instance.collection('/doctors').doc(UserSimplePreferencesDoctorID.getDrID()).collection('/patient').doc(uid).get()).toString();
}


class barhome extends StatefulWidget {
  const barhome({Key? key}) : super(key: key);

  @override
  _barhomeState createState() => _barhomeState();
}

class _barhomeState extends State<barhome> {
  PageController _pageController = PageController();
  List<Widget> _screens = [
    patientInformation(),
    ChartLabsPage(),
  ];

  int _selectedIndex = 0;

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onItemTapped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
  }



  @override
  Widget build(BuildContext context) {

    final drawerHeader = UserAccountsDrawerHeader(
      decoration: BoxDecoration(
        color: Color.fromRGBO(52, 91, 99, 0.81),
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
            UserSimplePreferencesUser.getPaName() ?? 'name',
            //+ name_patient,
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
          onTap: () {
            Navigator.push( context, MaterialPageRoute(builder: (context) => EditPatientPage()));
          },
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
          onTap: () {
            Navigator.push( context,
                MaterialPageRoute(
                    builder: (context) =>
                        twasel()
                )
            );
          },
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
                AssetImage('images/tsts.png'),
                color: Colors.white,
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                'الفحص',
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color.fromRGBO(53, 91, 93, 1), size: 30),
        automaticallyImplyLeading: false,
        bottomOpacity: 0.0,
        elevation: 0.0,
      ),
      endDrawer: Directionality(
        textDirection: TextDirection.rtl,
        child: Drawer(
          backgroundColor: Color.fromRGBO(52, 91, 99, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(14), bottomLeft: Radius.circular(14)),
          ),
          //shape: Icon(Icons.menu),
          child: drawerItems,
        ),
      ),

      body: PageView(
        controller: _pageController,
        children: _screens,
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
        child: BottomNavigationBar(
          selectedItemColor: Color.fromRGBO(52, 91, 99, 1),
          selectedIconTheme: IconThemeData(
            color: Color.fromRGBO(52, 91, 99, 1),
          ),
          unselectedItemColor: Color.fromRGBO(194, 218, 203, 1),
          unselectedIconTheme: IconThemeData(
            color: Color.fromRGBO(194, 218, 203, 1),
          ),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: Color.fromRGBO(242, 244, 241, 1),
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("images/home.png"),
                  color: _selectedIndex == 0
                      ? Color.fromRGBO(52, 91, 99, 1)
                      : Color.fromRGBO(194, 218, 203, 1),
                  size: 30,
                ),
                label: ''
            ),
            BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("images/chart.png"),
                  color: _selectedIndex == 1
                      ? Color.fromRGBO(52, 91, 99, 1)
                      : Color.fromRGBO(194, 218, 203, 1),
                  size: 30,
                ),
                label: ''
            )
          ],
        ),
      ),
    );
  }
}
