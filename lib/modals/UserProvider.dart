import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier{
  String _userID = '';


  String get userID => _userID;

  set userID(String value)
  {
    _userID = value;
    notifyListeners();
  }

}