import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_datetime_picker_bdaya/flutter_datetime_picker_bdaya.dart';
import 'package:intl/intl.dart';

import '../Organizer/Widgets/CustomPicker.dart';

class TimeSelectionContainer extends StatefulWidget {
  @override
  _TimeSelectionContainerState createState() => _TimeSelectionContainerState();
}

class _TimeSelectionContainerState extends State<TimeSelectionContainer> {
  late DateTime _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedTime = DateTime.now();
  }
  //
  // Future<void> _selectTime(BuildContext context) async {
  //   final TimeOfDay? picked = await showTimePicker(
  //
  //     context: context,
  //     initialTime: _selectedTime,
  //   );
  //   if (picked != null && picked != _selectedTime) {
  //     setState(() {
  //       _selectedTime = picked;
  //     });
  //   }
  // }
  //
  //CustomPicker timePicker = CustomPicker();

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text("Select starting time",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Colors.black.withOpacity(0.8),
                  fontWeight: FontWeight.bold,
                  fontSize: 16)),

          // Text(
          //   'Selected Time:',
          //   style: TextStyle(fontSize: 16.0),
          // ),
          const SizedBox(height: 8.0),

          InkWell(
            onTap: () async{
              DateTime? pickedTime = await DatePickerBdaya.showPicker(context, showTitleActions: true,
                  // onChanged: (date) {
                  //   debugPrint(
                  //       'change $date in time zone ${date.timeZoneOffset.inHours}');
                  // },
                  // onConfirm: (date) {
                  //   debugPrint('confirm $date');
                  // },
                  pickerModel: CustomPicker(currentTime: DateTime.now()),
                  locale: LocaleType.en);

              if (pickedTime != null) {
                setState(() {
                  _selectedTime = pickedTime;
                });
              }
            },
            // onTap: () async {
            //   DateTime? pickedTime = await DatePickerBdaya.showTimePicker(
            //     context,
            //     showTitleActions: true,
            //     onChanged: (date) {
            //     },
            //     onConfirm: (date) {
            //       //debugPrint('confirm $date');
            //     },
            //     currentTime: DateTime.now(),
            //
            //   );
            //
            //   if (pickedTime != null) {
            //     setState(() {
            //       _selectedTime = pickedTime;
            //     });
            //   }
            // },
            child: Container(
              constraints: BoxConstraints(
                maxHeight: 50
              ),
              margin: const EdgeInsets.only(
                  top: 0, bottom: 15, left: 0, right: 0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        DateFormat('h:mm a').format(_selectedTime),
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.black.withOpacity(0.8)),
                      ),
                    ),
                  ),

                  Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color(0xffff1f6f),
                      ),
                      padding: const EdgeInsets.only(left: 20,right: 20,top: 8,bottom: 8),
                      margin: const EdgeInsets.only(top: 5,bottom: 5,right: 5),
                      child: const Text('Select time',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 12),))

                ],
              ),
            ),
          ),



        ],
      ),
    );
  }
}