import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';




class LabsOfPatient extends StatefulWidget {
  final String patientID;
  final List<String> labsPaths;
  const LabsOfPatient({
    required this.patientID,
    required this.labsPaths,
    Key? key
  }) : super(key: key);

  @override
  State<LabsOfPatient> createState() => _LabsOfPatientState();
}

class _LabsOfPatientState extends State<LabsOfPatient> {


  // @override
  // void initState() {
  //   super.initState();
  // }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(235,240,240,1),
        iconTheme: IconThemeData(
        color: Color.fromRGBO(54, 93,100,1), // <-- SEE HERE
        ),
        title: Center(child: Text("المختبرات          " ,  style: TextStyle(color: Color.fromRGBO(54, 93,100,1),),)),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 30),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: GridView.count(
            crossAxisCount: 2,
            children: List.generate(widget.labsPaths.length, (index) {
              return createCardFile(widget.labsPaths[index], index);
            }),
          ),
        ),
      ),
    );
  }


  Widget createCardFile(String path , index) {
    //String? ext = Plt_file.extension;

    return InkWell(
      onTap: () => OpenFile.open(path),
      child: Padding(
        padding: const EdgeInsets.only(top: 10, right: 5, left: 5),
        child: Container(
          //color: Color.fromRGBO(218, 228, 229, 1),
          height: 141,
          width: 114,
          decoration: BoxDecoration(
            color: Color.fromRGBO(218, 228, 229, 1),
            borderRadius: BorderRadius.all(Radius.circular(14)),
            //border: Colors.black,
            border: Border.all(
              color: Color.fromRGBO(218, 228, 229, 1),
              width: 2,
            ),
          ),
          child: Card(
            elevation: 0,
            color: Color.fromRGBO(218, 228, 229, 1),
            //shape: RoundedRectangleBorder( Radius.circular(14)),
            child: Column(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Image(
                      image: AssetImage('images/lab.png'),
                      width: 70,
                      height: 90,
                    )),

                //TODO: change الاول to a number based on number of labs entered
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 3.0),
                    child: Text(
                      ' المختبر \n' + '${index+1}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(91, 122, 129, 1), fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),

                // PDFViewer(document: widget.document));
              ],
            ),
          ),
        ),
      ),
    );
  }
}
