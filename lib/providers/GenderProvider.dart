import 'package:flutter/cupertino.dart';

class GenderProvider extends ChangeNotifier {
  int isMail=0;
  setIsMaleValue(int isNaleValue) {
    this.isMail = isNaleValue;
    notifyListeners();
  }
}
