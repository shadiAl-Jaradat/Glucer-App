import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:new_3ala5er/core/screens/patient/bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'core/screens/doctor/lstOfMyPatient.dart';
import 'core/screens/patient/infopage_patient.dart';
import 'core/screens/patient/patient_page.dart';
import 'core/screens/usertype.dart';
import 'core/service/authservice.dart';
import 'core/service/firebase.service.dart';

late String one;
late String two;
late String three;
late String four;
bool oldPA = false;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await UserSimplePreferencesUser.init();
  await UserSimplePreferencesDoctorID.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cloudbase',
      theme: ThemeData(
          primarySwatch: Colors.blueGrey, primaryColor: Colors.blueGrey),
      //TODO (Razan,shadi,yazan) when want to test any page just replace user() with the class name for the page you are working on
        home: AnimatedSplashScreen(
            splash: 'images/launchLogo.jpeg',
          duration: 2000,
          splashIconSize: 400,
          nextScreen: signin(),
          splashTransition: SplashTransition.scaleTransition,
        ),
      // replace user to  barhome => shady & yazan
      // replace user to  patient => razan
      initialRoute: '/',
    );
  }
  @override
  void initState() {
    super.initState();

  }
}
//when we are finished with this class we should copy it to authservive.dart
class signin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    if(user == null){
      print("new");
      return AppUser();
    }
    else
      {
        print("old  & user type is : " + UserSimplePreferencesDoctorID.geUserType().toString());
        if(UserSimplePreferencesDoctorID.geUserType() == 'Pa'){
          oldPA = true;
          one = UserSimplePreferencesUser.getUserID() ?? '';
          two =  UserSimplePreferencesDoctorID.getDrID() ?? '';
          three =  UserSimplePreferencesUser.getPaName() ?? '';
          four =  UserSimplePreferencesUser.getLastOpen() ?? 'this is the first time';
          print("***** old");
          print('***** userID : '+ one);
          print('***** DrID : '+ two);
          print('***** userName : ' + three);
          print('***** last open : ' + four);
          return barhome();
        }
        else{
          one = UserSimplePreferencesDoctorID.getDrName() ?? '';
          two =  UserSimplePreferencesDoctorID.getDrID() ?? '';
          print("***** Dr Name :  "+ one );
          print("***** Dr ID :  " + two );
          return listOfPatient();
        }


      }

  }
}


