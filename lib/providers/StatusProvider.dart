import 'package:firebas_project/Models/Application.dart';
import 'package:firebas_project/Models/Application.dart';
import 'package:flutter/cupertino.dart';

class StatusProvider extends ChangeNotifier {
  int isApplication=0;
  int isNotYte=0;
  int isDeliverd=0;

  setisApplicationalue(int iisApplicationValue) {
    this.isApplication = iisApplicationValue;
    notifyListeners();
  }
   setisIsNotYteValue(int isNotYteValue) {
    this.isNotYte = isNotYteValue;
    notifyListeners();
  }
   setisIsDeliverdValue(int isDeliverdValue) {
    this.isDeliverd = isDeliverdValue;
    notifyListeners();
  }
 
}
