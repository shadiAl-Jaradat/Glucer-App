import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show DeviceOrientation, SystemChrome;

import 'package:huawei_scan/HmsScanLibrary.dart';
import 'package:huawei_scan/HmsScan.dart';
import 'package:huawei_scan/hmsCustomizedView/HmsCustomizedView.dart';
import 'package:huawei_scan/hmsMultiProcessor/MultiCameraRequest.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String permissionState = "Permissions Are Not Granted.";
  bool hmsLoggerStatus = true;

  @override
  void initState() {
    permissionRequest();
    super.initState();
  }

  permissionRequest() async {
    bool? permissionResult =
    await HmsScanPermissions.hasCameraAndStoragePermission();
    if (permissionResult != true) {
      await HmsScanPermissions.requestCameraAndStoragePermissions();
    } else {
      setState(() {
        permissionState = "All Permissions Are Granted";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text("HMS Flutter Scan Kit"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 12.0,
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height / 8,
              ),
              child: Image.asset(
                "assets/scan_kit_logo.png",
                fit: BoxFit.fitHeight,
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      "",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      "",
                      textAlign: TextAlign.center,
                    ),
                  ],
                )),
            SizedBox(
              height: 12.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        "Permission State",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(permissionState),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}