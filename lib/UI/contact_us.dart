import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class ContactUs extends StatelessWidget {
  List<String> _images = [
    'assets/images/sliverBack.png',
    'assets/images/sliverBack2.png',
    'assets/images/sliverBack3.png',
    'assets/images/SliverBack4.png'
  ];
  List<ContactUsClass> contacts = [
    ContactUsClass(
        icon: Icon(Icons.mobile_friendly_sharp),
        title: "Telephon Number",
        subTitle: "35965824"),
    ContactUsClass(
        icon: Icon(Icons.mobile_friendly_sharp),
        title: "Telephon Number",
        subTitle: "35965824"),
    ContactUsClass(
        icon: Icon(Icons.phone),
        title: "Phone Number",
        subTitle: "06992658204"),
    ContactUsClass(
        icon: Icon(Icons.phone), title: "Phone Number", subTitle: "0598265874"),
    ContactUsClass(
        icon: Icon(Icons.phone),
        title: "Phone Number",
        subTitle: "09852318328"),
    ContactUsClass(
        icon: Icon(Icons.email), title: "Email", subTitle: "mphm@gmail.com"),
    ContactUsClass(icon: Icon(Icons.message), title: "Message", subTitle: "06992658204"),
    ContactUsClass(icon: Icon(Icons.message), title: "Iestagram", subTitle: "@mphm"),
    ContactUsClass(icon: Icon(Icons.message), title: "Facebook", subTitle: "06992658204"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(slivers: <Widget>[
      SliverAppBar(
        expandedHeight: 250.0,
        floating: false,
        pinned: true,
        flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: Text("Contact Us",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                )),
            background: Swiper(
              itemCount: _images.length,
              itemBuilder: (BuildContext context, int index) => Image.asset(
                _images[index],
                fit: BoxFit.cover,
              ),
              autoplay: true,
            )),
      ),
      SliverList(
        delegate: SliverChildBuilderDelegate(
            (context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 75,
                    color: Colors.black12,
                    child: CustomContainer(
                      contactUsClass: contacts[index],
                    ),
                  ),
                ),
            childCount: contacts.length),
      )
    ]));
  }
}

class ContactUsClass {
  Icon icon;
  String title;
  String subTitle;

  ContactUsClass({this.icon, this.title, this.subTitle});
}

class CustomContainer extends StatefulWidget {
  ContactUsClass contactUsClass;

  CustomContainer({this.contactUsClass});
  @override
  _CustomContainerState createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      children: [
        Container(
          height: 50,
          width: 50,
          child: widget.contactUsClass.icon,
        ),
        SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${widget.contactUsClass.title}"),
            SizedBox(height: 10),
            Text("${widget.contactUsClass.subTitle}")
          ],
        )
      ],
    ));
  }
}
