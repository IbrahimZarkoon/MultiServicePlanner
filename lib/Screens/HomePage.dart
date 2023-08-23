import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socialapp/CustomWidgets/CustomAppBar.dart';
import 'package:socialapp/CustomWidgets/Headings.dart';
import 'package:socialapp/CustomWidgets/TodaySlider.dart';
import 'package:socialapp/CustomWidgets/UpComingEventsSlider.dart';
import 'package:socialapp/Screens/Dashboard.dart';
import 'package:socialapp/Screens/ExplorePage.dart';
import 'package:socialapp/Screens/MyProfile.dart';
import 'package:socialapp/Screens/ProfileDrawer/userDrawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //refresh
  Future<void> _refreshData() async {
    // Fetch the latest data from the API



    // Update the state with the new data
    setState(() {

    });
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        backgroundColor: Colors.white,

        endDrawer: Drawer(
          elevation: 10,
          shadowColor: Colors.black.withOpacity(0.5),
          child: userDrawer(context),


        ),

        body: RefreshIndicator(
          onRefresh: ()
          {
            return Future.delayed(Duration(seconds: 2));
          },
          color: const Color(0xffff1f6f),
          backgroundColor: Colors.white,
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: kToolbarHeight),
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  // Headings(context, "Your next events"),
                  //
                  // Container(
                  //   margin: const EdgeInsets.only(bottom: 15),
                  //   child: CarouselSlider(
                  //       items: [
                  //
                  //         //1st Offer
                  //         Container(
                  //           width: MediaQuery.of(context).size.width,
                  //           margin: const EdgeInsets.only(left: 15,right: 15,top: 5,bottom: 5),
                  //           decoration: BoxDecoration(
                  //             color: Colors.white,
                  //             borderRadius: BorderRadius.circular(10),
                  //             boxShadow: [
                  //               BoxShadow(
                  //                 color: Colors.black.withOpacity(0.15),
                  //                 offset: const Offset(0,1),
                  //                 blurRadius: 1.5,
                  //                 spreadRadius: 1
                  //               )
                  //             ]
                  //           ),
                  //           child: Column(
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             crossAxisAlignment: CrossAxisAlignment.center,
                  //             children: [
                  //
                  //               Container(
                  //                 width: 50,
                  //                 height: 50,
                  //                 decoration: const BoxDecoration(
                  //                   color: Colors.white,
                  //                   image: DecorationImage(
                  //                     image: AssetImage("assets/images/Icons/SearchIcon.png"),
                  //                     fit: BoxFit.contain
                  //                   )
                  //                 ),
                  //               ),
                  //
                  //               const SizedBox(height: 10,),
                  //
                  //               Text("Explore more upcoming events",style:
                  //                 TextStyle(
                  //                   fontWeight: FontWeight.bold,
                  //                   fontSize: 12,
                  //                   color: Colors.black.withOpacity(0.8)
                  //                 ),),
                  //
                  //               const SizedBox(height: 10,),
                  //
                  //               InkWell(
                  //                 onTap: ()
                  //                 {
                  //                   Navigator.push(context, CupertinoPageRoute(builder: (BuildContext context) => DashboardPage(tabIndex: 1)));
                  //                 },
                  //                 child: const Text("Let's go!",style:
                  //                   TextStyle(color: Color(0xff009ed9),fontSize: 15,fontWeight: FontWeight.bold),),
                  //               )
                  //             ],
                  //           ),
                  //         ),
                  //
                  //         Container(
                  //           width: MediaQuery.of(context).size.width,
                  //           margin: const EdgeInsets.only(left: 15,right: 15,top: 5,bottom: 5),
                  //           decoration: BoxDecoration(
                  //               color: Colors.white,
                  //               borderRadius: BorderRadius.circular(10),
                  //               boxShadow: [
                  //                 BoxShadow(
                  //                     color: Colors.black.withOpacity(0.15),
                  //                     offset: const Offset(0,1),
                  //                     blurRadius: 1.5,
                  //                     spreadRadius: 1
                  //                 )
                  //               ]
                  //           ),
                  //           child: Column(
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             crossAxisAlignment: CrossAxisAlignment.center,
                  //             children: [
                  //
                  //               Container(
                  //                 width: 50,
                  //                 height: 50,
                  //                 decoration: const BoxDecoration(
                  //                     color: Colors.white,
                  //                     image: DecorationImage(
                  //                         image: AssetImage("assets/images/Icons/SearchIcon.png"),
                  //                         fit: BoxFit.contain
                  //                     )
                  //                 ),
                  //               ),
                  //
                  //               const SizedBox(height: 10,),
                  //
                  //               Text("Explore more upcoming events",style:
                  //               TextStyle(
                  //                   fontWeight: FontWeight.bold,
                  //                   fontSize: 12,
                  //                   color: Colors.black.withOpacity(0.8)
                  //               ),),
                  //
                  //               const SizedBox(height: 10,),
                  //
                  //               InkWell(
                  //                 onTap: ()
                  //                 {
                  //                   Navigator.push(context, CupertinoPageRoute(builder: (BuildContext context) => DashboardPage(tabIndex: 1)));
                  //                 },
                  //                 child: const Text("Let's go!",style:
                  //                 TextStyle(color: Color(0xff009ed9),fontSize: 15,fontWeight: FontWeight.bold),),
                  //               )
                  //             ],
                  //           ),
                  //         ),
                  //
                  //         Container(
                  //           width: MediaQuery.of(context).size.width,
                  //           margin: const EdgeInsets.only(left: 15,right: 15,top: 5,bottom: 5),
                  //           decoration: BoxDecoration(
                  //               color: Colors.white,
                  //               borderRadius: BorderRadius.circular(10),
                  //               boxShadow: [
                  //                 BoxShadow(
                  //                     color: Colors.black.withOpacity(0.15),
                  //                     offset: const Offset(0,1),
                  //                     blurRadius: 1.5,
                  //                     spreadRadius: 1
                  //                 )
                  //               ]
                  //           ),
                  //           child: Column(
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             crossAxisAlignment: CrossAxisAlignment.center,
                  //             children: [
                  //
                  //               Container(
                  //                 width: 50,
                  //                 height: 50,
                  //                 decoration: const BoxDecoration(
                  //                     color: Colors.white,
                  //                     image: DecorationImage(
                  //                         image: AssetImage("assets/images/Icons/SearchIcon.png"),
                  //                         fit: BoxFit.contain
                  //                     )
                  //                 ),
                  //               ),
                  //
                  //               const SizedBox(height: 10,),
                  //
                  //               Text("Explore more upcoming events",style:
                  //               TextStyle(
                  //                   fontWeight: FontWeight.bold,
                  //                   fontSize: 12,
                  //                   color: Colors.black.withOpacity(0.8)
                  //               ),),
                  //
                  //               const SizedBox(height: 10,),
                  //
                  //               InkWell(
                  //                 onTap: ()
                  //                 {
                  //                   Navigator.push(context, CupertinoPageRoute(builder: (BuildContext context) => DashboardPage(tabIndex: 1)));
                  //                 },
                  //                 child: const Text("Let's go!",style:
                  //                 TextStyle(color: Color(0xff009ed9),fontSize: 15,fontWeight: FontWeight.bold),),
                  //               )
                  //             ],
                  //           ),
                  //         ),
                  //
                  //       ],
                  //       options: CarouselOptions(
                  //         scrollPhysics: const BouncingScrollPhysics(),
                  //         initialPage: 0,
                  //         height: MediaQuery.of(context).size.height*0.2,
                  //         enlargeCenterPage: false,
                  //         enableInfiniteScroll: false,
                  //         scrollDirection: Axis.horizontal,
                  //
                  //         viewportFraction: 1,
                  //         autoPlay: false,
                  //       )),
                  // ),

                  Headings(context, "UPCOMING EVENTS"),

                  //Upcoming Slider
                  upComingSlider(context),

                  Headings(context, "TODAY"),

                  todaySlider(context),

                  Headings(context, "OPEN AIR"),

                  openAirSlider(context),

                  Container(
                    padding: const EdgeInsets.only(top: 15,bottom: 15 , left:15 , right:15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:  const [

                        Text("EVENT VENUES",overflow: TextOverflow.ellipsis,
                            style:
                            TextStyle(color: Color(0xff000000),fontWeight: FontWeight.bold,fontFamily: "Helvetica_Bold", fontSize: 18)),

                        Text("See all",
                          style: TextStyle(
                              color: Color(0xff009ed9),
                              fontWeight: FontWeight.bold,fontSize: 13
                          ),)
                      ],
                    ),
                  ),

                  eventVenueSlider(context)

                ]
              )),
        ),
      ),
    );
  }


}
