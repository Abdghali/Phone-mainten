import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebas_project/Models/User.dart';
import 'package:firebas_project/Service/Server.dart';
import 'package:firebas_project/Service/repository.dart';
import 'package:firebas_project/UI/Widgets/customTextField.dart';
import 'package:firebas_project/providers/GenderProvider.dart';
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
    this.type = type;
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
      Logger().e(type);
      // print(Provider.of<GenderProvider>(context, listen: false).isMail);


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
      'userType': this.type.toString().split('.').last,
      'file':this.file
    } );}else{
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
                  SizedBox(height: 20,),
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
                    height: 80,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

class CustomRadio extends StatelessWidget {
  String title;
  int value;
  CustomRadio({this.title, this.value});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio<int>(
          value: value,
          groupValue: Provider.of<GenderProvider>(context, listen: true).isMail,
          onChanged: (int value) {
            Provider.of<GenderProvider>(context, listen: false)
                .setIsMaleValue(value);
          },
        ),
        Text('$title'),
      ],
    );
  }
}
