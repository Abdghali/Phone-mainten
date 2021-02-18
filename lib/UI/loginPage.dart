import 'package:firebas_project/UI/HomrPage.dart';
import 'package:firebas_project/UI/Widgets/customTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
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

  saveForm() {
    if (loginKey.currentState.validate()) {
      loginKey.currentState.save();

      print("email : $email" + "Passworld: $password");
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
      appBar: AppBar(),
      body: Form(
        key: loginKey,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 100),
            child: Column(
              children: [
               
                Container(
                  height: 200.h,
                  width: 200.w,
                  decoration: BoxDecoration(image:DecorationImage(image: AssetImage("assets/images/llogo.png")) ),
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
                    Get.to(HomePage());
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
