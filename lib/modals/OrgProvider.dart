import 'package:flutter/cupertino.dart';

class OrgProvider extends ChangeNotifier{
  String _orgID = '';
  String _serviceID = '';


 String get orgID => _orgID;

 set orgID(String value)
 {
   _orgID = value;
   notifyListeners();
 }

  String get serviceID => _serviceID;

  set serviceID(String value)
  {
    _serviceID = value;
    notifyListeners();
  }
}