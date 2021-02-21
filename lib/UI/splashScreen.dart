import 'package:firebas_project/Service/Server.dart';
import 'package:firebas_project/Service/repository.dart';
import 'package:firebas_project/UI/loginPage.dart';
import 'package:firebas_project/UI/pages/ProfistionHomePage.dart';
import 'package:firebas_project/UI/pages/adminPages/adminHomePage.dart';
import 'package:firebas_project/UI/pages/userPages/UserHomrPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import '../Models/User.dart';


class SplachScreen extends StatefulWidget {
  @override
  _SplachScreenState createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen> {
    //final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  String userId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userId = getUserId();
    if (userId != null) {
      fetchUserData(userId);
    }
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2)).then((value) {
      String id = getUserId();
      if (id != null) {
        // Get.offAll(HomePage());
        if (Repository.repository.user.type == userType.customer) {
          Get.offAll(UserHomePage());
        } else if (Repository.repository.user.type == userType.admin) {
          Get.offAll(AdminHomePage());
        } else if (Repository.repository.user.type == userType.software) {
          Get.offAll(ProfishionHomePage());
        } else if (Repository.repository.user.type == userType.hardware) {
          Get.offAll(ProfishionHomePage());
        }

        // todo
      } else {
         Get.to(LoginPage());
      }
    });
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Image.asset('assets/images/llogo.png'),
      ),
    );
  }
}