import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:new_3ala5er/core/screens/patient/bar.dart';
import 'package:new_3ala5er/core/service/firebase.service.dart';
import 'package:pinput/pinput.dart';
import '../doctor/regestrationDrPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../patient/patient_page.dart';
import '../doctor/regestrationDrPage.dart';
import '../usertype.dart';


double hi = 0.65;
bool check = false;
bool selected = false;
class OTPScreen extends StatefulWidget {
  late final String phone;
  String? drID;
  OTPScreen({required this.phone , this.drID});
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  late String _verificationCode;
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  //get pinPutDecoration => null;
  BoxDecoration get pinPutDecoration {
    return BoxDecoration(
      color: Color.fromRGBO(196, 196, 196, 0.26),
      borderRadius: BorderRadius.circular(15.0),
    );
  }
  //bool get cho => cho;



  @override
  void initState() {
    _verifyPhone();
    super.initState();
  }

  _verifyPhone() async {

    FirebaseAuth _auth = FirebaseAuth.instance;

    await _auth.verifyPhoneNumber(
        phoneNumber: '+962${widget.phone}',
        timeout: Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          print("Verified");
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verificationID, [int? resendToken]) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
    );

    // await FirebaseAuth.instance.verifyPhoneNumber(
    //     phoneNumber: '+962${widget.phone}',
    //     verificationCompleted: (PhoneAuthCredential credential) async {
    //       print("Verified");
    //     },
    //     verificationFailed: (FirebaseAuthException e) {
    //       print(e.message);
    //     },
    //     codeSent: (String verficationID, [int? resendToken]) {
    //       setState(() {
    //         _verificationCode = verficationID;
    //       });
    //     },
    //     codeAutoRetrievalTimeout: (String verificationID) {
    //       setState(() {
    //         _verificationCode = verificationID;
    //       });
    //     },
    //     timeout: Duration(milliseconds: 200000));
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(189, 208, 201, 1),
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/gradient.png"), fit: BoxFit.cover)),
        child: Align(
          alignment: Alignment.bottomLeft,
            child: GestureDetector(
              onTap: () {
                if (selected == true ) selected=false;
                FocusManager.instance.primaryFocus?.unfocus();
              },
              onTapCancel:() {
                if (selected == true ) selected=false;
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 330),
                curve: Curves.linear,
                width: double.infinity,
                height: selected ? screenHeight * 0.9 : screenHeight * 0.68,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0)),
                ),
                child: Column(
                  children: [
                    ///1
                    Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: Row(
                        children: const [
                          Expanded(
                            flex: 1,
                            child: Divider(
                              color: Colors.grey,
                              indent: 30,
                              endIndent: 15,
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: Center(
                                  child: Text(
                                'رمز التحقق',
                                style: TextStyle(
                                    fontSize: 30,
                                    color: Color.fromRGBO(189, 208, 201, 1)),
                              ))),
                          Expanded(
                            flex: 1,
                            child: Divider(
                              color: Colors.grey,
                              indent: 15,
                              endIndent: 30,
                            ),
                          ),
                        ],
                      ),
                    ),

                    ///2
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Center(
                        child: Text(
                          //+962-${widget.phone}
                          "لقد تم ارسال رمز التحقق الى ",
                          style: TextStyle(
                              color: Color.fromRGBO(134, 138, 139, 1),
                              fontSize: 20),
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Center(
                        child: Text(
                          '${widget.phone}',
                          style: TextStyle(
                              color: Color.fromRGBO(134, 138, 139, 1),
                              fontSize: 20),
                        ),
                      ),
                    ),


                    SizedBox(
                      height: 20,
                    ),


                    Padding(
                      padding: EdgeInsets.all(30.0),
                      // child: Pinput(
                      //     onTap: () => setState(() {
                      //       selected = true;
                      //     }),
                      //
                      //     onCompleted: (pin){
                      //       setState(() {
                      //         selected = false;
                      //         FocusScope.of(context).requestFocus(new FocusNode());
                      //       });
                      //     },
                      //
                      //   defaultPinTheme : PinTheme(
                      //     width: 56,
                      //     height: 70,
                      //     textStyle: TextStyle(fontSize: 25, color: Color.fromRGBO(52, 91, 99, 1), fontWeight: FontWeight.w600),
                      //     decoration: BoxDecoration(
                      //       border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
                      //       borderRadius: BorderRadius.circular(20),
                      //     ),
                      //   ),
                      //
                      //   // onEditingComplete: () => setState(() {
                      //   //   selected = false;
                      //   //   FocusScope.of(context).requestFocus(new FocusNode());
                      //   // }),
                      //
                      //   useNativeKeyboard: true,
                      //   validator: (value) {
                      //     if(value!.length < 6){
                      //       return "length less than 6";
                      //     }
                      //     return null;
                      //   },
                      //
                      //   pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                      //   //autovalidateMode: AutovalidateMode.always,
                      //
                      //   //withCursor: true,
                      //
                      //   //fieldsCount: 6,
                      //   length: 6,
                      //
                      //   //textStyle: TextStyle(fontSize: 25.0, color: Color.fromRGBO(52, 91, 99, 1)),
                      //
                      //   // eachFieldWidth: 50.0,
                      //   // eachFieldHeight: 70.0,
                      //   focusNode: _pinPutFocusNode,
                      //   controller: _pinPutController,
                      //
                      //   submittedPinTheme: PinTheme(
                      //     decoration: BoxDecoration(
                      //       color: Color.fromRGBO(196, 196, 196, 0.26),
                      //       borderRadius: BorderRadius.circular(15.0),
                      //     ),
                      //   ),
                      //
                      //   followingPinTheme: PinTheme(
                      //     decoration: BoxDecoration(
                      //       color: Color.fromRGBO(196, 196, 196, 0.26),
                      //       borderRadius: BorderRadius.circular(15.0),
                      //     ),
                      //   ),
                      //
                      //   //selectedFieldDecoration: pinPutDecoration,
                      //   pinAnimationType: PinAnimationType.fade,
                      //
                      //   onSubmitted: (pin) async {
                      //     selected=false;
                      //   },
                      //
                      //   // onSubmit: (pin) async {
                      //   //   selected=false;
                      //   // },
                      // ),
                      child: Pinput(
                        controller: _pinPutController,
                        length: 6,
                        onCompleted: (pin) {
                          print(pin);
                          selected=false;
                          FocusScope.of(context).requestFocus(new FocusNode());
                        },

                      ),
                    ),
                    SizedBox(
                      height: 55,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: const Color.fromRGBO(189, 208, 201, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                            minimumSize: const Size(140, 40),
                          ),
                          onPressed: () async{

                            try {
                              //here we check if the code enterd by the user the same one that was sent from firebase

                              print("------${_pinPutController.text}");
                              print("------${_verificationCode}");

                              await FirebaseAuth.instance
                                  .signInWithCredential(
                                  PhoneAuthProvider.credential(
                                      verificationId: _verificationCode,
                                      smsCode: _pinPutController.text))
                                  .then((value) async {
                                    print("Arrivced");
                                    print(value.user?.uid);
                                    print(check);
                                    if(widget.drID != null){
                                      await UserSimplePreferencesUser.setUserID(value.user!.uid);
                                      await UserSimplePreferencesDoctorID.setDrID(widget.drID!);
                                      await UserSimplePreferencesDoctorID.setUserType('Pa');
                                      await UserSimplePreferencesUser.setCtOfWeek('0');
                                      await UserSimplePreferencesUser.setLastOpen(DateTime.now().toString());

                                      DocumentSnapshot<Map<String, dynamic>> dd  = await FirebaseFirestore.instance
                                                .collection('/doctors')
                                                .doc(widget.drID)
                                                .collection('/patient')
                                                .doc(value.user!.uid)
                                                .get();

                                      Map<String, dynamic> data = dd.data() as Map<String, dynamic>;

                                      print("&&&&&&& name : ${data['Name']}");

                                      await UserSimplePreferencesUser.setPaName(data['Name']);
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => barhome()),
                                              (route) => false
                                      );
                                    }
                                    else {
                                      await UserSimplePreferencesUser.setUserID(value.user!.uid);

                                      await UserSimplePreferencesDoctorID.setUserType('Pa');
                                      if (value.user?.uid != null  && choice == true) {
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => doctor()),
                                                (route) => false);
                                      }else if(value.user?.uid != null  && choice  == false){
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => RegistrationPatientPage(phone: widget.phone)),
                                                (route) => false);
                                      }
                                    }
                              });
                            } catch (e) {
                              showDialog<String>(context: context, builder: (BuildContextcontext) =>
                                  AlertDialog(
                                    title:
                                    const Text(
                                        'ERROR'),
                                    content: const Text(
                                        'الرقم الذي ادخلته خاطئ  , الرجاء اعادة ادخال الرقم '),
                                    actions: <
                                        Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(
                                                context,
                                                'OK'),
                                        child:
                                        const Text(
                                            'OK'),
                                      ),
                                    ],
                                  ),
                              );
                            }
                          },
                          child: const Text(
                            'التالي',
                            style: TextStyle(fontSize: 22),
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5.0),
                      child: Center(
                        child: TextButton(
                          onPressed: () {
                            // print("---------------");
                            // print(_verificationCode);
                          },
                          child: const Text(
                            "اعد ارسال الرمز",
                            style: TextStyle(
                                color: Color.fromRGBO(189, 208, 201, 1),
                                fontSize: 16,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
    );
  }




}
