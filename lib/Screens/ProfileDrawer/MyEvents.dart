import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../CustomWidgets/Headings.dart';
import '../../CustomWidgets/TodaySlider.dart';
import '../../CustomWidgets/UpComingEventsSlider.dart';

class MyEvents extends StatefulWidget {
  const MyEvents({Key? key}) : super(key: key);

  @override
  State<MyEvents> createState() => _MyEventsState();
}

class _MyEventsState extends State<MyEvents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffaf8f8),
      appBar: AppBar(
        backgroundColor: const Color(0xffff1f6f),
        leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_outlined,size: 23,color: Colors.white,)),
        centerTitle: true,
        elevation: 0,
        title: const Text("My Events",
        style: TextStyle(color: Colors.white,fontSize: 15,fontFamily: "Helvetica_Bold"),),

        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Container(
            constraints: const BoxConstraints(
                maxHeight: 40
            ),
            //width: MediaQuery.of(context).size.width*0.8,
            margin: const EdgeInsets.only(left: 15,right: 15,bottom: 15,top: 0),
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5,top: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 0,
                  blurRadius: 3,
                  offset: const Offset(0, 0), // changes position of shadow
                ),
              ],
            ),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                Container(
                    padding: const EdgeInsets.only(left: 5,right: 0,top: 0,bottom: 0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xffffffff)
                    ),
                    child: const Icon(Icons.search,color: Color(0xffff1f6f), size: 22,)),

                const SizedBox(width: 10),

                Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 0),
                      child: TextField(
                        enabled: true,
                        //controller: _searchCon,
                        //controller: _searchCon,
                        //focusNode: _focusNode,
                        //onChanged: (query) => setState(() {}),
                        style: const TextStyle(color: Colors.black, height: 1, fontSize: 14),
                        decoration: InputDecoration(
                          //prefixIcon: Icon(Icons.search, color: Color(0xFF5D5D67), size: 23),
                            hintText: "Search",
                            hintStyle: TextStyle(color: Colors.black.withOpacity(0.35),fontWeight: FontWeight.bold ,fontSize: 13),
                            border: InputBorder.none),
                      ),
                    )),

              ],
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: kToolbarHeight),
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [



                Headings(context, "UPCOMING EVENTS"),

                //Upcoming Slider
                popularSlider(context),


                Headings(context, "PAST EVENTS"),

                popularSlider(context),

                Headings(context, "REJECTED EVENTS"),

                openAirSlider(context),


              ]
          )),
    );
  }
}
