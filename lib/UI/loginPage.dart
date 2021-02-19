import 'package:firebas_project/Service/Server.dart';
import 'package:firebas_project/UI/HomrPage.dart';
import 'package:firebas_project/UI/Widgets/customTextField.dart';
import 'package:firebas_project/UI/registerPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:logger/logger.dart';

class LoginPage extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  GlobalKey<FormState> loginKey = GlobalKey();
  String email;
  String password;

  saveEmail(String newEmail) {
    this.email = newEmail;
  }

  savepassword(String newPassword) {
    this.password = newPassword;
  }

  String nullValidator(String value) {
    if (value.length == 0 || value == null || value == '') {
      return 'Required Field';
    }
  }

  saveForm() async {
    if (loginKey.currentState.validate()) {
      loginKey.currentState.save();
      String id = await loginUsingEmailAndPassword(email, password);
      if (id != null) {
         await loginToMyAPP(email, password); // Logger().e(user.name);
        // Get.offAll(HomePage());
      } else {
        return;
      }
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        width: 411.42857142857144,
        height: 866.2857142857143,
        allowFontScaling: true);
    return Scaffold(
      body: Form(
        key: loginKey,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 100),
            child: Column(
              children: [
                Container(
                  height: 200.h,
                  width: 200.w,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/llogo.png"))),
                ),
                SizedBox(
                  height: 100.h,
                ),
                CustomTextField(
                  labelText: 'Email',
                  saveFun: saveEmail,
                  validationFun: nullValidator,
                ),
                CustomTextField(
                  labelText: 'Password',
                  saveFun: savepassword,
                  validationFun: nullValidator,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: RaisedButton(
                      child: Text('Sign in'),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      onPressed: () {
                        saveForm();
                      }),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(RigesterPage());
                  },
                  child: Text(
                    'Register Now',
                    style: TextStyle(color: Colors.blue),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
