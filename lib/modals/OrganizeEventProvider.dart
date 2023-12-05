import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';

class OrganizeEventProvider extends ChangeNotifier {
  String _location = '';
  String _timings = '';
  String _priceRangeStart = '';
  String _priceRangeEnd = '';
  List<String> _tags = [];
  String _webUrl = '';
  File _nicFront = File('');
  File _nicBack = File('');
  File _selfie = File('');
  String _role = '';
  String _serviceID = '';

  resetRegOrgProv()
  {
    this._location = '';
    this._timings = '';
    this._priceRangeStart = '';
    this._priceRangeEnd = '';
    this._tags = [];
    this._webUrl = '';
    this._nicFront = File('');
    this._nicBack = File('');
    this._selfie = File('');
    this._role = '';
    this._serviceID = '';
  }

  // Getter and Setter for _fullName
  String get location => _location;
  set location(String value) {
    _location = value;
    notifyListeners();
  }

  // Getter and Setter for _email
  String get timings => _timings;
  set timings(String value) {
    _timings = value;
    notifyListeners();
  }

  // Getter and Setter for _password
  String get priceRangeStart => _priceRangeStart;
  set priceRangeStart(String value) {
    _priceRangeStart = value;
    notifyListeners();
  }

  // Getter and Setter for _phone
  String get priceRangeEnd => _priceRangeEnd;
  set priceRangeEnd(String value) {
    _priceRangeEnd = value;
    notifyListeners();
  }

  // Getter and Setter for _dob
  List<String> get tags => _tags;
  set tags(List<String> newTags) {
    _tags = newTags;
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