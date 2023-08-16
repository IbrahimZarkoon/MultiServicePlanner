import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class MyPieChart extends StatelessWidget {
  final Map<String, double> dataMap = {
    "Completed": 5,
    "Upcoming": 3,
    "Cancelled": 2,
  };

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PieChart(
          PieChartData(

            sections: getSections(),
            centerSpaceRadius: 35,
            sectionsSpace: 2,
            startDegreeOffset: 270
          ),
        ),
        const Center(
          child: Text(
            "EVENTS",
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  List<PieChartSectionData> getSections() {
    return dataMap.entries.map((entry) {
      final double value = entry.value;
      final String title = entry.key;

      Color color;
      switch (title) {
        case "Completed":
          color = const Color(0xffff1f6f);
          break;
        case "Upcoming":
          color = const Color(0xff7173ab);
          break;
        case "Cancelled":
          color = const Color(0xffed8c8e);
          break;
        default:
          color = Colors.grey;
      }

      return PieChartSectionData(
        color: color,
        value: value,
        title: "${value*10}%",
        radius: 35,
        titleStyle: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();
  }
}