import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_3ala5er/core/screens/phonev/loginscreen.dart';
import 'package:new_3ala5er/core/screens/predictor/bmiScreen.dart';

//import 'package:flutter_test/flutter_test.dart';
late bool choice;

class AppUser extends StatefulWidget {
  @override
  _AppUserState createState() => _AppUserState();
}

class _AppUserState extends State<AppUser> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: SafeArea(
      child: Scaffold(
        body: SizedBox(
          //background
          child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/gradient.png"),
                    fit: BoxFit.cover)),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: FractionallySizedBox(
                heightFactor: 0.75,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 50.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 30.0, left: 30.0, right: 30.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 158,
                                          height: 198,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              choice = true;
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          LoginScreen()));
                                            },
                                            style: ElevatedButton.styleFrom(
                                                primary: const Color.fromRGBO(241, 245, 241, 1),
                                                elevation: 0.0,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16))),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 30.0),
                                                    child: Image(
                                                        image: AssetImage(
                                                            'images/Doctor.png')),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 15.0),
                                                    child: Text(
                                                      'دكتور',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color.fromRGBO(91, 122, 128, 1),
                                                          fontSize: 25),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        SizedBox(
                                          width: 158,
                                          height: 198,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              choice = false;
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          LoginScreen()));

                                              // Navigator.of(context).push(MaterialPageRoute(
                                              // builder: (context) => OTPScreen(_controller.text,chose)));
                                              // },
                                            },
                                            style: ElevatedButton.styleFrom(
                                                primary: const Color.fromRGBO(
                                                    241, 245, 241, 1),
                                                elevation: 0.0,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16))),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(top: 25.0),
                                                    child: Image(
                                                        image: AssetImage('images/patient.png')),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(top: 20.0),
                                                    child: Text(
                                                      'مريض',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color.fromRGBO(91, 122, 128, 1),
                                                          fontSize: 25),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50,
                                  ),
                                  Center(
                                    //padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      'او',
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(117, 121, 122, 1),
                                          fontSize: 20),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  SizedBox(
                                    width: 326,
                                    height: 72,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: const Color.fromRGBO(
                                                194, 218, 203, 1),
                                            elevation: 0.0,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16))),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      BMIScreen()));
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'الفحص',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  //Color.fromRGBO(91, 122, 128, 100),
                                                  fontSize: 25),
                                            ),
                                            Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Image(
                                                    image: AssetImage(
                                                        'images/tsts.png')))
                                          ],
                                        )),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
