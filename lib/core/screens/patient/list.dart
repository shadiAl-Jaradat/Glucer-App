import 'package:flutter/material.dart';
 late String type_Di;
class DiabetesType extends StatefulWidget {
  String?  firstValue;
  DiabetesType({
    this.firstValue,
    Key? key}) : super(key: key);

  @override
  _DiabetesTypeState createState() {
    return _DiabetesTypeState();
  }
}

class _DiabetesTypeState extends State<DiabetesType> {
  String? _value;

  @override
  void initState() {
    if(widget.firstValue !=  null && widget.firstValue!.isNotEmpty){
      _value =  widget.firstValue!;
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: DropdownButtonFormField<String>(
        validator: (value) {
          if (value == null ||
              value.isEmpty) {
            return 'هذه الخانة مطلوبه';
          }
          else {
            _value = value;
            type_Di = value;
          }
        },
        // underline: Container(
        //   height: 1.5,
        //   color: Color.fromRGBO(178, 178, 178, 1),
        // ),
        isExpanded: true,
        items: const [
          DropdownMenuItem<String>(
            child: Text('السكري من النوع الأول'),
            value: '1',
          ),
          DropdownMenuItem<String>(
            child: Text('السكري من النوع الثاني'),
            value: '2',
          ),
        ],
        onChanged: (String? value) {
          setState(() {
            _value = value;
            //TODO: must change it
            type_Di = value!;
            // validator:
            // (value) => value == null ? 'Please fill in your gender' : null;
          });
        },
        hint: const Text('اختر نوع السكري'),
        value: _value,
      ),
    );
  }
}
