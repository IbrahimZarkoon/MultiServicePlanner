import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_service_planner/modals/OrgProvider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

import 'package:stacked_chart/stacked_chart.dart';
import '../../CustomWidgets/Headings.dart';
import '../../Enums/Colors.dart';
import '../../Providers/CacheManager.dart';
import '../../Response/SingleVendorPackagesResponse.dart';
import '../../Screens/OrganizeEvent.dart';
import 'package:pie_chart/pie_chart.dart';
import '../Widgets/TopStatusSlider.dart';
import '../Widgets/dotsList.dart';
import '../Widgets/pastEventSlider.dart';
import '../Widgets/pieChart.dart';
import 'OrgSingleEvent.dart';

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
    var orgProv = Provider.of<OrgProvider>(context,listen: false);



    return FutureBuilder(future: orgProv.getPackagesData(orgProv.orgID), builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) { return  Scaffold(
      backgroundColor: Colors.white,

      floatingActionButton: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white.withOpacity(0.95),width: 5),
            borderRadius: BorderRadius.circular(100)
        ),
        child: FloatingActionButton(
          onPressed: () { Navigator.push(context, CupertinoPageRoute(builder: (BuildContext context) => const OrganizeEvent())); },
          elevation: 5,
          backgroundColor:  appPrimary,
          child: Container(

            decoration: BoxDecoration(

              color:  appPrimary,
              borderRadius: BorderRadius.circular(100),

            ),
            child: const Icon(CupertinoIcons.add,color: Colors.white,),
          ),
        ),
      ),

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            Headings(context, "Analytics"),

            //Status Con
            AnimatedContainer(
              duration: Duration(milliseconds: topC ? 500 : 500),
              curve: Curves.easeIn,
              padding: EdgeInsets.only(top: 0, bottom: topC ? 15 : 0),
              margin: EdgeInsets.only(top: topC ? 0 : 0, left: 15, right: 15,bottom: 15),
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
                                      color:  appPrimary,
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

            Headings(context, "Your Packages"),

            ListView.builder(
                itemCount: orgProv.packagesList.length,
                shrinkWrap: true,
                padding: const EdgeInsets.only(bottom: 15),
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, index)
                {
                  return Container(
                    //color: Colors.red,
                    padding: const EdgeInsets.only(top: 15,bottom: 0,right: 15,left: 15),
                    child: eventCon(context,
                        "https://everythingforpageants.com/msp/${orgProv.packagesList[index].bannerImg}",orgProv.packagesList[index]),

                  );
                }
            ),
          ],
        ),
      ),


    ); },
    );
  }
  //
  // Widget UpcomingTab(BuildContext context)
  // {
  //   //_upcomingCon.addListener(_upcomingListener);
  //
  //   var orgProv = Provider.of<OrgProvider>(context,listen: false);
  //
  //   return ListView.builder(
  //     itemCount: 4,
  //     shrinkWrap: true,
  //     padding: const EdgeInsets.only(bottom: 15),
  //     physics: const NeverScrollableScrollPhysics(),
  //     scrollDirection: Axis.vertical,
  //     itemBuilder: (BuildContext context, index)
  //     {
  //       return Container(
  //         //color: Colors.red,
  //         padding: const EdgeInsets.only(top: 15,bottom: 0,right: 15,left: 15),
  //         child: eventCon(context,
  //             "https://images.unsplash.com/photo-1556035511-3168381ea4d4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8bmlnaHQlMjBjbHVifGVufDB8fDB8fHww&w=1000&q=80"),
  //
  //       );
  //     }
  //   );
  // }
  //
  // Widget PastTab(BuildContext context)
  // {
  //   return ListView.builder(
  //     padding: const EdgeInsets.only(bottom: 15),
  //     physics: const NeverScrollableScrollPhysics(),
  //     scrollDirection: Axis.vertical,
  //     itemCount: 1,
  //     shrinkWrap: true,
  //     itemBuilder: (BuildContext context,index)
  //     {
  //       return Column(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //
  //         children: [
  //
  //           Headings(context, "Ongoing Events"),
  //
  //           //Recent Events Slider
  //           pastEventSlider(context),
  //
  //           Headings(context, "Recent Events"),
  //
  //           bottomEventsSlider(context)
  //
  //
  //         ],
  //       );
  //     },
  //
  //   );
  // }

  Widget eventCon(BuildContext context,String img,SingleVendorPackagesResponse data)
  {
    return InkWell(
      onTap: () => showModalBottomSheet(
          isScrollControlled: true,
          context: context, builder: (BuildContext context) => OrgSingleEvent(title: "${data.venueName}", image: img,past: false,data: data,)),
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
                    style: TextStyle(color: appPrimary,fontWeight: FontWeight.bold,fontSize: 10),),
                  ),

                   Text("${data.venueName}",
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.white),),

                  const SizedBox(height: 5,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      //const Icon(Icons.music_note,color: Colors.white,size: 15,),
                      // const SizedBox(width: 5,),
                      // const Text("Electronic",
                      // style: TextStyle(color: Colors.white,fontSize: 12),),

                      const SizedBox(width: 00,),

                      const Icon(Icons.timer,color: Colors.white,size: 15,),
                      const SizedBox(width: 5,),
                       Text("${data.timings}",
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
            style: TextStyle(color: appPrimary,fontFamily: "Helvetica_Bold",fontSize: 16,fontWeight: FontWeight.bold),),
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

