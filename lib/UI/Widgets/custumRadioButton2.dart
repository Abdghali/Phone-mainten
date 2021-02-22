import 'package:firebas_project/providers/GenderProvider.dart';
import 'package:firebas_project/providers/StatusProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class CustomRadio2 extends StatelessWidget {
  String title;
  int value;
  CustomRadio2({this.title, this.value});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio<int>(
          value: value,
          groupValue: Provider.of<StatusPageProvider>(context, listen: true).isDeliverd,
          onChanged: (int value) {
            Provider.of<StatusPageProvider>(context, listen: false)
                .setIsDeliverdValue(value);
          },
        ),
        Text('$title'),
      ],
    );
  }
}