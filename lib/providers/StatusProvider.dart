import 'package:firebas_project/Models/Application.dart';
import 'package:firebas_project/Models/Application.dart';
import 'package:firebas_project/Service/PhoneRepository.dart';
import 'package:flutter/cupertino.dart';

class StatusPageProvider extends ChangeNotifier {
  int isDeliverd = 0;

  setIsDeliverdValue(int isDeliverdValue) {
    this.isDeliverd = isDeliverdValue;
    notifyListeners();
  }

  getPhoneStatePhone() {
    if (isDeliverd == 1) {
       PhoneRepository.repository.application.phoneState= status.notYet;
    } else if (isDeliverd == 0) {
      PhoneRepository.repository.application.phoneState=  status.delivered;
    } else {
      PhoneRepository.repository.application.phoneState=  status.application;
    }
  }

  setStatusePhoneAsNumber() {
    if (PhoneRepository.repository.application.phoneState == status.notYet) {
      isDeliverd= 0;
    } else if (PhoneRepository.repository.application.phoneState ==
        status.delivered) {
      isDeliverd= 1;
    } else {
      return -1;
    }
  }
}
