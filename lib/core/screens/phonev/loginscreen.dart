import 'package:flutter/material.dart';
import 'otp.dart';


bool selected = false;
late TextEditingController phnum;
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _controller = TextEditingController();
  final _controllerDrID = TextEditingController();
  bool newAccount = false;

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
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: Row(
                        children: const [
                          Expanded(
                            flex: 1,
                            child: Divider(
                              color: Colors.grey,
                              indent: 15,
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
                              endIndent: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 50.0),
                      child: Text(
                        "ادخل رقم الهاتف",
                        style: TextStyle(
                          color: Color.fromRGBO(117, 121, 122, 1),
                          fontSize: 22,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0, left: 8),
                      child: Text(
                        "سيتم ارسال رمز سري يستخدم لمرة واحدة فقط",
                        style: TextStyle(
                            color: Color.fromRGBO(134, 138, 139, 1),
                            fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 1,
                              child: Column(children: const [
                                Text(
                                  '+962',
                                  style: TextStyle(
                                    fontSize: 23,
                                    color: Color.fromRGBO(117, 121, 122, 1),
                                  ),
                                ),
                              ])),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: EdgeInsets.only(right: 50.0),
                              child: TextField(
                                style: TextStyle(fontSize: 22),
                                onTap: () => setState(() { selected = true; }),
                                onEditingComplete: () => setState(() {
                                  selected = false;
                                  FocusScope.of(context).requestFocus(new FocusNode());
                                  //FocusScope.of(context).requestFocus(new FocusNode());
                                }),
                                controller: _controller,
                                decoration: InputDecoration(
                                  isCollapsed: true,
                                  hintText: "7XXXXXXXX",
                                  hintStyle: TextStyle(
                                      color: Color.fromRGBO(117, 121, 122, .27)),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(189, 208, 201, 1)),
                                  ),
                                ),
                                maxLength: 9,
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),


                    newAccount == false ?
                    const Padding(
                      padding: EdgeInsets.only(top: 20.0,bottom: 20),
                      child: Text(
                        "ادخل رمز طبيبك ",
                        style: TextStyle(
                          color: Color.fromRGBO(117, 121, 122, 1),
                          fontSize: 22,
                        ),
                      ),
                    )
                    : Container(),

                    newAccount == false ?
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 150.0),
                      child: TextField(
                        style: TextStyle(fontSize: 22),
                        onTap: () => setState(() { selected = true; }),
                        onEditingComplete: () => setState(() {
                          selected = false;
                          FocusScope.of(context).requestFocus(new FocusNode());
                          //FocusScope.of(context).requestFocus(new FocusNode());
                        }),
                        controller: _controllerDrID,
                        decoration: InputDecoration(
                          isCollapsed: true,
                          hintText: "ABC00",
                          hintStyle: TextStyle(
                              color: Color.fromRGBO(117, 121, 122, .27)),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(189, 208, 201, 1)),
                          ),
                        ),
                        maxLength: 5,
                        keyboardType: TextInputType.text,
                      ),
                    )
                    :Container(),


                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              onPressed: (){
                                setState(() {
                                  newAccount = true;
                                });
                              },
                              child: Text("انشاء حساب جديد ")
                          ),

                          TextButton(
                              onPressed: (){
                                setState(() {
                                  newAccount = false;
                                });
                              },
                              child: Text("لدي حساب قديم ")
                          ),
                        ],
                      ),
                    ),




                    Padding(
                      padding: const EdgeInsets.only(top: 60.0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: const Color.fromRGBO(189, 208, 201, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                            minimumSize: const Size(274, 41),
                          ),
                          onPressed: () {
                            String ss = _controller.text.toString();
                            if (ss.length == 9) {
                              if(newAccount == true)
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => OTPScreen(phone: _controller.text)));
                              else
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => OTPScreen(phone: _controller.text , drID: _controllerDrID.text,)));

                            } else {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('ERROR'),
                                  content: const Text(
                                      'الرقم قصير , الرجاء اعادة ادخال الرقم '),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'OK'),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                          child: const Text(
                            'ارسل الرمز',
                            style: TextStyle(fontSize: 22),
                          )),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
//
//   @override
// void initState() {
//   hi=0.92;
// }
}
