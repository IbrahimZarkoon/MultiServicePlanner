import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';

class RegisterOrgProvider extends ChangeNotifier {
  String _fullName = '';
  String _email = '';
  String _password = '';
  String _phone = '';
  String _dob = '';
  String _webUrl = '';
  File _nicFront = File('');
  File _nicBack = File('');
  File _selfie = File('');
  String _role = '';
  String _serviceID = '';

  resetRegOrgProv()
  {
     this._fullName = '';
     this._email = '';
     this._password = '';
     this._phone = '';
     this._dob = '';
     this._webUrl = '';
     this._nicFront = File('');
     this._nicBack = File('');
    this._selfie = File('');
     this._role = '';
     this._serviceID = '';
  }

  // Getter and Setter for _fullName
  String get fullName => _fullName;
  set fullName(String value) {
    _fullName = value;
    notifyListeners();
  }

  // Getter and Setter for _email
  String get email => _email;
  set email(String value) {
    _email = value;
    notifyListeners();
  }

  // Getter and Setter for _password
  String get password => _password;
  set password(String value) {
    _password = value;
    notifyListeners();
  }

  // Getter and Setter for _phone
  String get phone => _phone;
  set phone(String value) {
    _phone = value;
    notifyListeners();
  }

  // Getter and Setter for _dob
  String get dob => _dob;
  set dob(String value) {
    _dob = value;
    notifyListeners();
  }

  // Getter and Setter for _webUrl
  String get webUrl => _webUrl;
  set webUrl(String value) {
    _webUrl = value;
    notifyListeners();
  }

  // Getter and Setter for _nicFront
  File get nicFront => _nicFront;
  set nicFront(File value) {
    _nicFront = value;
    notifyListeners();
  }

  // Getter and Setter for _nicBack
  File get nicBack => _nicBack;
  set nicBack(File value) {
    _nicBack = value;
    notifyListeners();
  }

  // Getter and Setter for _selfie
  File get selfie => _selfie;
  set selfie(File value) {
    _selfie = value;
    notifyListeners();
  }

  // Getter and Setter for _role
  String get role => _role;
  set role(String value) {
    _role = value;
    notifyListeners();
  }

  // Getter and Setter for _serviceID
  String get serviceID => _serviceID;
  set serviceID(String value) {
    _serviceID = value;
    notifyListeners();
  }
}