import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:socialapp/CustomWidgets/Headings.dart';
import 'package:socialapp/Organizer/OrgScreens/OrgSingleEvent.dart';
import 'package:socialapp/Organizer/Widgets/SummaryChart.dart';
import 'package:socialapp/Organizer/Widgets/TopStatusSlider.dart';
import 'package:socialapp/Organizer/Widgets/dotsList.dart';
import 'package:socialapp/Organizer/Widgets/homeAcc.dart';
import 'package:stacked_chart/stacked_chart.dart';
import '../../Providers/CacheManager.dart';
import '../../Screens/OrganizeEvent.dart';
import 'package:pie_chart/pie_chart.dart';
import '../Widgets/pastEventSlider.dart';
import '../Widgets/pieChart.dart';

class OrgHomePage extends StatefulWidget {
  const OrgHomePage({Key? key}) : super(key: key);

  @override
  State<OrgHomePage> createState() => _OrgHomePageState();
}

class _OrgHomePageState extends State<OrgHomePage> with SingleTickerProviderStateMixin{

  bool upcoming = true;
  bool past = false;
  bool topC = true;
  late TabController _tabController;
  //ScrollController _upcomingCon = ScrollController();
  int _initialIndex = 0;

  Map<String, double> dataMap = {
    "Completed": 7,
    "Upcoming": 3,
    "Cancelled": 4,
  };


  // _upcomingListener()
  // {
  //   if (_upcomingCon.offset >= _upcomingCon.position.minScrollExtent + 50 && topC == true) {
  //     setState(() {
  //       topC = false;
  //     });
  //   }
  //
  //   if (_upcomingCon.offset <=
  //       _upcomingCon.position.minScrollExtent + 20 && topC == false) {
  //     setState(() {
  //       topC = true;
  //     });
  //   }
  // }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String _selectedItem = "Last 7 days";

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

  @override
  Widget build(BuildContext context) {

    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    final cacheManager = Provider.of<CacheManagerProvider>(context).cacheManager;



    return Scaffold(
      backgroundColor: Colors.white,

      floatingActionButton: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white.withOpacity(0.95),width: 5),
          borderRadius: BorderRadius.circular(100)
        ),
        child: FloatingActionButton(
          onPressed: () { Navigator.push(context, CupertinoPageRoute(builder: (BuildContext context) => const OrganizeEvent())); },
          elevation: 5,
          backgroundColor: const Color(0xffff1f6f),
          child: Container(

            decoration: BoxDecoration(

              color: const Color(0xffff1f6f),
              borderRadius: BorderRadius.circular(100),

            ),
            child: const Icon(CupertinoIcons.add,color: Colors.white,),
          ),
        ),
      ),

      body: DefaultTabController(
        length: 2,
        initialIndex: _initialIndex,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              //Top Status ListView
              topStatusSlider(context),

              thickBorder(context),

              Headings(context, "Analytics"),


              AnimatedContainer(
                duration: Duration(milliseconds: topC ? 500 : 500),
                curve: Curves.easeIn,
                padding: EdgeInsets.only(top: 0, bottom: topC ? 15 : 0),
                margin: EdgeInsets.only(top: topC ? 0 : 0, left: 15, right: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 1.5,
                      spreadRadius: 1,
                      offset: const Offset(0, 0),
                    )
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 0,left: 15,bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [

                          Text("Summary: ",
                            style: TextStyle(color: Colors.black.withOpacity(0.6),fontWeight: FontWeight.bold,fontSize: 15),),

                          const SizedBox(width: 5,),


                          DropdownButton<String>(
                            value: _selectedItem,
                            elevation: 1,
                            dropdownColor: Colors.white,
                            icon: Icon(Icons.keyboard_arrow_down,size: 20,color: Colors.black.withOpacity(0.8),),
                            style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color: Colors.black.withOpacity(0.8)),
                            hint: Text('Tap to select',
                              style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color: Colors.black.withOpacity(0.8)),), // Displayed when no item is selected
                            onChanged: _onDropDownItemChanged, // Call this method when an item is selected
                            items: _getDropDownMenuItems(), //
                            borderRadius: BorderRadius.circular(10),
                            // List of dropdown items
                          ),

                        ],
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width/2,
                            height: MediaQuery.of(context).size.height*0.2,
                            child: MyPieChart()),

                        const SizedBox(width: 20,),

                        //Legends Column
                        Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [

                              //Completed Events Row
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,

                                children: [

                                  Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    width: 20,height: 20,
                                    decoration: BoxDecoration(
                                        color: const Color(0xffff1f6f),
                                        borderRadius: BorderRadius.circular(100)
                                    ),
                                  ),

                                  const Text("Completed Events",
                                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),)

                                ],
                              ),

                              const SizedBox(height: 5),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,

                                children: [

                                  Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    width: 20,height: 20,
                                    decoration: BoxDecoration(
                                        color: const Color(0xff7173ab),
                                        borderRadius: BorderRadius.circular(100)
                                    ),
                                  ),

                                  const Text("Up-coming Events",
                                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),)

                                ],
                              ),

                              const SizedBox(height: 5),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,

                                children: [

                                  Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    width: 20,height: 20,
                                    decoration: BoxDecoration(
                                        color: const Color(0xffed8c8e),
                                        borderRadius: BorderRadius.circular(100)
                                    ),
                                  ),

                                  const Text("Cancelled Events",
                                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),)

                                ],
                              ),


                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),


              Container(
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.black.withOpacity(0.2), width: 0.5)),
                ),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                  padding: const EdgeInsets.all(0),
                  constraints: const BoxConstraints(maxHeight: 34.5),
                  decoration: BoxDecoration(
                    color: const Color(0xffffffff),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 1,
                        spreadRadius: 1,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  child: TabBar(
                    onTap: (index) {
                      setState(() {
                        _tabController.index = index;
                      });
                    },
                    padding: const EdgeInsets.all(0),
                    labelPadding: const EdgeInsets.all(0),
                    controller: _tabController,
                    labelColor: const Color(0xffffffff),
                    indicator: null,
                    indicatorPadding: EdgeInsets.zero,
                    indicatorColor: Colors.transparent,
                    indicatorWeight: 0.01,
                    unselectedLabelColor: Colors.black.withOpacity(0.5),
                    labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                      tabs: [

                        Tab(
                          iconMargin: EdgeInsets.zero,

                          icon: const SizedBox(),
                          //text: "Upcoming",
                          child: Container(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: _tabController.index == 0
                                    ? const Color(0xffff1f6f)
                                    : Colors.transparent,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    bottomLeft: Radius.circular(15))),
                            child: const Text(
                              "Upcoming",
                            ),
                          ),
                        ),

                        Tab(
                          iconMargin: EdgeInsets.zero,
                          icon: const SizedBox(),
                          //text: "Upcoming",
                          child: Container(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            decoration: BoxDecoration(
                                color: _tabController.index == 0
                                    ? Colors.transparent
                                    : const Color(0xffff1f6f),
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(15),
                                    bottomRight: Radius.circular(15))),
                            alignment: Alignment.center,
                            child: const Text(
                              "Past",
                            ),
                          ),
                        ),

                        // //Upcoming Tab
                        // InkWell(
                        //   onTap: () {
                        //     if (_initialIndex != 0) {
                        //       setState(() {
                        //         upcoming = true;
                        //         _initialIndex = 0;
                        //         _tabController.index = 0;
                        //       });
                        //     }
                        //   },
                        //   child: Container(
                        //     padding: EdgeInsets.only(top: 10, bottom: 10),
                        //     alignment: Alignment.center,
                        //     decoration: BoxDecoration(
                        //         color: upcoming
                        //             ? Color(0xffff1f6f)
                        //             : Colors.transparent,
                        //         borderRadius: BorderRadius.only(
                        //             topLeft: Radius.circular(15),
                        //             bottomLeft: Radius.circular(15))),
                        //     child: Text(
                        //       "Upcoming",
                        //     ),
                        //   ),
                        // ),
                        //
                        // //Past Tab
                        // InkWell(
                        //   onTap: () {
                        //     if (_initialIndex != 1) {
                        //       setState(() {
                        //         upcoming = false;
                        //         _initialIndex = 1;
                        //         _tabController.index = 1;
                        //       });
                        //     }
                        //   },
                        //   child: Container(
                        //     padding: EdgeInsets.only(top: 10, bottom: 10),
                        //     decoration: BoxDecoration(
                        //         color: upcoming
                        //             ? Colors.transparent
                        //             : Color(0xffff1f6f),
                        //         borderRadius: BorderRadius.only(
                        //             topRight: Radius.circular(15),
                        //             bottomRight: Radius.circular(15))),
                        //     alignment: Alignment.center,
                        //     child: Text(
                        //       "Past",
                        //     ),
                        //   ),
                        // ),
                      ]
                  ),
                ),
              ),


              Flexible(
                fit: FlexFit.loose,
                child: Container(
                  constraints: BoxConstraints(
                    minHeight: 250,maxHeight: MediaQuery.of(context).size.height
                  ),
                  child: TabBarView(
                    controller: _tabController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [

                      UpcomingTab(context),
                      PastTab(context),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),


      // body: SingleChildScrollView(
      //   //primary: true,
      //   physics:BouncingScrollPhysics(),
      //   child: Container(
      //     height: MediaQuery.of(context).size.height,
      //     child: DefaultTabController(
      //       length: 2,
      //       initialIndex: _initialIndex,
      //       child: Column(
      //         children: [
      //
      //           Headings(context, "Analytics"),
      //
      //           /// //Chart Container
      //           AnimatedContainer(
      //             //height: topC ? 250 : 0,
      //             duration: Duration(milliseconds: topC ? 500 : 500),
      //             curve: Curves.easeIn,
      //             padding: EdgeInsets.only(top: 0, bottom: topC ? 15 : 0),
      //             margin:
      //                 EdgeInsets.only(top: topC ? 0 : 0, left: 15, right: 15),
      //             decoration: BoxDecoration(
      //               color: Colors.white,
      //               boxShadow: [
      //                 BoxShadow(
      //                   color: Colors.black.withOpacity(0.15),
      //                   blurRadius: 1.5,
      //                   spreadRadius: 1,
      //                   offset: Offset(0, 0),
      //                 )
      //               ],
      //               borderRadius: BorderRadius.circular(10),
      //             ),
      //             width: MediaQuery.of(context).size.width,
      //             //height: height*0.25,
      //             child: Column(
      //               children: [
      //                 Padding(
      //                   padding: const EdgeInsets.only(top: 0,left: 15,bottom: 5),
      //                   child: Row(
      //                     mainAxisAlignment: MainAxisAlignment.start,
      //                     children: [
      //
      //                       Text("Summary: ",
      //                         style: TextStyle(color: Colors.black.withOpacity(0.6),fontWeight: FontWeight.bold,fontSize: 15),),
      //
      //                       const SizedBox(width: 5,),
      //
      //
      //                       DropdownButton<String>(
      //                         value: _selectedItem,
      //                         elevation: 1,
      //                         dropdownColor: Colors.white,
      //                         icon: Icon(Icons.keyboard_arrow_down,size: 20,color: Color(0xffff1f6f),),
      //                         style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal,color: Color(0xffff1f6f)),
      //                         hint: Text('Tap to select',
      //                           style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal,color: Color(
      //                               0xffff1f6f)),), // Displayed when no item is selected
      //                         onChanged: _onDropDownItemChanged, // Call this method when an item is selected
      //                         items: _getDropDownMenuItems(), //
      //                         borderRadius: BorderRadius.circular(10),
      //                         // List of dropdown items
      //                       ),
      //
      //                     ],
      //                   ),
      //                 ),
      //
      //                 Row(
      //                   mainAxisAlignment: MainAxisAlignment.start,
      //                   crossAxisAlignment: CrossAxisAlignment.center,
      //                   children: [
      //                     SizedBox(
      //                         width: MediaQuery.of(context).size.width/2,
      //                         height: MediaQuery.of(context).size.height*0.2,
      //                         child: MyPieChart()),
      //
      //                     const SizedBox(width: 20,),
      //
      //                     //Legends Column
      //                     Flexible(
      //                       child: Column(
      //                         mainAxisAlignment: MainAxisAlignment.center,
      //                         crossAxisAlignment: CrossAxisAlignment.start,
      //                         mainAxisSize: MainAxisSize.min,
      //                         children: [
      //
      //                           //Completed Events Row
      //                           Row(
      //                             mainAxisAlignment: MainAxisAlignment.start,
      //                             crossAxisAlignment: CrossAxisAlignment.center,
      //
      //                             children: [
      //
      //                               Container(
      //                                 margin: EdgeInsets.only(right: 10),
      //                                 width: 20,height: 20,
      //                                 decoration: BoxDecoration(
      //                                   color: Color(0xffff1f6f),
      //                                   borderRadius: BorderRadius.circular(100)
      //                                 ),
      //                               ),
      //
      //                               Text("Completed Events",
      //                                 style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),)
      //
      //                             ],
      //                           ),
      //
      //                           const SizedBox(height: 5),
      //
      //                           Row(
      //                             mainAxisAlignment: MainAxisAlignment.start,
      //                             crossAxisAlignment: CrossAxisAlignment.center,
      //
      //                             children: [
      //
      //                               Container(
      //                                 margin: EdgeInsets.only(right: 10),
      //                                 width: 20,height: 20,
      //                                 decoration: BoxDecoration(
      //                                   color: Color(0xff26c3ff),
      //                                   borderRadius: BorderRadius.circular(100)
      //                                 ),
      //                               ),
      //
      //                               Text("Up-coming Events",
      //                                 style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),)
      //
      //                             ],
      //                           ),
      //
      //                           const SizedBox(height: 5),
      //
      //                           Row(
      //                             mainAxisAlignment: MainAxisAlignment.start,
      //                             crossAxisAlignment: CrossAxisAlignment.center,
      //
      //                             children: [
      //
      //                               Container(
      //                                 margin: EdgeInsets.only(right: 10),
      //                                 width: 20,height: 20,
      //                                 decoration: BoxDecoration(
      //                                   color: Color(0xffff2929),
      //                                   borderRadius: BorderRadius.circular(100)
      //                                 ),
      //                               ),
      //
      //                               Text("Cancelled Events",
      //                                 style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),)
      //
      //                             ],
      //                           ),
      //
      //
      //                         ],
      //                       ),
      //                     )
      //                   ],
      //                 ),
      //               ],
      //             ),
      //           ),
      //
      //
      //           // //Pie Chart
      //           // Container(
      //           //   padding: EdgeInsets.only(left: 15,right: 15,top: 15,bottom: 15),
      //           //   child: Row(
      //           //     mainAxisAlignment: MainAxisAlignment.start,
      //           //     children: [
      //           //       SizedBox(
      //           //         width: MediaQuery.of(context).size.width/2,
      //           //           height: MediaQuery.of(context).size.height*0.2,
      //           //           child: MyPieChart()),
      //           //
      //           //       const SizedBox(width: 20,),
      //           //
      //           //       //Legends Column
      //           //       Flexible(
      //           //         child: Column(
      //           //           mainAxisAlignment: MainAxisAlignment.start,
      //           //           crossAxisAlignment: CrossAxisAlignment.start,
      //           //
      //           //           children: [
      //           //
      //           //             //Completed Events Row
      //           //             Row(
      //           //               mainAxisAlignment: MainAxisAlignment.start,
      //           //               crossAxisAlignment: CrossAxisAlignment.center,
      //           //
      //           //               children: [
      //           //
      //           //                 Container(
      //           //                   margin: EdgeInsets.only(right: 10),
      //           //                   width: 20,height: 20,
      //           //                   color: Color(0xffff1f6f),
      //           //                 ),
      //           //
      //           //                 Text("Completed Events",
      //           //                 style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),)
      //           //
      //           //               ],
      //           //             ),
      //           //
      //           //             const SizedBox(height: 5),
      //           //
      //           //             Row(
      //           //               mainAxisAlignment: MainAxisAlignment.start,
      //           //               crossAxisAlignment: CrossAxisAlignment.center,
      //           //
      //           //               children: [
      //           //
      //           //                 Container(
      //           //                   margin: EdgeInsets.only(right: 10),
      //           //                   width: 20,height: 20,
      //           //                   color: Color(0xff26c3ff),
      //           //                 ),
      //           //
      //           //                 Text("Up-coming Events",
      //           //                   style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),)
      //           //
      //           //               ],
      //           //             ),
      //           //
      //           //             const SizedBox(height: 5),
      //           //
      //           //             Row(
      //           //               mainAxisAlignment: MainAxisAlignment.start,
      //           //               crossAxisAlignment: CrossAxisAlignment.center,
      //           //
      //           //               children: [
      //           //
      //           //                 Container(
      //           //                   margin: EdgeInsets.only(right: 10),
      //           //                   width: 20,height: 20,
      //           //                   color: Color(0xffff2929),
      //           //                 ),
      //           //
      //           //                 Text("Cancelled Events",
      //           //                   style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),)
      //           //
      //           //               ],
      //           //             ),
      //           //
      //           //
      //           //           ],
      //           //         ),
      //           //       )
      //           //     ],
      //           //   ),
      //           // ),
      //
      //           //Tab Bar
      //           Container(
      //             decoration: BoxDecoration(
      //                 border: Border(
      //                     bottom: BorderSide(
      //                         color: Colors.black.withOpacity(0.2), width: 0.5))),
      //             child: Container(
      //               margin: EdgeInsets.only(left: 15,right: 15,top: 30,bottom: 30),
      //               padding: EdgeInsets.all(0),
      //               constraints: BoxConstraints(
      //                 maxHeight: 34.5
      //               ),
      //               decoration: BoxDecoration(
      //                   color: Color(0xffffffff),
      //                   borderRadius: BorderRadius.circular(20),
      //                   boxShadow: [
      //                     BoxShadow(
      //                         color: Colors.black.withOpacity(0.1),
      //                         blurRadius: 1,
      //                         spreadRadius: 1,
      //                         offset: Offset(0, 0))
      //                   ]),
      //               child: TabBar(
      //                 onTap: (index)
      //                   {
      //                     setState(() {
      //                       _tabController.index = index;
      //                     });
      //                   },
      //                   padding: EdgeInsets.all(0),
      //                   labelPadding: EdgeInsets.all(0),
      //
      //                   controller: _tabController,
      //                   labelColor: Color(0xffffffff),
      //                   indicator: null,
      //                   indicatorPadding: EdgeInsets.zero,
      //                   indicatorColor: Colors.transparent,
      //                   indicatorWeight: 0.01,
      //                   unselectedLabelColor: Colors.black.withOpacity(0.5),
      //                   labelStyle:
      //                       TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
      //                   tabs: [
      //
      //                     Tab(
      //                       iconMargin: EdgeInsets.zero,
      //
      //                       icon: SizedBox(),
      //                       //text: "Upcoming",
      //                       child: Container(
      //                         padding: EdgeInsets.only(top: 10, bottom: 10),
      //                         alignment: Alignment.center,
      //                         decoration: BoxDecoration(
      //                             color: _tabController.index == 0
      //                                 ? Color(0xffff1f6f)
      //                                 : Colors.transparent,
      //                             borderRadius: BorderRadius.only(
      //                                 topLeft: Radius.circular(15),
      //                                 bottomLeft: Radius.circular(15))),
      //                         child: Text(
      //                           "Upcoming",
      //                         ),
      //                       ),
      //                     ),
      //
      //                     Tab(
      //                       iconMargin: EdgeInsets.zero,
      //                       icon: SizedBox(),
      //                       //text: "Upcoming",
      //                       child: Container(
      //                         padding: EdgeInsets.only(top: 10, bottom: 10),
      //                         decoration: BoxDecoration(
      //                             color: _tabController.index == 0
      //                                 ? Colors.transparent
      //                                 : Color(0xffff1f6f),
      //                             borderRadius: BorderRadius.only(
      //                                 topRight: Radius.circular(15),
      //                                 bottomRight: Radius.circular(15))),
      //                         alignment: Alignment.center,
      //                         child: Text(
      //                           "Past",
      //                         ),
      //                       ),
      //                     ),
      //
      //                     // //Upcoming Tab
      //                     // InkWell(
      //                     //   onTap: () {
      //                     //     if (_initialIndex != 0) {
      //                     //       setState(() {
      //                     //         upcoming = true;
      //                     //         _initialIndex = 0;
      //                     //         _tabController.index = 0;
      //                     //       });
      //                     //     }
      //                     //   },
      //                     //   child: Container(
      //                     //     padding: EdgeInsets.only(top: 10, bottom: 10),
      //                     //     alignment: Alignment.center,
      //                     //     decoration: BoxDecoration(
      //                     //         color: upcoming
      //                     //             ? Color(0xffff1f6f)
      //                     //             : Colors.transparent,
      //                     //         borderRadius: BorderRadius.only(
      //                     //             topLeft: Radius.circular(15),
      //                     //             bottomLeft: Radius.circular(15))),
      //                     //     child: Text(
      //                     //       "Upcoming",
      //                     //     ),
      //                     //   ),
      //                     // ),
      //                     //
      //                     // //Past Tab
      //                     // InkWell(
      //                     //   onTap: () {
      //                     //     if (_initialIndex != 1) {
      //                     //       setState(() {
      //                     //         upcoming = false;
      //                     //         _initialIndex = 1;
      //                     //         _tabController.index = 1;
      //                     //       });
      //                     //     }
      //                     //   },
      //                     //   child: Container(
      //                     //     padding: EdgeInsets.only(top: 10, bottom: 10),
      //                     //     decoration: BoxDecoration(
      //                     //         color: upcoming
      //                     //             ? Colors.transparent
      //                     //             : Color(0xffff1f6f),
      //                     //         borderRadius: BorderRadius.only(
      //                     //             topRight: Radius.circular(15),
      //                     //             bottomRight: Radius.circular(15))),
      //                     //     alignment: Alignment.center,
      //                     //     child: Text(
      //                     //       "Past",
      //                     //     ),
      //                     //   ),
      //                     // ),
      //                   ]),
      //             ),
      //           ),
      //
      //           //Tab Bar View
      //           Expanded(
      //             child: TabBarView(
      //               controller: _tabController,
      //               physics: NeverScrollableScrollPhysics(),
      //               children: [
      //                 UpcomingTab(context),
      //                 PastTab(context),
      //               ],
      //             ),
      //           )
      //         ],
      //       ),
      //     ),
      //   ),
      // ),

    );
  }

  Widget UpcomingTab(BuildContext context)
  {
    //_upcomingCon.addListener(_upcomingListener);

    return ListView.builder(
      itemCount: 4,
      shrinkWrap: true,
      padding: const EdgeInsets.only(bottom: 15),
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, index)
      {
        return Row(

          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            //Status Con
            Container(
              padding: const EdgeInsets.only(top: 15,left: 15,right: 15),
              constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width/4
              ),
              child: eventStatus(context),
            ),

            //Event Con
            Expanded(
              flex: 2,
              child: Container(
                //color: Colors.red,
                padding: const EdgeInsets.only(top: 15,bottom: 0,right: 15),
                child: eventCon(context,
                    "https://images.unsplash.com/photo-1556035511-3168381ea4d4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8bmlnaHQlMjBjbHVifGVufDB8fDB8fHww&w=1000&q=80"),

              ),
            )

          ],
        );
      }
    );
  }

  Widget PastTab(BuildContext context)
  {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 15),
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: 1,
      shrinkWrap: true,
      itemBuilder: (BuildContext context,index)
      {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,

          children: [

            Headings(context, "Ongoing Events"),

            //Recent Events Slider
            pastEventSlider(context),

            Headings(context, "Recent Events"),

            bottomEventsSlider(context)


          ],
        );
      },

    );
  }

  Widget eventCon(BuildContext context,String img)
  {
    return InkWell(
      onTap: () => showModalBottomSheet(
          isScrollControlled: true,
          context: context, builder: (BuildContext context) => OrgSingleEvent(title: "Metal Rock Festival", image: img,past: false,)),
      child: Stack(

        children: [
        Container(
          margin: const EdgeInsets.only(bottom: 15),
          width: MediaQuery.of(context).size.width,
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.2,
          ),
          foregroundDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(colors: [
              Colors.transparent,
              Colors.black.withOpacity(0.6),

            ],
            begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.3,0.45]

            )
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [

              BoxShadow(color: Colors.black.withOpacity(0.3),
              offset: const Offset(-2,2),
              blurRadius: 15,
              spreadRadius: 2)
            ],
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                  image: NetworkImage(
                    img,
                  ),
                  fit: BoxFit.cover)),
        ),

          Positioned(
              left: 15,bottom: 30,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(top: 5,bottom: 5,left: 8,right: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white
                    ),
                    child: const Text("Private",
                    style: TextStyle(color: Color(0xffff1f6f),fontWeight: FontWeight.bold,fontSize: 10),),
                  ),

                  const Text("Metal Rock Festival 2023",
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.white),),

                  const SizedBox(height: 5,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      const Icon(Icons.music_note,color: Colors.white,size: 15,),
                      const SizedBox(width: 5,),
                      const Text("Electronic",
                      style: TextStyle(color: Colors.white,fontSize: 12),),

                      const SizedBox(width: 10,),

                      const Icon(Icons.timer,color: Colors.white,size: 15,),
                      const SizedBox(width: 5,),
                      const Text("19:00 PM",
                        style: TextStyle(color: Colors.white,fontSize: 12),),

                    ],
                  )

                ],
              ))
      ]
      ),
    );
  }

  Widget eventStatus(BuildContext context)
  {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height*0.2,
      ),
      child: Column(
        children: [
          const Text("Going",
            textAlign: TextAlign.center,
            style: TextStyle(color: Color(0xffff1f6f),fontFamily: "Helvetica_Bold",fontSize: 16,fontWeight: FontWeight.bold),),
          const SizedBox(height: 2,),
          Text("NOW",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black.withOpacity(0.8),fontFamily: "Helvetica_Bold",fontWeight: FontWeight.bold),),

          const SizedBox(height: 10,),

          Expanded(
            child: Container(
                padding: const EdgeInsets.only(left: 20),
                constraints: const BoxConstraints(
                    maxWidth: 50
                ),
                child: DotsList(numberOfDots: 7)),
          ),
        ],
      ),
    );
  }


}

