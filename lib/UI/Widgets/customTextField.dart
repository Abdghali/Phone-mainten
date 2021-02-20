import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  Function validationFun;
  Function saveFun;
  String labelText;
  int numberOfLine;
  bool enable;
  CustomTextField({this.labelText, this.saveFun, this.validationFun,this.numberOfLine,this.enable});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        TextFormField(
          enabled:enable ,
          keyboardType: TextInputType.multiline,
          minLines: 1, //Normal textInputField will be displayed
          maxLines: numberOfLine??1,
          validator: (value) => validationFun(value),
          decoration: InputDecoration(
              labelText: labelText,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
          onSaved: (value) {
            saveFun(value);
          },
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
