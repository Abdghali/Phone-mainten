import 'dart:io';
import 'package:firebas_project/Models/Application.dart';
import 'package:firebas_project/Service/LastAppIdRepository.dart';
import 'package:firebas_project/Service/Server.dart';
import 'package:firebas_project/Service/repository.dart';
import 'package:firebas_project/UI/Widgets/customTextField.dart';
import 'package:firebas_project/providers/IssueProvider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class AddApplicationPage extends StatefulWidget {
  @override
  _AddApplicationPageState createState() => _AddApplicationPageState();
}

class _AddApplicationPageState extends State<AddApplicationPage> {
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
    Provider.of<IssueProvider>(context, listen: false)
        .setHasHardwareIssue(hardwareIssue1);
    this.hardwareIssue =
        Provider.of<IssueProvider>(context, listen: false).hashHardwareIssue;
  }

  saveSoftwareIssue(bool softwareIssue1) {
    Provider.of<IssueProvider>(context, listen: false)
        .setHasSoftwareIssue(softwareIssue1);
    this.softwareIssue =
        Provider.of<IssueProvider>(context, listen: false).hasSoftwareIssue;
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
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
       getLastApplicationId();
       Logger().e(LastAppIdRepository.repository.lastAppId);
      saveApplication({
        'appID': '${LastAppIdRepository.repository.lastAppId+=1}',
        'userId': Repository.repository.user.id,
        'imageUrl': this.imageUrl,
        'phoneType': this.phoneType,
        'phineColor': this.phineColor,
        'contactNumber': this.contactNumber,
        'price': this.price,
        'hardwareIssue': this.hardwareIssue ?? false,
        'softwareIssue': this.softwareIssue ?? false,
        'userNote': this.userNote,
        'softwareNote': this.softwareNote,
        'shardwareNote': this.hardwareNote,
        'phoneState': status.application.toString().split('.').last,
        // 'phoneState':this.phoneState.toString().split('.').last ?? status.notYet.toString().split('.').last,
        'file': this.file
      });
      setLastApplicationId();
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("Apply application"),
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
                    onTap: () async {
                      PickedFile pickedFile = await ImagePicker()
                          .getImage(source: ImageSource.gallery);
                      file = File(pickedFile.path);
                      setState(() {});
                    },
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
                    labelText: 'phone Type',
                    saveFun: savePhoneType,
                    validationFun: nullValidation,
                  ),
                  CustomTextField(
                    labelText: 'phine Color',
                    saveFun: savePhineColor,
                    validationFun: nullValidation,
                  ),
                  CustomTextField(
                    labelText: 'contact Number',
                    saveFun: saveContactNumber,
                    validationFun: nullValidation,
                  ),

                  CustomTextField(
                    numberOfLine: 5,
                    labelText: 'User Note',
                    saveFun: saveUserNot,
                    validationFun: nullValidation,
                  ),
                  CustomTextField(
                    enable: softwareIssue,
                    numberOfLine: 5,
                    labelText: 'Software eng Note',
                    saveFun: saveSoftwareNote,
                    validationFun: nullValidation,
                  ),
                  CustomTextField(
                    enable: hardwareIssue,
                    numberOfLine: 5,
                    labelText: 'Hardware eng Note',
                    saveFun: savehardwareNote,
                    validationFun: nullValidation,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Gender*",
                        textAlign: TextAlign.start,
                      )),
                  CustomContainer(
                    title: "Price",
                    value: "0.0",
                    saveFun: savePrice,
                    // validationFunction: nullValidation,
                    enable: false,
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  CustomContainer(
                      title: "Status",
                      value: "Not yet",
                      saveFun: savePhoneState,
                      //   validationFunction: nullValidation,
                      enable: false),
                  SizedBox(
                    height: 40,
                  ),

                  // todo

                  CustomChickBox(
                    title: "Hase a Software issue",
                    value: Provider.of<IssueProvider>(context, listen: true)
                            .hasSoftwareIssue ??
                        false,
                    saveValue: saveSoftwareIssue,
                  ),
                  CustomChickBox(
                    title: "Hase a Hardware issue",
                    value: Provider.of<IssueProvider>(context, listen: true)
                            .hashHardwareIssue ??
                        false,
                    saveValue: saveHardwareIssue,
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Container(
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
                  ),
                  SizedBox(
                    height: 60,
                  ),
                ],
              ),
            ),
          ),
        )
        
        );
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
