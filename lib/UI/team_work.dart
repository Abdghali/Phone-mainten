import 'package:firebas_project/utilities/CustomeTestStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class TeamWork extends StatefulWidget {
  @override
  _TeamWorkState createState() => _TeamWorkState();
}

class _TeamWorkState extends State<TeamWork> {
  List<Person> persons = [
    Person(image: "assets/images/manger.jpeg", name: "Maneger Mohamed"),
    Person(image: "assets/images/engSamy.jpeg", name: "Engineer Samy"),
    Person(image: "assets/images/engabd.jpeg", name: "Engineer Abd"),
    Person(image: "assets/images/tamer.jpeg", name: "Receptionist Tamer"),
  ];

  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        width: 411.42857142857144,
        height: 866.2857142857143,
        allowFontScaling: true);
    return Scaffold(
      appBar: AppBar(
        title: Text(translator.translate("team_work")),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_outlined,
              color: Colors.black,
            ),
            onPressed: () => Get.back()),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
        child: Center(
          child: ListView.builder(
              itemCount: persons.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 50.h),
                  child: Center(child: CustomContainer2(persons[index])),
                );
              }),
        ),
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  String imagUrl;
  CustomContainer(this.imagUrl);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      width: 100.w,
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(imagUrl), fit: BoxFit.fill),
          borderRadius: BorderRadius.all(Radius.circular(50.0)),
          color: Colors.grey),
    );
  }
}

class CustomContainer2 extends StatelessWidget {
  Person person;
  CustomContainer2(this.person);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CustomContainer(person.image),
          SizedBox(height: 10.h),
          Text(
            "${person.name}",
            // translator.translate('Company_name'),
            style: AUBoldStyle1,
          ),
        ],
      ),
    );
  }
}

class Person {
  String image;
  String name;
  Person({this.image, this.name});
}
