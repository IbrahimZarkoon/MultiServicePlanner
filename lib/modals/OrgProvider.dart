import 'package:flutter/cupertino.dart';

class OrgProvider extends ChangeNotifier{
  String _orgID = '';

 String get orgID => _orgID;

 set orgID(String value)
 {
   _orgID = value;
   notifyListeners();
 }
}