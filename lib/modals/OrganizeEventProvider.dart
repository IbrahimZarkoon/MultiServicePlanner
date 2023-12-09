import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class OrganizeEventProvider extends ChangeNotifier {
  String _location = '';
  String _venueName = '';
  String _timings = '';
  String _priceRangeStart = '';
  String _priceRangeEnd = '';
  List<String> _tags = [];
  String _capacity = '';
  File _bannerImg = File('');
  List<XFile> _relatedPics = [];
  String _desc = '';
  String _link = '';
  String _role = '';
  String _serviceID = '';

  resetRegOrgProv()
  {
    this._location = '';
    this._timings = '';
    this._venueName = '';
    this._desc = '';
    this._priceRangeStart = '';
    this._priceRangeEnd = '';
    this._tags = [];
    this._capacity = '';
    this._bannerImg = File('');
    this._relatedPics = [];
    this._role = '';
    this._serviceID = '';
  }

  // Getter and Setter for _fullName
  String get location => _location;
  set location(String value) {
    _location = value;
    notifyListeners();
  }

  // Getter and Setter for _fullName
  String get venueName => _venueName;
  set venueName(String value) {
    _venueName = value;
    notifyListeners();
  }

  // Getter and Setter for _fullName
  String get link => _link;
  set link(String value) {
    _link = value;
    notifyListeners();
  }

  // Getter and Setter for _fullName
  String get desc => _desc;
  set desc(String value) {
    _desc = value;
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
  String get capacity => _capacity;
  set capacity(String value) {
    _capacity = value;
    notifyListeners();
  }

  // Getter and Setter for _nicFront
  File get bannerImg => _bannerImg;
  set bannerImg(File value) {
    _bannerImg = value;
    notifyListeners();
  }

  // Getter
  List<XFile> get relatedPics => _relatedPics;

  // Setter
  set relatedPics(List<XFile> value) {
    _relatedPics = value;
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