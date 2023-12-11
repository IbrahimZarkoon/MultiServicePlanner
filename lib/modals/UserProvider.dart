import 'package:flutter/cupertino.dart';
import 'package:multi_service_planner/Response/NotificationModal.dart';

class UserProvider extends ChangeNotifier {
  String _userID = '';
  List<NotificationModal>? notifications;

  setNotifications(data) {
    notifications = data;
  }

  String get userID => _userID;

  set userID(String value) {
    _userID = value;
    notifyListeners();
  }
}
