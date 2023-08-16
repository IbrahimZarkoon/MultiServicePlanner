import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DotsList extends StatelessWidget {
  final int numberOfDots;

  DotsList({required this.numberOfDots});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: numberOfDots,
      itemBuilder: (context, index) {
        return  Padding(
          padding: const EdgeInsets.symmetric(vertical: 0),
          child: Text('•', style: TextStyle(fontSize: 12,color: Colors.black.withOpacity(0.2))),
        );
      },
    );
  }
}