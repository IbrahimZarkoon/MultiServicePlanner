import 'package:flutter_datetime_picker_bdaya/flutter_datetime_picker_bdaya.dart';

class CustomPicker extends CommonPickerModel {
  String digits(int value, int length) {
    return '$value'.padLeft(length, "0");
  }

  CustomPicker({DateTime? currentTime, LocaleType? locale})
      : super(locale: locale) {
    this.currentTime = currentTime ?? DateTime.now();
    setLeftIndex(this.currentTime.hour % 12); // Adjust hours from 0 to 12
    setMiddleIndex(this.currentTime.minute);
    setRightIndex(this.currentTime.hour < 12 ? 0 : 1); // 0 for AM, 1 for PM
  }

  @override
  String? leftStringAtIndex(int index) {
    if (index >= 0 && index <= 12) {
      return digits(index == 0 ? 12 : index, 2); // Convert 0 to 12
    } else {
      return null;
    }
  }

  @override
  String? middleStringAtIndex(int index) {
    if (index >= 0 && index < 60) {
      return digits(index, 2);
    } else {
      return null;
    }
  }

  @override
  String? rightStringAtIndex(int index) {
    if (index == 0) {
      return "AM";
    } else if (index == 1) {
      return "PM";
    } else {
      return null;
    }
  }

  @override
  String leftDivider() {
    return "|";
  }

  @override
  String rightDivider() {
    return "|";
  }

  @override
  List<int> layoutProportions() {
    return [1, 2, 1];
  }

  @override
  DateTime finalTime() {
    int hour = currentLeftIndex() + (currentRightIndex() == 1 ? 12 : 0);

    return currentTime.isUtc
        ? DateTime.utc(currentTime.year, currentTime.month, currentTime.day,
        hour, currentMiddleIndex(), 0)
        : DateTime(currentTime.year, currentTime.month, currentTime.day,
        hour, currentMiddleIndex(), 0);
  }
}