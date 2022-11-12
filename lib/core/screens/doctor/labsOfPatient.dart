// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
//
// import '../../service/firebase.service.dart';
// import '../loading.dart';
//
// class Labs extends StatefulWidget {
//   final String? patientID;
//   const Labs({this.patientID});
//
//   @override
//   State<Labs> createState() => _LabsState(patientID: patientID);
// }
//
// class _LabsState extends State<Labs> {
//   final String? patientID;
//   _LabsState({this.patientID})
//   @override
//   Widget build(BuildContext context) {
//     CollectionReference users = FirebaseFirestore.instance
//         .collection('/doctors')
//         .doc(UserSimplePreferencesDoctorID.getDrID())
//         .collection('/patient');
//
//     return FutureBuilder(
//         future: users.doc(patientID).collection('/weeks').doc(UserSimplePreferencesUser.getCtOfWeek()).get(),
//         builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//           if (snapshot.data == null) return Loading();
//
//           if (snapshot.hasError) {
//             return Text("ERROR");
//           }
//
//           if (snapshot.hasData && !snapshot.data!.exists) {
//             return Text("ERROR");
//           }
//
//         }
//     );
//   }
// }
