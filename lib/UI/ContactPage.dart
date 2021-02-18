import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  sharePhoto() async {
    PickedFile pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    Share.shareFiles(['${pickedFile.path}'],
        text: 'Great picture', subject: 'subject');
  }

  sharePost(String post) {
    Share.share(post);
  }

  makeCall(int phoneNumber) async {
    if (await canLaunch('tel:$phoneNumber')) {
      await launch('tel:$phoneNumber');
    } else {
      print('phone cant open this url');
    }
  }

  sendSms(int number, String content) async {
    Uri uri = Uri(
        scheme: 'sms',
        path: '$number',
        queryParameters: {'body': '$content'});
    if (await canLaunch(uri.toString())) {
      await launch(uri.toString());
    } else {
      print('phone cant open this url');
    }
  }

  sendEmail(String otherEmail, String title, String body) async {
    Uri uri = Uri(
        scheme: 'mailto', path: otherEmail, query: 'subject=$title&body=$body');
    if (await canLaunch(uri.toString())) {
      await launch(uri.toString());
    } else {
      print('phone cant open this url');
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        width: 411.42857142857144,
        height: 866.2857142857143,
        allowFontScaling: true);
    return Scaffold(
      appBar: AppBar(
          title: Text("Contact Us"),
          centerTitle: true,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_outlined),
              onPressed: () => Get.back())),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250.h,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/sliverBack.png"))),
            ),
            InkWell(
              onTap: () {
                makeCall(0865926580);
              },
              child: CustomContainer(
                contactUsClass: ContactUsClass(
                    icon: Icon(Icons.phone, color: Colors.blue),
                    title: "Tel Number",
                    subTitle: "0865926580"),
              ),
            ),
            Divider(),
            InkWell(
              onTap: () {
                makeCall(05982658742);
              },
              child: CustomContainer(
                contactUsClass: ContactUsClass(
                    icon: Icon(Icons.phone, color: Colors.blue),
                    title: "Phone Number",
                    subTitle: "05982658742"),
              ),
            ),
            Divider(),
            InkWell(
              onTap: () {
                makeCall(0598686059);
              },
              child: CustomContainer(
                contactUsClass: ContactUsClass(
                    icon: Icon(Icons.phone, color: Colors.blue),
                    title: "Phone Number",
                    subTitle: "0598686059"),
              ),
            ),
            Divider(),
            InkWell(
              onTap: () {sendSms(06992658204,"Hello, I have a quation");},
              child: CustomContainer(
                contactUsClass: ContactUsClass(
                    icon: Icon(Icons.message, color: Colors.blue),
                    title: "Message",
                    subTitle: "06992658204"),
              ),
            ),
            Divider(),
            InkWell(
              onTap: () {sendEmail("abdghali13@gmail.com","My Phone","Hello i have a quation");},
              child: CustomContainer(
                contactUsClass: ContactUsClass(
                    icon: Icon(Icons.email, color: Colors.blue),
                    title: "Email",
                    subTitle: "mphm@gmail.com"),
              ),
            ),
            Divider(),
            SizedBox(height: 10),
            CustomContainer2(),
          ],
        ),
      ),
    );
  }
}

class ContactUsClass {
  String type;
  Icon icon;
  String title;
  String subTitle;

  ContactUsClass({this.type, this.icon, this.title, this.subTitle});
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
            Text("${widget.contactUsClass.subTitle},",
                style: TextStyle(color: Colors.blue))
          ],
        )
      ],
    ));
  }
}

class CustomContainer2 extends StatelessWidget {
  openUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true);
    } else {
      print('phone cant open this url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 50.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () {
              openUrl("https://www.facebook.com/SamsungPalestine");
            },
            child: CustomSocilalContainer(
                title: "Facebook", imageUrl: "assets/images/fac.png"),
          ),
          InkWell(
            onTap: () {
              openUrl("https://www.instagram.com/samsungmobile/");
            },
            child: CustomSocilalContainer(
                title: "Instagram", imageUrl: "assets/images/insta.png"),
          ),
        ],
      ),
    );
  }
}

class CustomImageContainer extends StatelessWidget {
  String imagUrl;
  CustomImageContainer(this.imagUrl);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: 50.w,
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(imagUrl), fit: BoxFit.fill),
          borderRadius: BorderRadius.all(Radius.circular(50.0)),
          color: Colors.grey),
    );
  }
}

class CustomSocilalContainer extends StatelessWidget {
  String imageUrl;
  String title;
  CustomSocilalContainer({this.title, this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CustomImageContainer(imageUrl),
          SizedBox(height: 10.h),
          Text(
            "${title}",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
