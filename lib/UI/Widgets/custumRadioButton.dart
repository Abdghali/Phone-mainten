import 'package:firebas_project/providers/GenderProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class CustomRadio extends StatelessWidget {
  String title;
  int value;
  CustomRadio({this.title, this.value});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio<int>(
          value: value,
          groupValue: Provider.of<GenderProvider>(context, listen: true).isMail,
          onChanged: (int value) {
            Provider.of<GenderProvider>(context, listen: false)
                .setIsMaleValue(value);
          },
        ),
        Text('$title'),
      ],
    );
  }
}