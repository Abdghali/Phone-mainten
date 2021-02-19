import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebas_project/Service/repository.dart';
import 'package:firebas_project/UI/Widgets/customRowOfText.dart';
import 'package:firebas_project/UI/editUserProfile.dart';
import 'package:firebas_project/utilities/CustomeTestStyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
        actions: [
          IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                 Get.to(EditUserProfile());
              })
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 150,
              width: 150,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  color: Colors.grey,
                  child: Repository.repository.user.imageUrl != null
                      ? CachedNetworkImage(
                          imageUrl: Repository.repository.user.imageUrl,
                          fit: BoxFit.cover,
                        )
                      : FlutterLogo(),
                ),
              ),
            ),
            CustomeRowOfText(
              title: "Name",
              value: Repository.repository.user.name,
            ),
            // CustomeRowOfText(
            //   title: "Email",
            //   value: Repository.repository.user.email,
            // ),
            CustomeRowOfText(
              title: "City",
              value: Repository.repository.user.city,
            ),
            CustomeRowOfText(
              title: "Phone",
              value: Repository.repository.user.phone,
            ),
            CustomeRowOfText(
              title: "ID Number",
              value: Repository.repository.user.idNumber,
            ),
            CustomeRowOfText(
              title: "Gender",
              value:
                  Repository.repository.user.isMale == 1 ? "maile" : "femaile",
            ),
          ],
        ),
      ),
    );
  }
}
