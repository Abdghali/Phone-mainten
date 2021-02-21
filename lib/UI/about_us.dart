import 'package:firebas_project/utilities/CustomeTestStyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        width: 411.42857142857144,
        height: 866.2857142857143,
        allowFontScaling: true);
    return Scaffold(
      appBar: AppBar(
        title: Text(translator.translate("About_Us")),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_outlined,
              color: Colors.black,
            ),
            onPressed: () => Get.back()),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Container(
              //   child: FlutterLogo(),
              //   // decoration: BoxDecoration(image: DecorationImage(image:AssetImage(""))),
              // ),
              CustomContainer(),
              SizedBox(height: 10.h),

              Text(
                translator.translate('Company_name'),
                style: AUBoldStyle1,
              ),
              SizedBox(height: 100.h),
              Text(
                translator.translate("Company_quality"),
                textAlign: TextAlign.center,
                style: AUNormalStyle,
              ),
              SizedBox(height: 100.h),
              Text(
                translator.translate("Company_experience"),
                textAlign: TextAlign.center,
                style: AUNormalStyle,
              ),
              SizedBox(height: 100.h),

              Text(
                "Developed by Eng.Abdalohsen",
                textAlign: TextAlign.center,
                style: AUBoldStyle2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      width: 100.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50.0)),
          color: Colors.grey),
      child: Center(child: Image.asset("assets/images/llogo.png")),
    );
  }
}
