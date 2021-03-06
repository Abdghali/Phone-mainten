import 'package:logger/logger.dart';

enum status { application, notYet, done, delivered }

class Application {
  String appID;
  String userId;
  String imageUrl;
  String phoneType;
  String phineColor;
  String contactNumber;
  status phoneState;
  String price;
  bool hardwareIssue;
  bool softwareIssue;
  String userNote;
  String softwareNote;
  String hardwareNote;

  Application(
      {
        this.appID,
        this.userId,
      this.contactNumber,
      this.hardwareIssue,
      this.imageUrl,
      this.hardwareNote,
      this.phineColor,
      this.phoneState,
      this.phoneType,
      this.price,
      this.softwareIssue,
      this.softwareNote,
      this.userNote});
      
  Application.fromMap(Map map) {
    // Logger().e(map);
    this.appID = map['appID'];
    this.userId = map['userId'];
    this.imageUrl = map['imageUrl'];
    this.phoneType = map['phoneType'];
    this.phineColor = map['phineColor'];
    this.contactNumber = map['contactNumber'];
    this.price = map['price'];
    this.hardwareIssue = map['hardwareIssue'];
    this.softwareIssue = map['softwareIssue'];
    this.userNote = map['userNote'];
    this.softwareNote = map['softwareNote'];
    this.hardwareNote = map['hardwareNote'];
    this.phoneState = map['phoneState'] == 'application'
        ? status.application
        : map['phoneState'] == 'done'
            ? status.done
            : map['phoneState'] == 'delivered'
                ? status.delivered
                : status.notYet;
  }

  toJson() {
    return {
      'appID': this.appID,
      'imageUrl': this.imageUrl,
      'phoneType': this.phoneType,
      'phineColor': this.phineColor,
      'contactNumber': this.contactNumber,
      'price': this.price,
      'hardwareIssue': this.hardwareIssue,
      'softwareIssue': this.softwareIssue,
      'userNote': this.userNote,
      'softwareNote': this.softwareNote,
      'hardwareNote': this.hardwareNote,
      'phoneState': this.phoneState.toString()
    };
  }
}
