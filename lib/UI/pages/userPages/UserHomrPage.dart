import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebas_project/Service/Server.dart';
import 'package:firebas_project/Service/repository.dart';
import 'package:firebas_project/UI/ContactPage.dart';
import 'package:firebas_project/UI/UserProfile.dart';
import 'package:firebas_project/UI/about_us.dart';
import 'package:firebas_project/UI/pages/AddApplicationPage.dart';
import 'package:firebas_project/UI/pages/userPages/userApplicaation.dart';
import 'package:firebas_project/UI/pages/userPages/userDeliverdPhone.dart';
import 'package:firebas_project/UI/pages/userPages/userNotYetPhone%20.dart';
import 'package:firebas_project/UI/team_work.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserHomePage extends StatefulWidget {
  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    tabController = TabController(
        length: 3,
        vsync: this); // vsync need pass the active class for tab bare
  }

  int bnbIndex = 0;
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
                currentAccountPicture:
                    Repository.repository.user.imageUrl != null
                        ? CachedNetworkImage(
                            imageUrl: Repository.repository.user.imageUrl,
                            fit: BoxFit.cover,
                          )
                        : FlutterLogo(),
                accountName: Text(Repository.repository.user.name ?? "user"),
                accountEmail: Text(
                    Repository.repository.user.email ?? "user@example.com"),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('My Profile'),
                onTap: () {
                  Get.to(UserProfile());
                },
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('My HomePage'),
                onTap: () {
                  Get.offAll(UserHomePage());
                },
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Contact us'),
                onTap: () {
                  Get.to(ContactPage());
                },
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('About Us'),
                onTap: () {
                  Get.to(AboutUs());
                },
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Team Work'),
                onTap: () {
                  Get.to(TeamWork());
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('LogOut'),
                onTap: () {
                  signOut();
                },
              ),
            ],
          ),
        ),
        body: Scaffold(
          body: Container(
            child: TabBarView(controller: tabController, children: [
              UserApplicationsPage(),
              UseruserNotYetPhonePage(),
              UseruserDeliverdPhonePage(),
            ]),
          ),
          bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: tabController.index,
              onTap: (value) {
                tabController.animateTo(value);
                tabController.index = value;
                setState(() {});
              },
              items: [
                BottomNavigationBarItem(
                    label: 'Applications', icon: Icon(Icons.menu)),
                BottomNavigationBarItem(
                    label: 'Not Yet', icon: Icon(Icons.info)),
                BottomNavigationBarItem(
                    label: 'Deliverd Phones', icon: Icon(Icons.done)),
              ]),
        ));
    floatingActionButton:
    FloatingActionButton(
      onPressed: () {
        Get.to(AddApplicationPage());
      },
      child: Icon(Icons.add),
    );
  }
}
