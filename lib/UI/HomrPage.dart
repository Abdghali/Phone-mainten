import 'package:firebas_project/Service/Server.dart';
import 'package:firebas_project/UI/UserProfile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
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
    );
  }
}
