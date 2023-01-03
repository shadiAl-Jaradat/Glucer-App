import 'package:flutter/material.dart';
import 'package:new_3ala5er/core/screens/predictor/secondScreen.dart';


class BMIScreen extends StatefulWidget {
  const BMIScreen({Key? key}) : super(key: key);

  @override
  State<BMIScreen> createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  bool isMan = true ;
  double bmi = 0;


  final FocusNode _focusNodeAge = FocusNode();
  final FocusNode _focusNodeHeight = FocusNode();
  final FocusNode _focusNodeWeight = FocusNode();
  final FocusNode _focusNodeWaistline = FocusNode();


  final TextEditingController ageController = new TextEditingController();
  final TextEditingController heightController = new TextEditingController();
  final TextEditingController weightController = new TextEditingController();
  final TextEditingController waistlineController = new TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _focusNodeHeight.addListener(() {
      if (!_focusNodeHeight.hasFocus) {
        FocusScope.of(context).unfocus();
      }
    });
    _focusNodeWeight.addListener(() {
      if (!_focusNodeWeight.hasFocus) {
        FocusScope.of(context).unfocus();
      }
    });
    _focusNodeAge.addListener(() {
      if (!_focusNodeAge.hasFocus) {
        FocusScope.of(context).unfocus();
      }
    });

    _focusNodeWaistline.addListener(() {
      if (!_focusNodeWaistline.hasFocus) {
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
        title: Center(child: Text("فحص نسبة اصابة السكر       ", style: TextStyle(color: Colors.white),)),
      ),

      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          height: height,
          width: width,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              isMan = true;
                            });
                          },
                          child: SizedBox(
                            height: height * 0.2,
                            width: width * 0.2,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                side: BorderSide(color: isMan == true ?  Colors.white60 : Colors.white60 ,width: 2)
                              ),
                              color: isMan == true ?  Color.fromRGBO(194, 218, 203, 1) : Colors.white60,
                              child: Column(
                                children: [
                                  Icon(Icons.man_rounded, color: Colors.white,size: 100),
                                  Text("ذكر", style: TextStyle(fontSize: 25, color: Colors.white),),
                                ],
                              ),
                              ),
                          ),
                          ),

                        SizedBox(
                          width: width * 0.05,
                        ),

                        GestureDetector(
                          onTap: (){
                            setState(() {
                              isMan = false;
                            });
                          },
                          child: SizedBox(
                            height: height * 0.2,
                            width: width * 0.2,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  side: BorderSide(color: isMan == false ?  Colors.white60 : Colors.white60 ,width: 2)
                              ),
                              color: isMan ==  false ?  Color.fromRGBO(194, 218, 203, 1) : Colors.white60,
                              //child: Center(child: Icon(Icons.woman_rounded, color: Colors.white,size: 110)),
                              child: Column(
                                children: [
                                  Icon(Icons.woman_rounded,color: Colors.white,size: 100),
                                  Text("انثى", style: TextStyle(fontSize: 25, color: Colors.white),),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        focusNode: _focusNodeAge,
                        controller: ageController,
                        decoration: InputDecoration(
                          label: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Text("العمر",style: TextStyle(fontSize: 25),),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 3, color: Color.fromRGBO(194, 218, 203, 1)), //<-- SEE HERE
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
                            return "الرجاء ادخال العمر" ;
                          }
                          return null;
                        },
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        focusNode: _focusNodeHeight,
                        controller: heightController,
                        decoration: InputDecoration(
                          hintText: " XXX (سم)",
                          hintStyle: TextStyle(color: Colors.grey),
                          label: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Text("الطول",style: TextStyle(fontSize: 25),),
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
                            return "الرجاء ادخال الطول" ;
                          }
                          return null;
                        },
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        focusNode: _focusNodeWeight,
                        controller: weightController,
                        decoration: InputDecoration(
                          hintText: " XX.X (كغ)",
                          hintStyle: TextStyle(color: Colors.grey),
                          label: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Text("الوزن",style: TextStyle(fontSize: 25),),
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
                            return "الرجاء ادخال الوزن" ;
                          }
                          return null;
                        },
                      ),
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        focusNode: _focusNodeWaistline,
                        controller: waistlineController,
                        decoration: InputDecoration(
                          hintText: " XX.X (سم)",
                          hintStyle: TextStyle(color: Colors.grey),
                          label: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Text("محيط الخصر",style: TextStyle(fontSize: 25),),
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
                            return "الرجاء ادخال محيط الخصر " ;
                          }
                          return null;
                        },
                      ),
                    ),
                  ),

                  SizedBox(height: height * 0.01,),

                  SizedBox(
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
                          if(_formKey.currentState!.validate()){
                            double h = double.parse(heightController.text) / 100;
                            double w = double.parse(weightController.text);
                            bmi =  w / ( h*h);
                            String bmIinString = bmi.toStringAsFixed(2);
                            bmi = double.parse(bmIinString);

                            print("** bmi = $bmi");
                            print("** age = "+ ageController.text);
                            print("** waistline = " + waistlineController.text);
                            print("** isMan = " + isMan.toString());

                            Navigator.push( context,
                                MaterialPageRoute(
                                    builder: (context) => SecondScreen(
                                      age: double.parse(ageController.text),
                                      bmi: bmi,
                                      isMan: isMan,
                                      waistline: double.parse(waistlineController.text),
                                    )
                                )
                            );


                          }
                        },
                        child: Text(
                          'التالي ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              //Color.fromRGBO(91, 122, 128, 100),
                              fontSize: 25),
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
