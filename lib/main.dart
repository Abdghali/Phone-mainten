import 'package:firebas_project/UI/loginPage.dart';
import 'package:firebas_project/UI/pages/adminPages/adminHomePage.dart';
import 'package:firebas_project/UI/registerPage.dart';
import 'package:firebas_project/providers/GenderProvider.dart';
import 'package:firebas_project/providers/IssueProvider.dart';
import 'package:firebas_project/providers/userTypeProvider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';

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
     return MultiProvider(
        providers: [
          ChangeNotifierProvider<GenderProvider>(
            create: (_) => GenderProvider(),
          ),
          ChangeNotifierProvider<UserTypeProvider>(
            create: (_) => UserTypeProvider(),
          ),
          ChangeNotifierProvider<IssueProvider>(
            create: (_) => IssueProvider(),
          ),
        
        ],
    child: GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
     // home: HomePage(),
    //  home: AboutUs(),
      //home: ContactUs(),
    //  home: TeamWork(),
     // home: PackagesGsk(),
     //home: ContactPage(),
    // home: LoginPage(),
     home: App(),
     //home: AdminHomePage(),
    ));
  }
}

class App extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return SomethingWentWrong();
        }
        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
        // return HomePage();
       //  return LoginPage();
          return LoginPage();
        }
        // Otherwise, show something whilst waiting for initialization to complete
        return Loading();
      },
    );
  }
}

class SomethingWentWrong extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Error'),
      ),
    );
  }
}

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: CircularProgressIndicator(),
    ));
  }
}

