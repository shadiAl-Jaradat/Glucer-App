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
  double sportValue =1;

  int _selectedOptionSmoke = 0;
  double smokeValue = 1;

  int _selectedOptionAlcohol = 0;
  double alcoholValue = 1;

  int _selectedOptionFruits = 0;
  double fruitsValue =1;


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
            child: Scrollbar(
              controller: ScrollController(),
              thumbVisibility: true,
              thickness: 8,
              radius: Radius.circular(20),
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
                            sportValue = 1;
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
                            sportValue = 1.15;
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
                            sportValue = 1.32;
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
                             sportValue = 1.39;
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
                             smokeValue = 1.37;
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
                            smokeValue = 1;
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
                            alcoholValue = 1-0.18;
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
                            alcoholValue = 1;
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
                            fruitsValue =1-0.1;
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
                            fruitsValue =1;
                          });
                        },
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 30,right: 20.0),
                        child: Text(
                          " كم عدد الوجبات السريعة التي تتناولها في اليوم ؟",
                          style: TextStyle(fontSize: 23, color: Color.fromRGBO(91, 122, 128, 1)),
                        ),
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


                              print("result :  ");

                              print(widget.isMan ? "الجنس : ذكر  " : " الجنس : انثى ");

                              print("  : محيط الخصر  ${widget.waistline} ");

                              double waistValue = 1;
                              if(widget.isMan && widget.waistline <= 40) waistValue =1;
                              else if(widget.isMan && widget.waistline > 40){
                                double temp =   widget.waistline - 40;
                                int roundedTemp = (temp).ceil();
                                waistValue = roundedTemp * 1.1;
                              }
                              else if (widget.isMan == false && widget.waistline <= 35) waistValue =1;
                              else {
                                double temp =   widget.waistline - 35;
                                int roundedTemp = (temp).ceil();
                                waistValue = roundedTemp * 1.1;
                              }

                              print("  :  تأثير محيط الخصر  $waistValue ");


                              print("bmi :  ${widget.bmi}");

                              double bmiValue = 1;
                              if(widget.bmi < 25) bmiValue =1 ;
                              else {
                                double temp =   widget.bmi - 25;
                                int roundedTemp = (temp).ceil();
                                bmiValue = roundedTemp * 1.72;
                              }
                              print("bmi تأثير :  $bmiValue ");

                              print("  : تأثير الرياضة $sportValue ");

                              print("  : تأثير الدخان $smokeValue ");

                              print("  : تأثير الكحول $alcoholValue ");

                              print("  : تأثير الفواكه $fruitsValue ");

                              double fastFoodValue = 1;

                              if(fastFoodController.text.isEmpty || fastFoodController.text == null) fastFoodController.text = "0";

                              double tempFastFood = double.parse(fastFoodController.text);
                              if(tempFastFood == 0) fastFoodValue =1;
                              else fastFoodValue = fastFoodValue * 1.3;

                              print("  : تأثير الوجبات السريعة $fastFoodValue ");


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
      ),
    );
  }
}
