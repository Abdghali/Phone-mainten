import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebas_project/Service/Server.dart';
import 'package:firebas_project/Service/repository.dart';
import 'package:firebas_project/UI/Widgets/custumProfileTextFeild.dart';
import 'package:firebas_project/UI/Widgets/custumRadioButton.dart';
import 'package:firebas_project/providers/GenderProvider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditUserProfile extends StatefulWidget {
  @override
  _EditUserProfileState createState() => _EditUserProfileState();
}

class _EditUserProfileState extends State<EditUserProfile> {
  String newName;
  String newCity;
  String newPhone;
  String newidNumber;

  savePhone(String newphone) {
    this.newPhone = newphone;
  }

  saveIdNumber(String newIdNumber1) {
    this.newidNumber = newIdNumber1;
  }

  saveCity(String newCity1) {
    this.newCity = newCity1;
  }

  saveName(String newName1) {
    this.newName = newName1;
  }

  updateUser() {
    Map map = {
      'name': this.newName ?? Repository.repository.user.name,
      'city': this.newCity ?? Repository.repository.user.city,
      'phone': this.newPhone ?? Repository.repository.user.phone,
      'idNumber': this.newidNumber ?? Repository.repository.user.idNumber,
      'isMale': Provider.of<GenderProvider>(context, listen: false).isMail?? Repository.repository.user.isMale,
      'file': this.file ?? null,
    };
    updateUserInFirestore(map);
  }

  File file;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
        actions: [IconButton(icon: Icon(Icons.edit), onPressed: () {})],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Container(
          child: Column(
            children: [
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
                        ? Repository.repository.user.imageUrl != null
                            ? CachedNetworkImage(
                                imageUrl: Repository.repository.user.imageUrl,
                                fit: BoxFit.cover,
                              )
                            : FlutterLogo()
                        : Image.file(
                            file,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              CustomeProfileTextFeaild(
                  title: "Name",
                  value: Repository.repository.user.name,
                  fun: saveName),
              SizedBox(
                height: 20,
              ),
              CustomeProfileTextFeaild(
                  title: "City",
                  value: Repository.repository.user.city,
                  fun: saveCity),
              SizedBox(
                height: 20,
              ),
              CustomeProfileTextFeaild(
                  title: "phone",
                  value: Repository.repository.user.phone,
                  fun: savePhone),
              SizedBox(
                height: 20,
              ),
              CustomeProfileTextFeaild(
                  title: "ID Number",
                  value: Repository.repository.user.idNumber,
                  fun: saveIdNumber),
              SizedBox(
                height: 80,
              ),
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
              RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Text('Done'),
                  onPressed: () {
                    updateUser();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
