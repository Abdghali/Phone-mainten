import 'package:firebas_project/Models/Application.dart';
import 'package:firebas_project/Models/Phone.dart';
import 'package:firebas_project/Models/User.dart';

enum pageStatuse {applicationPage,notYetPage,delivaredPage}

class PhoneRepository {
PhoneRepository._();
static PhoneRepository repository = PhoneRepository._();
Application application;
bool textFeaildEnable= false;
pageStatuse pageCurentState;

}