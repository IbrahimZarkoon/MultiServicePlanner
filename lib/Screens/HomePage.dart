import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../CustomWidgets/Headings.dart';
import '../CustomWidgets/TodaySlider.dart';
import '../CustomWidgets/UpComingEventsSlider.dart';
import '../CustomWidgets/serviceProviders.dart';
import '../Enums/Colors.dart';
import 'ProfileDrawer/userDrawer.dart';

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
          color:  appPrimary,
          backgroundColor: Colors.white,
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: kToolbarHeight),
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  Headings(context, "FEATURED"),

                  //Upcoming Slider
                  featuredSlider(context),

                  Headings(context, "POPULAR VENUES"),

                  popularSlider(context),

                  Headings(context, "SERVICES"),

                  serviceProviders(context),



                  Headings(context, "OPEN AIR"),

                  openAirSlider(context),

                  Headings(context, "IN DOOR"),

                  inDoorSlider(context)

                ]
              )),
        ),
      ),
    );
  }


}
