import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebas_project/Models/User.dart';
import 'package:firebas_project/Service/Server.dart';
import 'package:firebas_project/Service/repository.dart';
import 'package:firebas_project/UI/Widgets/customTextField.dart';
import 'package:firebas_project/UI/Widgets/custumRadioButton.dart';
import 'package:firebas_project/providers/GenderProvider.dart';
import 'package:firebas_project/providers/userTypeProvider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class RigesterPage extends StatefulWidget {
  @override
  _RigesterPageState createState() => _RigesterPageState();
}

class _RigesterPageState extends State<RigesterPage> {
  String id;
  String imageUrl;
  String name;
  String email;
  String phone;
  String idNumber;
  String city;
  String password;
  userType type;
  int isMale = 1;
  File file;
  String dropdownValue;

  saveImageUrl(String imageurll) {
    this.imageUrl = imageurll;
  }

  saveName(String name) {
    this.name = name;
  }

  saveEmail(String email) {
    this.email = email;
  }

  savephone(String phonee) {
    this.phone = phonee;
  }

  saveIdNumber(String id_number) {
    this.idNumber = id_number;
  }

  saveCity(String city) {
    this.city = city;
  }

  saveType(userType type) {
    this.type = Provider.of<UserTypeProvider>(context, listen: false).curentUserType;


    
  }

  saveIsMale() {
    this.isMale = Provider.of<GenderProvider>(context, listen: false).isMail;
  }

  savePassword(String password) {
    this.password = password;
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
      saveIsMale();
      saveType(userType.customer);

      saveUser({
        'password': this.password,
        'userId': this.id,
        'imageUrl': this.imageUrl,
        'name': this.name,
        'email': this.email,
        'phone': this.phone,
        'idNumber': this.idNumber,
        'city': this.city,
        'isMale': this.isMale,
        'userType':this.type.toString().split('.').last,
        'file': this.file
      });
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
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
                  PickedFile pickedFile =
                      await ImagePicker().getImage(source: ImageSource.gallery);
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
                labelText: 'Email',
                saveFun: saveEmail,
                validationFun: nullValidation,
              ),
              CustomTextField(
                labelText: 'Password',
                saveFun: savePassword,
                validationFun: nullValidation,
              ),
              CustomTextField(
                labelText: 'Name',
                saveFun: saveName,
                validationFun: nullValidation,
              ),
              CustomTextField(
                labelText: 'Id Number',
                saveFun: saveIdNumber,
                validationFun: nullValidation,
              ),
              CustomTextField(
                labelText: 'City',
                saveFun: saveCity,
                validationFun: nullValidation,
              ),
              CustomTextField(
                labelText: 'Phone',
                saveFun: savephone,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  CustomRadio(
                    title: "Maile",
                    value: 1,
                  ),
                  CustomRadio(
                    title: "femaile",
                    value: 0,
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
            Repository.repository.typeOfUser==userType.admin?  CustomDropDownList(
                value: "software",
              ):Container(),
              SizedBox(
                height: 60,
              ),
              Container(
                height: 40,
                width: double.infinity,
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Text('REGISTER'),
                    onPressed: () async {
                      saveForm();
                    }),
              ),
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

class CustomDropDownList extends StatelessWidget {
  String value;
  CustomDropDownList({this.value});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("User type"),
        Container(
          width: 200,
          child: Center(
            child: DropdownButton<String>(
              value: Provider.of<UserTypeProvider>(context, listen: false).newuserType.toString(),
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.blue),
              underline: Container(
                height: 2,
                color: Colors.blueAccent,
              ),
              onChanged: Provider.of<UserTypeProvider>(context, listen: true).setUserTypeValue,
              items: <String>['software', 'hardware','customer']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
