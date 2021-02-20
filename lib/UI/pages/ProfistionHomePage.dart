import 'package:flutter/material.dart';
import 'package:firebas_project/Service/Server.dart';
import 'package:firebas_project/Service/repository.dart';
import 'package:firebas_project/UI/UserProfile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfishionHomePage extends StatefulWidget {
  @override
  _ProfishionHomePage createState() => _ProfishionHomePage();
}

class _ProfishionHomePage extends State<ProfishionHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profishion  Home Page"),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(Repository.repository.user.name??"Profishion"),
              accountEmail: Text(Repository.repository.user.email??"Profishion@example.com"),
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
                  child: Text("Profishion Home Page"),
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
