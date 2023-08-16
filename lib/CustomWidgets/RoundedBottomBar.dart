import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedCupertinoTabBar extends CupertinoTabBar {
  RoundedCupertinoTabBar({
    Key? key,
    required int currentIndex,
    required Color activeColor,
    required Color inactiveColor,
    required List<BottomNavigationBarItem> items,
    required ValueChanged<int>? onTap,
    double iconSize = 30,
    double height = 50,
    Color backgroundColor = Colors.black87,
  }) : super(
    key: key,
    currentIndex: currentIndex,
    activeColor: activeColor,
    inactiveColor: inactiveColor,
    items: items,
    onTap: onTap,
    iconSize: iconSize,
    backgroundColor: backgroundColor,
    border: Border.all(color: Colors.transparent,width: 0),

    height: height,
  );

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(0),
      child: super.build(context),
    );
  }
}