import 'package:flutter/cupertino.dart';
import 'package:firebas_project/Models/User.dart';

class UserTypeProvider extends ChangeNotifier {
  String newuserType = "customer";
  userType curentUserType = userType.customer;
  setUserTypeValue(String userTypeValue) {
    this.newuserType = userTypeValue;
    if (userTypeValue == 'software') {
      curentUserType = userType.software;
    } else if (userTypeValue == 'hardware') {
      curentUserType = userType.hardware;
    } else {
      curentUserType = userType.customer;
    }
    notifyListeners();
  }
}
