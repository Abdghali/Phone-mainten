
import 'package:flutter/material.dart';
class CustomeProfileTextFeaild extends StatelessWidget {
String title;
String value;
Function fun;
CustomeProfileTextFeaild({this.title,this.value,this.fun});
  @override
  Widget build(BuildContext context) {
    return Container(
      child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(flex: 1, child: Text('$title')),
                  Expanded(
                      flex: 4,
                      child: TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                        initialValue: value,
                        onChanged:fun,
                      ))
                ],
              ),
    );
  }
}