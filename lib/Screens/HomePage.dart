import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:multi_service_planner/modals/AllServiceProvider.dart';
import 'package:provider/provider.dart';
import '../CustomWidgets/Headings.dart';
import '../CustomWidgets/TodaySlider.dart';
import '../CustomWidgets/UpComingEventsSlider.dart';
import '../CustomWidgets/serviceProviders.dart';
import '../Enums/Colors.dart';
import '../Response/ServiceResponse.dart';
import 'ProfileDrawer/userDrawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    var allServiceProv = Provider.of<AllServiceProvider>(context,listen:false);
    // if(venues ==[])
    //   {
    //     fetchDataForAllItems();
    //   }
    return Scaffold(

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

                  Headings(context, "Featured Photographers"),

                  //Upcoming Slider
                  featuredSlider(context,allServiceProv.photographers ?? []),

                  Headings(context, "Trending Venues"),

                  popularSlider(context, allServiceProv.venues ?? []),

                  Headings(context, "Services"),

                  serviceProviders(context),



                  Headings(context, "Top Decors"),

                  decorSlider(context,allServiceProv.decors ?? []),

                  Headings(context, "Popular Caterers"),

                  CatererSlider(context,allServiceProv.caterers ?? [])

                ]
            )),
      ),
    );
  }


}
