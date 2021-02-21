import 'dart:io';

import 'package:firebas_project/Models/Application.dart';
import 'package:firebas_project/Service/LastAppIdRepository.dart';
import 'package:firebas_project/Service/PhoneRepository.dart';
import 'package:firebas_project/Service/Server.dart';
import 'package:firebas_project/Service/repository.dart';
import 'package:firebas_project/UI/Widgets/customTextField.dart';
import 'package:firebas_project/providers/IssueProvider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../Models/User.dart';

class ApplicationInfoPage extends StatefulWidget {
  @override
  _ApplicationInfoPageState createState() => _ApplicationInfoPageState();
}

class _ApplicationInfoPageState extends State<ApplicationInfoPage> {
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

  File file;

  saveImageUrl(String imageurll) {
    this.imageUrl = imageurll;
  }

  savePhoneType(String phoneType1) {
    this.phoneType = phoneType1;
  }

  savePhineColor(String phineColor1) {
    this.phineColor = phineColor1;
  }

  saveContactNumber(String contactNumber1) {
    this.contactNumber = contactNumber1;
  }

  saveHardwareIssue(bool hardwareIssue1) {
    Provider.of<IssueProvider>(Get.context, listen: false)
        .setHasHardwareIssue(hardwareIssue1);
    this.hardwareIssue = Provider.of<IssueProvider>(Get.context, listen: false)
        .hashHardwareIssue;
  }

  saveSoftwareIssue(bool softwareIssue1) {
    Provider.of<IssueProvider>(Get.context, listen: false)
        .setHasSoftwareIssue(softwareIssue1);
    this.softwareIssue =
        Provider.of<IssueProvider>(Get.context, listen: false).hasSoftwareIssue;
  }

  savePrice(String price1) {
    this.price = price1;
  }

  savePhoneState(String phoneState1) {
    if (phoneState == 'application') {
      this.phoneState = status.application;
    } else if (phoneState == 'done') {
      this.phoneState = status.done;
    } else if (phoneState == 'delivered') {
      this.phoneState = status.delivered;
    } else {
      this.phoneState = status.notYet;
    }
  }

  saveUserNot(String userNote1) {
    this.userNote = userNote1;
  }

  saveSoftwareNote(String softwareNote1) {
    this.softwareNote = softwareNote1;
  }

  savehardwareNote(String shardwareNote1) {
    this.hardwareNote = shardwareNote1;
  }

  nullValidation(String value) {
    if (value == '') {
      return 'required field';
    }
  }

  GlobalKey<FormState> formKey = GlobalKey();

  saveForm() {
    getLastApplicationId();
    formKey.currentState.save();

    savePhone({
      "appID": LastAppIdRepository.repository.lastAppId += 1,
      'userId': PhoneRepository.repository.application.appID ?? "",
      'imageUrl':
          PhoneRepository.repository.application.imageUrl ?? this.imageUrl,
      'phoneType':
          PhoneRepository.repository.application.phoneType ?? this.phoneType,
      'phineColor':
          PhoneRepository.repository.application.phineColor ?? this.phineColor,
      'contactNumber': PhoneRepository.repository.application.contactNumber,
      'price': this.price ?? PhoneRepository.repository.application.price,
      'hardwareIssue': this.hardwareIssue ??
          PhoneRepository.repository.application.hardwareIssue,
      'softwareIssue': this.softwareIssue ??
          PhoneRepository.repository.application.softwareIssue,
      'userNote':
          this.userNote ?? PhoneRepository.repository.application.userNote,
      'softwareNote': this.softwareNote ??
          PhoneRepository.repository.application.softwareNote,
      'shardwareNote': this.hardwareNote ??
          PhoneRepository.repository.application.hardwareNote,
      'phoneState': "notYet",
      // 'phoneState':this.phoneState.toString().split('.').last ?? status.notYet.toString().split('.').last,
      'file': this.file
    });
    setLastApplicationId();

//removePhone(1);
    Fluttertoast.showToast(msg: "submited sucessfully");
  }

  bool enable = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Repository.repository.user.type == userType.customer) {
      enable = false;
    } else {
      enable = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("Phone info"),
        ),
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  GestureDetector(
                    // onTap: () async {
                    //   PickedFile pickedFile = await ImagePicker()
                    //       .getImage(source: ImageSource.gallery);
                    //   file = File(pickedFile.path);
                    //   setState(() {});
                    // },
                    child: Container(
                      height: 150,
                      width: 150,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: file == null
                            ? FlutterLogo()
                            : Image.file(
                                file,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  CustomTextField(
                    enable: PhoneRepository.repository.textFeaildEnable,
                    labelText:
                        'phone Type : ${PhoneRepository.repository.application.phoneType}',
                    saveFun: savePhoneType,
                    //validationFun: nullValidation,
                  ),
                  CustomTextField(
                    enable: PhoneRepository.repository.textFeaildEnable,
                    labelText:
                        'phine Color : ${PhoneRepository.repository.application.phineColor}',
                    saveFun: savePhineColor,
                    //validationFun: nullValidation,
                  ),
                  CustomTextField(
                    enable: PhoneRepository.repository.textFeaildEnable,
                    labelText:
                        'contact Number : ${PhoneRepository.repository.application.contactNumber}',
                    saveFun: saveContactNumber,
                    //validationFun: nullValidation,
                  ),

                  CustomTextField(
                    enable: PhoneRepository.repository.textFeaildEnable,
                    numberOfLine: 5,
                    labelText:
                        'User Note: ${PhoneRepository.repository.application.userNote}',
                    saveFun: saveUserNot,
                    //validationFun: nullValidation,
                  ),
                  enable == true
                      ? CustomChickBox(
                          title: "Hase a Hardware issue",
                          value:
                              Provider.of<IssueProvider>(context, listen: true)
                                      .hashHardwareIssue ??
                                  false,
                          saveValue: saveHardwareIssue,
                        )
                      : Container(),

                  enable == true
                      ? CustomChickBox(
                          title: "Hase a Software issue",
                          value:
                              Provider.of<IssueProvider>(context, listen: true)
                                      .hasSoftwareIssue ??
                                  false,
                          saveValue: saveSoftwareIssue,
                        )
                      : Container(),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    enable: Provider.of<IssueProvider>(context, listen: true)
                            .hashHardwareIssue ??
                        false,
                    numberOfLine: 5,
                    labelText:
                        'Software eng Note : ${PhoneRepository.repository.application.softwareNote}',
                    saveFun: saveSoftwareNote,
                    //      validationFun: nullValidation,
                  ),
                  CustomTextField(
                    enable: Provider.of<IssueProvider>(context, listen: true)
                            .hasSoftwareIssue ??
                        false,
                    numberOfLine: 5,
                    labelText:
                        'Hardware eng Note : : ${PhoneRepository.repository.application.hardwareNote}',
                    saveFun: savehardwareNote,
                    //  validationFun: nullValidation,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // Container(
                  //     alignment: Alignment.topLeft,
                  //     child: Text(
                  //       "Gender*",
                  //       textAlign: TextAlign.start,
                  //     )),
                  CustomContainer(
                    title: "Price",
                    value: "0.0",
                    saveFun: savePrice,
                    enable: enable,
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  CustomContainer(
                    title: "Status",
                    value:
                        "${PhoneRepository.repository.application.phoneState.toString().split(".").last}",
                    saveFun: savePhoneState,
                    //  validationFunction: nullValidation,
                    enable: enable,
                  ),
                  SizedBox(
                    height: 40,
                  ),

                  // todo

                  SizedBox(
                    height: 60,
                  ),
                  enable == true
                      ? Container(
                          height: 40,
                          width: double.infinity,
                          child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Text('Submit'),
                              onPressed: () async {
                                saveForm();

                                Get.back();
                              }),
                        )
                      : Container(),
                  SizedBox(
                    height: 60,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

class CustomContainer extends StatelessWidget {
  String title;
  String value;
  Function saveFun;
  bool enable;
  CustomContainer({this.title, this.value, this.saveFun, this.enable});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$title : ",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Container(
            width: 200,
            child: TextFormField(
              enabled: enable,
              //validator: (value) => validationFunction(value),
              decoration: InputDecoration(
                  hintText: "$value",
                  labelText: "$value",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
              onSaved: (value1) {
                saveFun(value1);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CustomChickBox extends StatelessWidget {
  String title;
  bool value;
  Function saveValue;
  CustomChickBox({this.title, this.value, this.saveValue});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Checkbox(
            value: value,
            onChanged: saveValue,
          ),
          Text('$title'),
        ],
      ),
    );
  }
}
