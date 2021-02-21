import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebas_project/UI/pages/adminPages/adminApplicationsPage.dart';
import 'package:firebas_project/UI/pages/adminPages/adminDeliveredPhones.dart';
import 'package:firebas_project/UI/pages/adminPages/adminPhonesPage.dart';
import 'package:flutter/material.dart';
import 'package:firebas_project/Service/Server.dart';
import 'package:firebas_project/Service/repository.dart';
import 'package:firebas_project/UI/UserProfile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminHomePage extends StatefulWidget {
  @override
  _AdminHomePage createState() => _AdminHomePage();
}

class _AdminHomePage extends State<AdminHomePage>
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
          title: Text("Admin Home Page"),
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
                accountName: Text(Repository.repository.user.name ?? "admin"),
                accountEmail: Text(
                    Repository.repository.user.email ?? "admin@example.com"),
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
                  Get.offAll(AdminHomePage());
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
              adminApplicationsPage(),
              adminPhonesPage(),
              adminDeliveredPhonesPage(),
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
                    label: 'Deliverd Applications', icon: Icon(Icons.done)),
              ]),
        ));
  }
}
