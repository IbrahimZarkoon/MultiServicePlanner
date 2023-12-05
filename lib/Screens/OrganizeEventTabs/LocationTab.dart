import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../CustomWidgets/TimeCon.dart';
import '../../Enums/Colors.dart';
import '../../Organizer/Widgets/PriceRangeFilter.dart';
import '../../modals/OrganizeEventProvider.dart';

class LocationTab extends StatefulWidget {
  const LocationTab({Key? key}) : super(key: key);

  @override
  State<LocationTab> createState() => _LocationTabState();
}

class _LocationTabState extends State<LocationTab>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  FocusNode F1 = FocusNode();
  TextEditingController T1 = TextEditingController();

  ScrollController _scrollC = ScrollController();

  bool Days = false;
  bool Weekly = false;

  List<bool> weekDays = [false, false, false, false, false, false, false];

  List<bool> _week = [false, false, false, false];

  bool _showTextField = false;

  bool repetative = false;
  int _selectedOptionIndex = 0;

  // final Map<int, Widget> _options = {
  //   0: const Text('In door'),
  //   1: const Text('Out door'),
  // };

  List<DateTime?> _dialogCalendarPickerValue = [
    // DateTime(2021, 8, 10),
    // DateTime(2021, 8, 13),
  ];

  bool _tap = false;

  @override
  void initState() {
    // TODO: implement initState
    T1.text = "NewYork, NY";

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
          milliseconds: 750), // Adjust the duration of the animation.
    );

    _animation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut, // Adjust the animation curve.
    ));

    // Start the animation when the screen is loaded.
    _controller.forward();

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    F1.dispose();
    T1.dispose();
    super.dispose();
  }

  List<String> days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  List<String> week = ['Week 1', 'Week 2', 'Week 3', 'Week 4'];

  @override
  Widget build(BuildContext context) {

    var OrgEventProv = Provider.of<OrganizeEventProvider>(context,listen:false);

    return GestureDetector(
      onTap: () {
        setState(() {
          _tap = false;
          F1.unfocus();
        });
      },
      child: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(15),
        child: SlideTransition(
          position: _animation,
          child: SingleChildScrollView(
            controller: _scrollC,
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              //crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  "Where will your event be located?",
                  style: TextStyle(
                      fontFamily: "Helvetica_Bold",
                      color: Colors.black.withOpacity(0.8),
                      fontSize: 32),
                ),

                const SizedBox(
                  height: 15,
                ),

                Text(
                  "MSP events meet locally, in person and online. We'll connect you with people in your area and more can join you online.",
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.8), fontSize: 15),
                ),

                //Toggle Indoor/ Outdoor
                // Container(
                //   width: MediaQuery.of(context).size.width,
                //   decoration: const BoxDecoration(),
                //   margin: const EdgeInsets.only(top: 15,bottom: 15),
                //
                //   child: CupertinoSegmentedControl(
                //
                //     padding: const EdgeInsets.all(0),
                //     selectedColor: appPrimary,
                //     unselectedColor: const Color(0xffffffff),
                //     borderColor: appPrimary,
                //     children: _options,
                //     groupValue: _selectedOptionIndex,
                //     onValueChanged: (value) {
                //       setState(() {
                //         _selectedOptionIndex = value;
                //       });
                //     },
                //   ),
                // ),

                const SizedBox(
                  height: 10,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Enter location",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.8),
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
                  ],
                ),

                //Location Container
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _tap = true;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 15),
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 0, bottom: 0),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: _tap
                                ? appPrimary
                                : Colors.black.withOpacity(0.5)),
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          CupertinoIcons.location,
                          size: 20,
                          color:
                              _tap ? appPrimary : Colors.black.withOpacity(0.5),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                            child: TextField(
                          onTap: () {
                            setState(() {
                              _tap = true;
                            });

                          },
                          focusNode: F1,
                          controller: T1,
                          cursorColor: appPrimary,
                              onChanged: (String value)
                              {
                                OrgEventProv.location = T1.text;
                              },
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.black.withOpacity(0.8)),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search cities or ZIP codes",
                            hintStyle: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 13),
                          ),
                        )),
                        _tap
                            ? InkWell(
                                onTap: () {
                                  setState(() {
                                    T1.text = "";
                                    _tap = false;
                                    F1.unfocus();
                                  });
                                },
                                child: Icon(
                                  CupertinoIcons.xmark_circle_fill,
                                  color: Colors.black.withOpacity(0.5),
                                  size: 20,
                                ))
                            : const SizedBox(),
                      ],
                    ),
                  ),
                ),


                TimeSelectionContainer(),

                PriceRangeFilter()

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //
                //   children: [
                //     Text("Duration",
                //         overflow: TextOverflow.ellipsis,
                //         style: TextStyle(
                //             color: Colors.black.withOpacity(0.8),
                //             fontWeight: FontWeight.bold,
                //             fontSize: 16)),
                //   ],
                // ),
                //
                // //Duration Container
                // GestureDetector(
                //   onTap: ()
                //   {
                //
                //   },
                //   child: Container(
                //     margin: const EdgeInsets.only(top: 10,bottom: 15),
                //     padding: const EdgeInsets.only(left: 15,right: 15,top: 0,bottom: 0),
                //     decoration: BoxDecoration(border: Border.all(color: _tap? const Color(0xffff1f6f) : Colors.black.withOpacity(0.5)),
                //         borderRadius: BorderRadius.circular(8)
                //     ),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.start,
                //       crossAxisAlignment: CrossAxisAlignment.center,
                //       children: [
                //
                //         Icon(CupertinoIcons.timer,size: 20,color: _tap? const Color(0xffff1f6f) : Colors.black.withOpacity(0.5),),
                //
                //         const SizedBox(width: 15,),
                //
                //         Expanded(
                //             child: TextField(
                //               onTap: ()
                //               {
                //
                //               },
                //               focusNode: F1,
                //               //controller: T1,
                //               cursorColor: const Color(0xffff1f6f),
                //               style: TextStyle(fontSize: 13,color: Colors.black.withOpacity(0.8)),
                //               decoration: InputDecoration(
                //                 border: InputBorder.none,
                //                 hintText: "Duration",
                //                 hintStyle: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: 13),
                //
                //               ),
                //             )
                //         ),
                //
                //         _tap?
                //         InkWell(
                //             onTap: ()
                //             {
                //               setState(() {
                //                 T1.text = "";
                //                 _tap = false;
                //                 F1.unfocus();
                //
                //               });
                //             },
                //             child: Icon(CupertinoIcons.xmark_circle_fill,color: Colors.black.withOpacity(0.5),size: 20,))
                //             :
                //         const SizedBox(),
                //       ],
                //     ),
                //   ),
                // ),
                //
                //             Row(
                //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //
                //               children: [
                //
                //                 Text("Repetative event",style: TextStyle(
                //                     color: Colors.black.withOpacity(repetative? 0.8 : 0.4),
                //                     fontWeight: FontWeight.bold,
                //                     fontSize: 16)),
                //
                //                 CupertinoSwitch(value: repetative, activeColor:  appPrimary,onChanged: (value) {
                //                   setState(() {
                //                     repetative = value;
                //                     if(value == true)_scrollC.animateTo(_scrollC.position.maxScrollExtent+MediaQuery.of(context).size.height*0.1, duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
                //
                //                   });
                //
                //                 }
                //
                // )
                //
                //               ]
                //             ),
                //
                //             repetative? Row(
                //
                //               //Days Checkbox
                //               children: [
                //                 Expanded(
                //                   child: CheckboxListTile(
                //                     checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                //                     title: Text('Days',style: TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 13),),
                //                     value: Days,
                //                     activeColor:  appPrimary,
                //                     onChanged: (value) {
                //                       setState(() {
                //                         Days = value!;
                //                         Weekly = false;
                //                         _showTextField = Days || Weekly ;
                //                         if(Days == true)_scrollC.animateTo(_scrollC.position.maxScrollExtent+MediaQuery.of(context).size.height*0.3, duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
                //                       });
                //                     },
                //                   ),
                //                 ),
                //
                //                 Container(
                //                   width: 1,
                //                   height: 20,
                //                   color: Colors.black.withOpacity(0.15),
                //                 ),
                //
                //                 Expanded(
                //                   child: CheckboxListTile(
                //                     activeColor: appPrimary,
                //                     checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                //
                //                     title: Text('Weekly',style: TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 13),),
                //                     value: Weekly,
                //                     onChanged: (value) {
                //                       setState(() {
                //                         Weekly = value!;
                //                         Days = false;
                //                         _showTextField = Days || Weekly ;
                //                         if(Weekly == true)_scrollC.animateTo(_scrollC.position.maxScrollExtent+MediaQuery.of(context).size.height*0.2, duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
                //                       });
                //                     },
                //                   ),
                //                 ),
                //
                //               ],
                //             ) : const SizedBox(),
                //
                //             _showTextField ?
                //             Days?
                //
                //                 //Days Column
                //             Wrap(
                //               spacing: 15, // spacing between the interest containers
                //               runSpacing: 15,
                //               children: [
                //                 for (int index = 0; index < days.length; index++)
                //                   GestureDetector(
                //                     onTap: () {
                //                       setState(() {
                //                         weekDays[index] = !weekDays[index];
                //                       });
                //                     },
                //                     child: Container(
                //                       constraints: const BoxConstraints(
                //                         minWidth: 150, maxWidth: 160
                //                       ),
                //                       padding: const EdgeInsets.all(10),
                //                       margin: const EdgeInsets.only(bottom: 10),
                //                       decoration: BoxDecoration(
                //                         border: Border.all(
                //                           color: weekDays[index] ? appPrimary : Colors.black.withOpacity(0.6)
                //                         ),
                //                         color: weekDays[index] ?  appPrimary : Colors.white,
                //                         borderRadius: BorderRadius.circular(8),
                //                       ),
                //                       child: Center(
                //                         child: Text(
                //                           "${days[index]}",
                //                           style: TextStyle(
                //                             fontSize: 12,
                //                             color: weekDays[index] ? Colors.white : Colors.black.withOpacity(0.6),
                //                             fontWeight:  FontWeight.bold
                //                           ),
                //                         ),
                //                       ),
                //                     ),
                //                   ),
                //               ],
                //             )
                //                 :
                //                 //Weeks Column
                //             Wrap(
                //                 spacing: 15, // spacing between the interest containers
                //                 runSpacing: 15,
                //               children: [
                //                 for (int index = 0; index < week.length; index++)
                //                   GestureDetector(
                //                     onTap: () {
                //                       setState(() {
                //                         _week[index] = !_week[index];
                //                       });
                //                     },
                //                     child: Container(
                //                       constraints: const BoxConstraints(
                //                           minWidth: 150, maxWidth: 160
                //                       ),
                //                       padding: const EdgeInsets.all(10),
                //                       margin: const EdgeInsets.only(bottom: 10),
                //                       decoration: BoxDecoration(
                //                         border: Border.all(
                //                             color: _week[index] ? appPrimary : Colors.black.withOpacity(0.6)
                //                         ),
                //                         color: _week[index] ? appPrimary : Colors.white,
                //                         borderRadius: BorderRadius.circular(8),
                //                       ),
                //                       child: Center(
                //                         child: Text(
                //                           "${week[index]}",
                //                           style: TextStyle(
                //                               fontSize: 12,
                //                               color: _week[index] ? Colors.white : Colors.black.withOpacity(0.6),
                //                               fontWeight:  FontWeight.bold
                //                           ),
                //                         ),
                //                       ),
                //                     ),
                //                   ),
                //               ],
                //             )
                //                 : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getValueText(
    CalendarDatePicker2Type datePickerType,
    List<DateTime?> values,
  ) {
    values =
        values.map((e) => e != null ? DateUtils.dateOnly(e) : null).toList();
    var valueText = (values.isNotEmpty ? values[0] : null)
        .toString()
        .replaceAll('00:00:00.000', '');

    if (datePickerType == CalendarDatePicker2Type.multi) {
      valueText = values.isNotEmpty
          ? values
              .map((v) => v.toString().replaceAll('00:00:00.000', ''))
              .join(', ')
          : 'null';
    } else if (datePickerType == CalendarDatePicker2Type.range) {
      if (values.isNotEmpty) {
        final startDate = values[0].toString().replaceAll('00:00:00.000', '');
        final endDate = values.length > 1
            ? values[1].toString().replaceAll('00:00:00.000', '')
            : 'null';
        valueText = '$startDate to $endDate';
      } else {
        return 'null';
      }
    }

    return valueText;
  }

  _buildCalendarDialogButton() {
    const dayTextStyle =
        TextStyle(color: Colors.black, fontWeight: FontWeight.w700);
    final weekendTextStyle =
        TextStyle(color: Colors.grey[500], fontWeight: FontWeight.w600);
    final anniversaryTextStyle = TextStyle(
      color: Colors.red[400],
      fontWeight: FontWeight.w700,
      decoration: TextDecoration.underline,
    );
    final config = CalendarDatePicker2WithActionButtonsConfig(
      dayTextStyle: dayTextStyle,
      calendarType: CalendarDatePicker2Type.range,
      selectedDayHighlightColor: appPrimary,
      closeDialogOnCancelTapped: true,
      firstDayOfWeek: 1,
      weekdayLabelTextStyle: const TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.bold,
      ),
      controlsTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
      centerAlignModePicker: true,
      customModePickerIcon: const SizedBox(),
      selectedDayTextStyle: dayTextStyle.copyWith(color: Colors.white),
      selectableDayPredicate: (day) => !day
          .difference(DateTime.now().subtract(const Duration(days: 1)))
          .isNegative,
      dayTextStylePredicate: ({required date}) {
        TextStyle? textStyle;
        if (date.weekday == DateTime.saturday ||
            date.weekday == DateTime.sunday) {
          textStyle = weekendTextStyle;
        }
        if (DateUtils.isSameDay(date, DateTime(2021, 1, 25))) {
          textStyle = anniversaryTextStyle;
        }
        return textStyle;
      },
      dayBuilder: ({
        required date,
        textStyle,
        decoration,
        isSelected,
        isDisabled,
        isToday,
      }) {
        Widget? dayWidget;
        if (date.day % 3 == 0 && date.day % 9 != 0) {
          dayWidget = Container(
            decoration: decoration,
            child: Center(
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Text(
                    MaterialLocalizations.of(context).formatDecimal(date.day),
                    style: textStyle,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 27.5),
                    child: Container(
                      height: 4,
                      width: 4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: isSelected == true
                            ? Colors.white
                            : Colors.grey[500],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return dayWidget;
      },
      yearBuilder: ({
        required year,
        decoration,
        isCurrentYear,
        isDisabled,
        isSelected,
        textStyle,
      }) {
        return Center(
          child: Container(
            decoration: decoration,
            height: 36,
            width: 72,
            child: Center(
              child: Semantics(
                selected: isSelected,
                button: true,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      year.toString(),
                      style: textStyle,
                    ),
                    if (isCurrentYear == true)
                      Container(
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.only(left: 5),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.redAccent,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
    return InkWell(
        onTap: () async {
          final values = await showCalendarDatePicker2Dialog(
            context: context,
            config: config,
            dialogSize: const Size(325, 400),
            borderRadius: BorderRadius.circular(15),
            value: _dialogCalendarPickerValue,
            dialogBackgroundColor: Colors.white,
          );
          if (values != null) {
            // ignore: avoid_print
            print(_getValueText(
              config.calendarType,
              values,
            ));
            setState(() {
              _dialogCalendarPickerValue = values;
            });
          }
        },
        child: Container(
          margin: const EdgeInsets.only(top: 5, bottom: 5, right: 5),
          padding:
              const EdgeInsets.only(left: 25, right: 25, top: 8, bottom: 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: appPrimary),
          alignment: Alignment.center,
          child: const Text(
            "Select date",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ));
  }

  ///

  Widget dayTab(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        //Date Reserved Heading
        Container(
          padding: const EdgeInsets.only(top: 0, bottom: 10, left: 0, right: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Select date",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.8),
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
            ],
          ),
        ),

        //Date Reserved Container
        Container(
          constraints: const BoxConstraints(maxHeight: 50),
          margin: const EdgeInsets.only(top: 0, bottom: 15, left: 0, right: 0),
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
                  child: RichText(
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(
                        text: _dialogCalendarPickerValue.isEmpty
                            ? "Select date"
                            : _dialogCalendarPickerValue.length == 2
                                ? "${_dialogCalendarPickerValue[0]?.day ?? ""}-${_dialogCalendarPickerValue[0]?.month ?? ""}-${_dialogCalendarPickerValue[0]?.year ?? ""}"
                                    " - ${_dialogCalendarPickerValue[1]?.day ?? ""}-${_dialogCalendarPickerValue[1]?.month ?? ""}-${_dialogCalendarPickerValue[1]?.year ?? ""} "
                                : "${_dialogCalendarPickerValue[0]?.day ?? ""}-${_dialogCalendarPickerValue[0]?.month ?? ""}-${_dialogCalendarPickerValue[0]?.year ?? ""}",
                        style: TextStyle(
                            fontSize: 12, color: Colors.black.withOpacity(0.8)),
                      ),

                      // TextSpan(
                      //   text:
                      //   " to ${_dialogCalendarPickerValue[1]?.day ?? ""}-${_dialogCalendarPickerValue[1]?.month ?? ""}-${_dialogCalendarPickerValue[1]?.year ?? ""}"
                      // )
                    ]),
                  ),
                ),
              ),
              _buildCalendarDialogButton()
            ],
          ),
        ),
      ],
    );
  }
}
