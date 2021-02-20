import 'package:flutter/material.dart';
import 'package:firebas_project/Service/Server.dart';
import 'package:firebas_project/Service/repository.dart';
import 'package:firebas_project/UI/UserProfile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminHomePage extends StatefulWidget {
  @override
  _AdminHomePage createState() => _AdminHomePage();
}

class _AdminHomePage extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Home Page"),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(Repository.repository.user.name??"admin"),
              accountEmail: Text(Repository.repository.user.email??"admin@example.com"),
            ),
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Center(
              child: RaisedButton(onPressed: () {
                signOut();
              }),
            ),
            Center(
              child: RaisedButton(
                  child: Text("Admin Home Page"),
                  onPressed: () {
                    Get.to(UserProfile());
                  }),
            ),
          ],
        ),
      ),
     
    );
  }
}
