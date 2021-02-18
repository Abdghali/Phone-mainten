import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class PackagesGsk extends StatelessWidget {
  sharePhoto() async {
    PickedFile pickedFile =
        await ImagePicker().getImage(source: ImageSource.camera);
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
        queryParameters: {'body': 'hello this is my first sms'});
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

  openUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true);
    } else {
      print('phone cant open this url');
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Packages Test'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 150),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RaisedButton(
                child: Text('open URL'),
                onPressed: () {
                  openUrl('https://pub.dev/packages/url_launcher');
                }),
            RaisedButton(
                child: Text('call Me'),
                onPressed: () {
                  makeCall(972592111111);
                }),
            RaisedButton(
                child: Text('send sms'),
                onPressed: () {
                  sendSms(972592111111, 'ths is my sms');
                }),
            RaisedButton(
                child: Text('send email'),
                onPressed: () {
                  sendEmail('abdghali13@gmail.com', 'test email',
                      'this is just test email for you');
                }),
            RaisedButton(
                child: Text('share post'),
                onPressed: () {
                  sharePhoto();
                })
          ],
        ),
      ),
    );
  }
}