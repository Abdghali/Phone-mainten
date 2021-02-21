import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebas_project/Service/LastAppIdRepository.dart';
import 'package:firebas_project/Service/repository.dart';
import 'package:firebas_project/UI/pages/userPages/UserHomrPage.dart';
import 'package:firebas_project/UI/loginPage.dart';
import 'package:firebas_project/providers/GenderProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import '../Models/User.dart'as myUser;

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
FirebaseStorage firebaseStorage = FirebaseStorage.instance;
Logger logger = Logger();

Future<String> loginUsingEmailAndPassword(String email, String password) async {
  try {
    UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
    return userCredential.user.uid;
  } catch (e) {
    print(e);
    return null;
  }
}

signOut() {
  auth.signOut();
  Get.to(LoginPage());
}

Future<String> registerUsingEmailAndPassword(
    String email, String password) async {
  try {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email, password: password);

    return userCredential.user.uid;
  } catch (e) {
    print(e);
    return null;
  }
}
saveUser(Map map) async {
  String userId =await registerUsingEmailAndPassword(map['email'], map['password']);
  map.remove('password');
  map['userId'] = userId;
  if(map['file']!=null){
  File file = map['file'];
  String imageUrl = await uploadImage(file);
  map.remove('file');
  map['imageUrl'] = imageUrl;
  }
  Map newMap=map;
  firestore.collection('users').doc(userId).set({...newMap});
  myUser.User user = myUser.User.fromMap(newMap);
  Repository.repository.typeOfUser = user.type;
  Repository.repository.user = user;
  Logger().e(user.toJson().toString());
  Get.off(UserHomePage());
}

Future<String> uploadImage(File file) async {
  String filePath = file.path;
  String fileName = filePath.split('/').last;
  Reference reference = firebaseStorage.ref('images/$fileName');
  TaskSnapshot taskSnapshot = await reference.putFile(file);
  String url = await reference.getDownloadURL();
  //logger.e(url);
  return url;
}

loginToMyAPP(String email, String password) async {
  String userId = await loginUsingEmailAndPassword(email, password);
  await fetchUserData(userId);
}

fetchUserData(String userId) async {
  DocumentSnapshot documentSnapshot =await firestore.collection('users').doc(userId).get();
  Map userMap = documentSnapshot.data();
  Logger().e(userMap);
  myUser.User user = myUser.User.fromMap(userMap);
  Repository.repository.typeOfUser = user.type;
  Repository.repository.user = user;
  Provider.of<GenderProvider>(Get.context, listen: false)
                .setIsMaleValue(user.isMale);
  Get.offAll(UserHomePage());
}

updateUserInFirestore(Map map) async {
  if (map['file'] != null) {
    File file = map['file'];
    String imageUrl = await uploadImage(file);
    map.remove('file');
    map['imageUrl'] = imageUrl;
  }

  firestore.collection('users').doc(auth.currentUser.uid).update({...map});
  fetchUserData(auth.currentUser.uid);
}
Future<String> uploadApplicationImage(File file) async {
  String filePath = file.path;
  String fileName = filePath.split('/').last;
  Reference reference = firebaseStorage.ref('Applications/$fileName');
  TaskSnapshot taskSnapshot = await reference.putFile(file);
  String url = await reference.getDownloadURL();
  //logger.e(url);
  return url;
}

saveApplication(Map map) async {
  map['userId']=auth.currentUser.uid;
  Logger().e(Repository.repository.user.id);
  if(map['file']!=null){
  File file = map['file'];
  String imageUrl = await uploadApplicationImage(file);
  map.remove('file');
  map['imageUrl'] = imageUrl;
  }
  Map newMap=map;
  Logger().e(newMap);
  firestore.collection('applications').doc().set({...newMap});
  // myUser.User user = myUser.User.fromMap(newMap);
  // Repository.repository.typeOfUser = user.type;
  // Repository.repository.user = user;
  // Logger().e(user.toJson().toString());
  // Get.off(UserHomePage());
}

Stream<QuerySnapshot> getAllApplicationsStream(){
Stream<QuerySnapshot> applications =firestore.collection('applications').where('phoneState',isEqualTo:"application").snapshots();

return applications;

}
Stream<QuerySnapshot> getAllPhonesStream(){
Stream<QuerySnapshot> applications =firestore.collection('phones').where('phoneState',isEqualTo:"notYet").snapshots();

return applications;

}
Stream<QuerySnapshot> getAllDeliveredPhonesStream(){
Stream<QuerySnapshot> deliveredApplications =firestore.collection('phones').where('phoneState',isEqualTo:"delivered").snapshots();

return deliveredApplications;

}

savePhone(Map map){
  
  firestore.collection('phones').doc().set({...map});
firestore.collection('applications').where('phoneState',isEqualTo:"notYet").get();


}

getLastApplicationId()async{
  DocumentSnapshot documentSnapshot =await firestore.collection('IDS').doc('MatUbILQ69VI7gyHrqLJ').get();
  Map IDMap = documentSnapshot.data();
  LastAppIdRepository.repository.lastAppId=IDMap['LastApplicationIDS'];
}
setLastApplicationId()async{
await firestore.collection('IDS').doc('MatUbILQ69VI7gyHrqLJ').update({'LastApplicationIDS':LastAppIdRepository.repository.lastAppId});
}
removePhone(int appId)async{
  // todo
QuerySnapshot  Data =await firestore.collection('applications').where('appID',isEqualTo:appId).get();
Logger().e(Data.docs.toString());

}


Stream<QuerySnapshot> getAllUserApplication(){
  Stream<QuerySnapshot> Userapplications =firestore.collection('applications').where('userId',isEqualTo:auth.currentUser.uid).snapshots();
Logger().e(Userapplications.map((event) => print(event)));
return Userapplications;
}

Stream<QuerySnapshot> getAllUserDeliverdPhone(){
  Stream<QuerySnapshot> Userapplications =firestore.collection('phones').where('userId',isEqualTo:auth.currentUser.uid).where('phoneState',isEqualTo:"delivered").snapshots();
return Userapplications;
}
Stream<QuerySnapshot> getAllUserNotYetPhone(){
  Stream<QuerySnapshot> Userapplications =firestore.collection('phones').where('userId',isEqualTo:auth.currentUser.uid).where('phoneState',isEqualTo:"notYet").snapshots();
return Userapplications;
}

getUserId(){
  return auth.currentUser.uid ??null;
}