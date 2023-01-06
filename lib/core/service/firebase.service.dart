import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_3ala5er/core/screens/patient/list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/doctor/regestrationDrPage.dart';
import '../screens/patient/bar.dart';
import '../screens/patient/patient_page.dart';
import 'dart:core';

class Date {
  String name = "";
  Date.fromJson(Map<String, dynamic> json) {
    name = json["name"];
  }
}

class FirebaseServiceDoctor {

  late String? firstnameDoctor;
  late String? lastnameDoctor;
  late String? doctorID;
  late String? DateBirthDoctor;

  late String? namePatient;
  late String? heightPatient;
  late String? weightPatient;
  late String? doctorId;
  late String? DateOfPatient;
  late String? nationalNumberPatient;
  late String? patentPhone;


  FirebaseServiceDoctor({
    this.doctorId,
    this.DateOfPatient,
    this.heightPatient,
    this.namePatient,
    this.nationalNumberPatient,
    this.weightPatient,

    this.firstnameDoctor,
    this.lastnameDoctor,
    this.DateBirthDoctor,
    this.doctorID,
    this.patentPhone
  });


  void insertData() async {
    try {
      await FirebaseFirestore.instance
          .collection('doctors')
          .doc(doctorID)
          .set({
        'first-name:': firstnameDoctor,
        'second-name:': lastnameDoctor,
        'DrID': doctorID,
      });
    } catch (e) {
      print(e);
    }
    await UserSimplePreferencesDoctorID.setDrID(doctorID!);
    await UserSimplePreferencesDoctorID.setDrName(firstnameDoctor!);
    await UserSimplePreferencesDoctorID.setUserType('Dr');
  }

  void insertDataCollection() async {
    final User? user = FirebaseAuth.instance.currentUser;
    final uid = user?.uid;



    await FirebaseFirestore.instance
        .collection('/doctors')
        .doc(doctorId)
        .collection('/patient')
        .doc(uid == null || uid.isEmpty ? UserSimplePreferencesUser.getUserID() : uid)
        .set({
      'Name': namePatient,
      'Doctor code': doctorId,
      'Hieght': heightPatient,
      'weight': weightPatient,
      'Date of birth': DateOfPatient,
      'National ID': nationalNumberPatient,
      'Diabetes Type': type_Di,
      'User': uid == null || uid.isEmpty ? UserSimplePreferencesUser.getUserID() : uid,
      'history': "",
      'isHaveNewRead':false,
      'lastRead': 0,
      'phone':patentPhone,
    });

    createNewWeek();
  }

  void createNewWeek() async {
    (await patientReadings()).set({
      'BeforeReadings': [],
      'BeforeReadingsDateArabic': [],
      'Days_English_before': [],
      'BeforeDateTime': [],
      'AfterReadings': [],
      'AfterReadingsDateArabic': [],
      'Days_English_after': [],
      'AfterDateTime': [],
    });
  }

  Future updateData() async {
    return await FirebaseFirestore.instance
        .collection('/doctors')
        .doc(doctorId)
        .collection('/patient')
        .doc(namePatient)
        .set({
      'Name': namePatient,
      'Doctor code': doctorId,
      'Hieght': heightPatient,
      'weight': weightPatient,
      'Date of birth': DateOfPatient,
      'National ID': nationalNumberPatient,
      'Diabetes Type': type_Di,
    });
  }

  Future<DocumentReference<Object?>> patientReadings() async {
    return await FirebaseFirestore.instance
        .collection('/doctors')
        .doc(UserSimplePreferencesDoctorID.getDrID() ?? doctorId)
        .collection('/patient')
        .doc(UserSimplePreferencesUser.getUserID() ?? uid)
        .collection('/weeks')
        .doc(UserSimplePreferencesUser.getCtOfWeek());
  }

  Future<DocumentReference<Object?>> patientUpdates() async {
    return await FirebaseFirestore.instance
        .collection('/doctors')
        .doc(UserSimplePreferencesDoctorID.getDrID() ?? doctorId)
        .collection('/patient')
        .doc(UserSimplePreferencesUser.getUserID() ?? uid);
  }

  void writeReadingsBefore(
      {
        required double newRead,
        required String arabicDay,
        required String period,
        required String wa2t,
        required String englishTime,

        required List<dynamic> oldReadings,
        required List<dynamic> oldDays,
        required List<dynamic> oldBeforeDateTime,
        required List<dynamic> oldBeforeReadingsDateArabic,

        required DateTime dateTime
      }) async {

    List<dynamic> before = oldReadings;
    List<dynamic> daysBefore = oldDays;

    List<dynamic> beforeReadingsDateArabicList = oldBeforeReadingsDateArabic;
    List<dynamic> beforeDateTimeList = oldBeforeDateTime;

    before.add(newRead);
    daysBefore.add(englishTime);
    beforeReadingsDateArabicList.add("$arabicDay $period $wa2t");
    beforeDateTimeList.add(dateTime);


    (await patientReadings()).set({
      'BeforeReadings': before,
      'Days_English_before': daysBefore,
      'BeforeReadingsDateArabic': beforeReadingsDateArabicList,
      'BeforeDateTime': beforeDateTimeList,
    }, SetOptions(merge: true));


    (await  patientUpdates()).set({
      'isHaveNewRead' : true,
      'lastRead' : newRead,
    }, SetOptions(merge: true));

  }
  void makePatientHasNewReadFalse({
    required String userID,
  }) async{

    (
        FirebaseFirestore.instance
            .collection('/doctors')
            .doc(UserSimplePreferencesDoctorID.getDrID())
            .collection('/patient')
            .doc(userID)
    ).set({
      'isHaveNewRead' : false,
    }, SetOptions(merge: true));
  }

  void updateHistoryOfPatient({
    required String userID,
    required String newHistory,
  }) async{

    (
        FirebaseFirestore.instance
            .collection('/doctors')
            .doc(UserSimplePreferencesDoctorID.getDrID())
            .collection('/patient')
            .doc(userID)
    ).set({
      'history' : newHistory,
    }, SetOptions(merge: true));
  }

  void writeReadingsAfter(
      {
        required double newRead,
        required String arabicDay,
        required String period,
        required String wa2t,
        required String englishDay,
        required List<dynamic> oldReadings,
        required List<dynamic> oldDays,
        required DateTime dateTime,
        required List<dynamic> oldAfterDateTime,
        required List<dynamic> oldAfterReadingsDateArabic,

      }) async {

    List<dynamic> after = oldReadings;
    List<dynamic> daysAfter = oldDays;
    List<dynamic> afterDateTimeList = oldAfterDateTime;
    List<dynamic> afterReadingsDateArabicList = oldAfterReadingsDateArabic;

    after.add(newRead);
    daysAfter.add(englishDay);
    afterDateTimeList.add(dateTime);
    afterReadingsDateArabicList.add("$arabicDay $period $wa2t");

    (await patientReadings()).set({
      'AfterReadings': after,
      'Days_English_after': daysAfter,
      'AfterReadingsDateArabic': afterReadingsDateArabicList,
      'AfterDateTime': afterDateTimeList,
    }, SetOptions(merge: true));


    (await  patientUpdates()).set({
      'isHaveNewRead' : true,
      'lastRead' : newRead,
    }, SetOptions(merge: true));

  }
}





class UserSimplePreferencesUser {
  static late SharedPreferences _preferences;
  static const _keyUsername = 'username1';
  static const _keyPaName = 'PaName';
  static const _keyLastOpen = 'lastOpen';
  static const _keyCtOfWeek = 'CtOfWeek';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setUserID(String uid) async =>
      await _preferences.setString(_keyUsername, uid);
  static Future setPaName(String name) async =>
      await _preferences.setString(_keyPaName, name);
  static Future setLastOpen(String lastOpen) async =>
      await _preferences.setString(_keyLastOpen, lastOpen);
  static Future setCtOfWeek(String ct) async =>
      await _preferences.setString(_keyCtOfWeek, ct);

  static String? getUserID() => _preferences.getString(_keyUsername);
  static String? getPaName() => _preferences.getString(_keyPaName);
  static String? getLastOpen() => _preferences.getString(_keyLastOpen);
  static String? getCtOfWeek() => _preferences.getString(_keyCtOfWeek);
}

class UserSimplePreferencesUserName {
  static late SharedPreferences _preferences;
  static const _keyUsername = 'username1';
  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();
  static Future setPaName(String username) async =>
      await _preferences.setString(_keyUsername, username);
  static String? getPaName() => _preferences.getString(_keyUsername);
}

class UserSimplePreferencesDoctorID {
  static late SharedPreferences _preferences;
  static const _keyUsername = 'id';
  static const _keyUserType = 'type';
    static const _keyDrName = 'PaName';
  static Future init() async => _preferences = await SharedPreferences.getInstance();
  static Future setDrID(String id) async =>await _preferences.setString(_keyUsername, id);
   static Future setDrName(String name) async => await _preferences.setString(_keyDrName, name);
   static Future setUserType(String type) async => await _preferences.setString(_keyUserType, type);

  static String? getDrID() => _preferences.getString(_keyUsername);
   static String? getDrName() => _preferences.getString(_keyDrName);
     static String? geUserType() => _preferences.getString(_keyUserType);


}


class UserSimplePreferencesTypeOfUser {
  static late SharedPreferences _preferences;

  static Future init() async => _preferences = await SharedPreferences.getInstance();

}