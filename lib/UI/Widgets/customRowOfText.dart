import 'package:firebas_project/utilities/CustomeTestStyle.dart';
import 'package:flutter/material.dart';

class CustomeRowOfText extends StatelessWidget {
  String title;
  String value;
  CustomeRowOfText({this.title, this.value});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$title',
            style: profileBoldStyle,
          ),
          Text(
            value,
            style: profileNormalStyle,
          )
        ],
      ),
    );
  }
}
