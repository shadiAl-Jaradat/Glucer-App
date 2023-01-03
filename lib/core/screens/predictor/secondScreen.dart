import 'package:flutter/material.dart';
import 'package:new_3ala5er/core/screens/predictor/resultScreen.dart';


class SecondScreen extends StatefulWidget {
  double bmi;
  bool isMan;
  double waistline;
  double age;
  SecondScreen({
    required this.age,
    required this.bmi,
    required this.isMan,
    required this.waistline,
    Key? key
  }) : super(key: key);

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {


  final FocusNode _focusFastFood = FocusNode();

  final TextEditingController fastFoodController = new TextEditingController();

  final _formKey = GlobalKey<FormState>();

  int _selectedOptionSport = 0;
  int _selectedOptionSmoke = 0;
  int _selectedOptionAlcohol = 0;
  int _selectedOptionFruits = 0;


  @override
  void initState() {
    _focusFastFood.addListener(() {
      if (!_focusFastFood.hasFocus) {
        FocusScope.of(context).unfocus();
      }
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    double height =  MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(194, 218, 203, 1) ,
        title: Center(child: Text("فحص نسبة اصابة السكر - ٢       ", style: TextStyle(color: Colors.white),)),
      ),

      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            height: height,
            width: width,
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: height * 0.03,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 20,right: 20.0),
                      child: Text(
                        " كم مرة تمارس الرياضة في الاسبوع ؟",
                        style: TextStyle(fontSize: 23 , color: Color.fromRGBO(91, 122, 128, 1)),
                      ),
                    ),

                    RadioListTile(
                      title: Text('مطلقا'),
                      value: 1,
                      groupValue: _selectedOptionSport,
                      onChanged: (value) {
                        setState(() {
                          _selectedOptionSport = value as int;
                        });
                      },
                    ),
                    RadioListTile(
                      title: Text('١ - ٢ مرة'),
                      value: 2,
                      groupValue: _selectedOptionSport,
                      onChanged: (value) {
                        setState(() {
                          _selectedOptionSport = value as int;
                        });
                      },
                    ),
                    RadioListTile(
                      title: Text('٣ - ٤ مرات '),
                      value: 3,
                      groupValue: _selectedOptionSport,
                      onChanged: (value) {
                        setState(() {
                          _selectedOptionSport = value as int;
                        });
                      },
                    ),
                    RadioListTile(
                      title: Text('٥ مرات او اكثر'),
                      value: 4,
                      groupValue: _selectedOptionSport,
                      onChanged: (value) {
                        setState(() {
                           _selectedOptionSport = value as int;
                        });
                      },
                    ),


                    Padding(
                      padding: const EdgeInsets.only(top: 30,right: 20.0),
                      child: Text(
                        " هل دخنت سابقا ؟",
                        style: TextStyle(fontSize: 23, color: Color.fromRGBO(91, 122, 128, 1)),
                      ),
                    ),

                    RadioListTile(
                      title: Text('نعم'),
                      value: 1,
                      groupValue: _selectedOptionSmoke,
                      onChanged: (value) {
                        setState(() {
                          _selectedOptionSmoke = value as int;
                        });
                      },
                    ),
                    RadioListTile(
                      title: Text('لا'),
                      value: 2,
                      groupValue: _selectedOptionSmoke,
                      onChanged: (value) {
                        setState(() {
                          _selectedOptionSmoke = value as int;
                        });
                      },
                    ),



                    Padding(
                      padding: const EdgeInsets.only(top: 30,right: 20.0),
                      child: Text(
                        " هل شربت الكحول سابقا ؟",
                        style: TextStyle(fontSize: 23, color: Color.fromRGBO(91, 122, 128, 1)),
                      ),
                    ),

                    RadioListTile(
                      title: Text('نعم'),
                      value: 1,
                      groupValue: _selectedOptionAlcohol,
                      onChanged: (value) {
                        setState(() {
                          _selectedOptionAlcohol = value as int;
                        });
                      },
                    ),
                    RadioListTile(
                      title: Text('لا'),
                      value: 2,
                      groupValue: _selectedOptionAlcohol,
                      onChanged: (value) {
                        setState(() {
                          _selectedOptionAlcohol = value as int;
                        });
                      },
                    ),




                    Padding(
                      padding: const EdgeInsets.only(top: 30,right: 20.0),
                      child: Text(
                        " هل تأكل فاكهة واحدة عالاقل في اليوم  ؟",
                        style: TextStyle(fontSize: 23, color: Color.fromRGBO(91, 122, 128, 1)),
                      ),
                    ),

                    RadioListTile(
                      title: Text('نعم'),
                      value: 1,
                      groupValue: _selectedOptionFruits,
                      onChanged: (value) {
                        setState(() {
                          _selectedOptionFruits = value as int;
                        });
                      },
                    ),
                    RadioListTile(
                      title: Text('لا'),
                      value: 2,
                      groupValue: _selectedOptionFruits,
                      onChanged: (value) {
                        setState(() {
                          _selectedOptionFruits = value as int;
                        });
                      },
                    ),


                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          focusNode: _focusFastFood,
                          controller: fastFoodController,
                          decoration: InputDecoration(
                            label: Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Text("كم عدد الوجبات السريعة التي تتناولها في اليوم ",style: TextStyle(fontSize: 18),),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(width: 3, color: Color.fromRGBO(194, 218, 203, 1) ), //<-- SEE HERE
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder:  OutlineInputBorder(
                              borderSide: BorderSide(width: 3, color: Color.fromRGBO(194, 218, 203, 1) ), //<-- SEE HERE
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 3, color: Color.fromRGBO(194, 218, 203, 1) ), //<-- SEE HERE
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          validator: (value){
                            if(value!.isEmpty ||  value == null){
                              return "الرجاء ادخال رقم " ;
                            }
                            return null;
                          },
                        ),
                      ),
                    ),

                    SizedBox(height: height * 0.01,),

                    Center(
                      child: SizedBox(
                        width: width * 0.4,
                        height: height * 0.07,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: const Color.fromRGBO(194, 218, 203, 1),
                              elevation: 0.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(16))),
                          onPressed: () {
                            Navigator.push( context,
                                MaterialPageRoute(
                                    builder: (context) => ResultScreen(),
                                )
                            );

                          },
                          child: Text(
                            'النتيجة ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                //Color.fromRGBO(91, 122, 128, 100),
                                fontSize: 25),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: height * 0.075,),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
