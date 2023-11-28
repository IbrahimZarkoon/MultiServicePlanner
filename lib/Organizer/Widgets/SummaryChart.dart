import 'dart:math';

import 'package:flutter/material.dart';
import 'package:stacked_chart/stacked_chart.dart';

import '../../Enums/Colors.dart';

enum WeekDay { monday, tuesday, wednesday, thursday, friday, saturday, sunday }

class WeeklyChartDemo extends StatefulWidget {
  const WeeklyChartDemo({Key? key}) : super(key: key);

  @override
  _WeeklyChartDemoState createState() => _WeeklyChartDemoState();
}

class _WeeklyChartDemoState extends State<WeeklyChartDemo> {
  final rng = Random();
  List<BookingStatus> weeklyStatus = [];

  @override
  void initState() {
    createRandomWeeklyStatus();
    super.initState();
  }

  // Method to handle item selection from the dropdown
  void _onDropDownItemChanged(String? newValue) {
    setState(() {
      _selectedItem = newValue ?? 'Tap to select'; // Handle null value if needed
    });
  }

  // Method to generate dropdown items
  List<DropdownMenuItem<String>> _getDropDownMenuItems() {
    List<String> items = ['Last 7 days', 'Last 30 days', 'This month', 'Last 12 months'];

    return items.map((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();
  }


  void createRandomWeeklyStatus() {
    weeklyStatus.clear();
    final List<BookingStatus> weeklyData = [];
    WeekDay.values
        .map(
          (day) => weeklyData.add(BookingStatus(
          dateTime: DateTime.now().add(
            Duration(days: day.index),
          ),
          bookings: {
            'Unfilled booking': rng.nextInt(50),
            'Filled booking': rng.nextInt(20),
          },
          )),
    )
        .toList();
    setState(() {
      weeklyStatus = weeklyData;
    });
  }

  String _selectedItem = "Last 7 days";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [

          Padding(
            padding: const EdgeInsets.only(top: 0,left: 15,bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                Text("Summary: ",
                style: TextStyle(color: Colors.black.withOpacity(0.6),fontWeight: FontWeight.bold,fontSize: 15),),

                const SizedBox(width: 5,),


                DropdownButton<String>(
                  value: _selectedItem,
                  style: const TextStyle(fontSize: 15,fontWeight: FontWeight.normal,color: Color(0xff750e33)),
                  hint: const Text('Tap to select',
                  style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,color: Color(
                      0xff750e33)),), // Displayed when no item is selected
                  onChanged: _onDropDownItemChanged, // Call this method when an item is selected
                  items: _getDropDownMenuItems(), // List of dropdown items
                ),

              ],
            ),
          ),

          StackedChart(
            data: weeklyStatus,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            size: const Size(330, 150),
            showLabel: true,
            enableShadow: false,
            barWidth: 10,

          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Container(
                margin: const EdgeInsets.only(right: 5),
                constraints: const BoxConstraints(
                  maxHeight: 10,
                  maxWidth: 20
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10)
                ),
              ),

              Text("All Events",
                style: TextStyle(color: Colors.black.withOpacity(0.6),fontWeight: FontWeight.bold,fontSize: 12),),

              const SizedBox(width: 20,),

              Container(
                margin: const EdgeInsets.only(right: 5),
                constraints: const BoxConstraints(
                    maxHeight: 10,
                    maxWidth: 20
                ),
                decoration: BoxDecoration(
                    color: appPrimary,
                    borderRadius: BorderRadius.circular(10)
                ),
              ),

              Text("Completed",
                style: TextStyle(color: Colors.black.withOpacity(0.6),fontWeight: FontWeight.bold,fontSize: 12),)

            ],
          ),
        ],
      ),
    );
  }
}

class BookingStatus extends ChartData<LabelData, int>
    implements Comparable<BookingStatus> {
  final DateTime dateTime;
  final Map<String, int> bookings;
  final VoidCallback? onPressed;

  static Map<LabelData, int> convertBookingToMapOfLabelDataInt(
      Map<String, int> bookings) {
    final Map<LabelData, int> convertedData = {};
    bookings.entries
        .map((e) => convertedData.addAll({LabelData(e.key): e.value}))
        .toList();
    return convertedData;
  }

  int get totalBookingCount =>
      bookings.values.reduce((total, value) => total = total + value);

  BookingStatus(
      {required this.dateTime, this.bookings = const {}, this.onPressed})
      : super(
    labelWithValue: convertBookingToMapOfLabelDataInt(bookings),
    barLabel: dateTime.day.toString(),
    onPressed: onPressed,
  );

  @override
  int compareTo(BookingStatus other) => dateTime.compareTo(other.dateTime);
}