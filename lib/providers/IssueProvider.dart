import 'package:flutter/material.dart';
class IssueProvider extends ChangeNotifier {
  bool hasSoftwareIssue=false;
  bool hashHardwareIssue=false;



  setHasSoftwareIssue(bool hasSoftwareIssueVal) {
    this.hasSoftwareIssue = hasSoftwareIssueVal;
    notifyListeners();
  }
   setHasHardwareIssue(bool hashHardwareIssueVal) {
    this.hashHardwareIssue = hashHardwareIssueVal;
    notifyListeners();
  }
}
