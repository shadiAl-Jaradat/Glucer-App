import 'package:firebase_core/firebase_core.dart';
import '../doctor/regestrationDrPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import '../patient/patient_page.dart';
import '../doctor/regestrationDrPage.dart';
import '../usertype.dart';


double hi = 0.65;
bool check = false;
bool selected = false;
class OTPScreen extends StatefulWidget {
  late final String phone;
  OTPScreen(this.phone);
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
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
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
                      child: PinPut(
                        onTap: () => setState(() {
                          selected = true;
                        }),
                        onEditingComplete: () => setState(() {
                          selected = false;
                          FocusScope.of(context).requestFocus(new FocusNode());
                        }),

                        useNativeKeyboard: true,
                        autovalidateMode: AutovalidateMode.always,
                        withCursor: true,
                        fieldsCount: 6,
                        textStyle: TextStyle(
                            fontSize: 25.0, color: Color.fromRGBO(52, 91, 99, 1)),
                        eachFieldWidth: 50.0,
                        eachFieldHeight: 70.0,
                        focusNode: _pinPutFocusNode,
                        controller: _pinPutController,
                        submittedFieldDecoration: pinPutDecoration,
                        selectedFieldDecoration: pinPutDecoration,
                        followingFieldDecoration: pinPutDecoration,
                        pinAnimationType: PinAnimationType.fade,

                        onSubmit: (pin) async {
                          selected=false;

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
                                    print(check );

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
                                          builder: (context) => patient()),
                                          (route) => false);
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

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+962${widget.phone}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          print("Verifued");
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verficationID, [int? resendToken]) {
          setState(() {
            _verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(milliseconds: 50000));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _verifyPhone();
  }
  
}
