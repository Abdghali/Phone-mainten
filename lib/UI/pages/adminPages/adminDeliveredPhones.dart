import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebas_project/Models/Application.dart';
import 'package:firebas_project/Service/PhoneRepository.dart';
import 'package:firebas_project/Service/Server.dart';
import 'package:firebas_project/UI/pages/ApplicationInfoPage.dart';
import 'package:firebas_project/UI/pages/adminPages/adminApplicationInfoPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class adminDeliveredPhonesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: getAllDeliveredPhonesStream(),
      builder: (BuildContext, AsyncSnapshot<QuerySnapshot> data) {
        if (data.hasError) {
        } else if (data.hasData) {
          QuerySnapshot applicationData = data.data;
          List<Application> applications = applicationData.docs.map((e) {
            Map map = e.data();

            return Application.fromMap(map);
          }).toList();
          return ListView.builder(
              itemCount: applications.length,
              itemBuilder: (contex, index) {
                return InkWell(
                  onTap: () {
                    PhoneRepository.repository.application =
                        applications[index];
                         PhoneRepository.repository.pageCurentState=pageStatuse.delivaredPage ;
                    Get.to(AdminApplicationInfoPage());

                  },
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.settings_applications_sharp),
                        title: Text(applications[index].phoneType),
                        subtitle: Text(
                          applications[index].phineColor,
                          style: TextStyle(color: Colors.blue[300]),
                        ),
                      ),
                      Divider(),
                    ],
                  ),
                );
              });
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
