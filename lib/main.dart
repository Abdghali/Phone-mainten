import 'package:firebas_project/UI/HomrPage.dart';
import 'package:firebas_project/UI/about_us.dart';
import 'package:firebas_project/UI/contact_us.dart';
import 'package:firebas_project/UI/team_work.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await translator.init(
    localeDefault: LocalizationDefaultType.device,
    languagesList: <String>['ar', 'en'],
    assetsDirectory: 'assets/langs/',
  );
  
runApp(LocalizedApp(child: MyApp()));

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
     // home: HomePage(),
      //home: AboutUs(),
      //home: ContactUs(),
      home: TeamWork(),
    );
  }
}
