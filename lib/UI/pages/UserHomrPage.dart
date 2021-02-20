import 'package:firebas_project/Service/Server.dart';
import 'package:firebas_project/Service/repository.dart';
import 'package:firebas_project/UI/UserProfile.dart';
import 'package:firebas_project/UI/pages/AddApplicationPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserHomePage extends StatefulWidget {
  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CHome Page"),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(Repository.repository.user.name??"username"),
              accountEmail: Text(Repository.repository.user.email??"name@example.com"),
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
                  child: Text("User profile"),
                  onPressed: () {
                    Get.to(UserProfile());
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {Get.to(AddApplicationPage());},
        child: Icon(Icons.add),
      ),
    );
  }
}
