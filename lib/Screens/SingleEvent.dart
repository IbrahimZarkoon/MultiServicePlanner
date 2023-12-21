import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_service_planner/Response/ServiceResponse.dart';
import 'package:multi_service_planner/modals/UserProvider.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;

import 'package:url_launcher/url_launcher.dart';
import 'package:android_intent/android_intent.dart';
import 'package:table_calendar/table_calendar.dart';
import '../CustomWidgets/Headings.dart';
import '../CustomWidgets/UpComingEventsSlider.dart';
import '../Providers/CacheManager.dart';
import 'EventChatScreen.dart';

class SingleEvent extends StatefulWidget {
  SingleEvent(
      {Key? key,
      required this.title,
      required this.image,
      required this.repeat,
      required this.past,
      required this.data})
      : super(key: key);

  String title;
  String image;
  bool repeat;
  bool past;
  ServiceResponse? data;

  @override
  State<SingleEvent> createState() => _SingleEventState();
}

class _SingleEventState extends State<SingleEvent> {
  int _currentSlide = 0;

  List<String>? carouselImages = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    carouselImages = widget.data?.relatedImg;
  }
  // void _openCalendar() {
  //   AndroidIntent intent = AndroidIntent(
  //     action: 'android.intent.action.MAIN',
  //     package: 'com.example.socialapp',
  //   );
  //   intent.launch();
  // }

  double _top = 0;

  int maxDesc = 5;
  String readDesc = "Read more";
  bool request = false;

  void launchMap() async {
    const double latitude = 24.802308;
    const double longitude = 67.046165;
    const String mapUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

    if (await canLaunch(mapUrl)) {
      await launch(mapUrl);
    } else {
      throw 'Could not launch $mapUrl';
    }
  }

  final ImagePicker _BannerPicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final cacheManager =
        Provider.of<CacheManagerProvider>(context).cacheManager;

    return Stack(children: [
      Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        margin: const EdgeInsets.only(
          top: kToolbarHeight - 20,
        ),
        child: Scaffold(
          backgroundColor: const Color(0xfff9f9f9),
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            leading: InkWell(
                onTap: () => Navigator.pop(context),
                child: Icon(
                  Icons.arrow_back_outlined,
                  size: 25,
                  color: Colors.black.withOpacity(0.8),
                )),
            title: Text(
              "Service Details",
              style: TextStyle(
                  color: Colors.black.withOpacity(0.8),
                  fontFamily: "Helvetica_Bold",
                  fontSize: 16),
            ),
            centerTitle: true,
            automaticallyImplyLeading: false,
            actions: [
              InkWell(
                onTap: () => Share.share("123"),
                child: Container(
                  padding: const EdgeInsets.all(0),
                  child: Icon(
                    CupertinoIcons.share,
                    size: 25,
                    color: Colors.black.withOpacity(0.8),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              )
            ],
          ),
          body: Container(
            color: const Color(0xfff9f9f9),
            margin: const EdgeInsets.only(top: 0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Image Container
                  Stack(children: [
                    Container(
                      margin: const EdgeInsets.only(
                          left: 15, right: 15, bottom: 15, top: 15),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        // image: DecorationImage(
                        //     image: NetworkImage(widget.image),
                        //     fit: BoxFit.cover)
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: CachedNetworkImage(
                          imageUrl: widget.image,
                          cacheManager: cacheManager,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(
                              color: Color(0xff09426d),
                              value: 5,
                            ),
                          ),
                          errorWidget: (context, url, error) => const Icon(
                            Icons.error,
                            color: Color(0xff09426d),
                          ),
                        ),
                      ),
                    ),
                  ]),

                  //Heading
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, bottom: 5, top: 0),
                    child: Text(
                      widget.title,
                      textScaleFactor: 1.3,
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.8),
                          fontSize: 17,
                          fontFamily: "Helvetica_Bold"),
                    ),
                  ),

                  //Pricing
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, bottom: 10, top: 0),
                    child: Text(
                      "${widget.data?.priceRangeStart}PKR - ${widget.data?.priceRangeEnd}PKR ",
                      textScaleFactor: 1.3,
                      style: TextStyle(
                          decoration: widget.past
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          color: widget.past
                              ? Colors.black.withOpacity(0.4)
                              : Colors.black.withOpacity(0.8),
                          fontSize: 12,
                          fontWeight:
                              widget.past ? FontWeight.normal : FontWeight.bold,
                          fontFamily: ""),
                    ),
                  ),

                  //CAT ROW
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 15),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 1.5)
                            ]),
                        padding: const EdgeInsets.only(
                            top: 5, bottom: 5, left: 15, right: 15),
                        alignment: Alignment.center,
                        child: const Text(
                          "Music",
                          style: TextStyle(
                              color: Color(0xff09426d),
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 15),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 1.5)
                            ]),
                        padding: const EdgeInsets.only(
                            top: 5, bottom: 5, left: 15, right: 15),
                        alignment: Alignment.center,
                        child: const Text(
                          "Social",
                          style: TextStyle(
                              color: Color(0xff09426d),
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 15),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 1.5)
                            ]),
                        padding: const EdgeInsets.only(
                            top: 5, bottom: 5, left: 15, right: 15),
                        alignment: Alignment.center,
                        child: const Text(
                          "Featured",
                          style: TextStyle(
                              color: Color(0xff09426d),
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                      ),
                    ],
                  ),

                  //Capacity Container
                  Container(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, bottom: 0, top: 0),
                    margin: const EdgeInsets.only(bottom: 0, top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 0,
                                        blurRadius: 1.5,
                                        offset: const Offset(0, 0))
                                  ]),
                              child: const Icon(
                                Icons.people_alt_outlined,
                                size: 20,
                                color: Color(0xff09426d),
                              ),
                            ),

                            const SizedBox(
                              width: 15,
                            ),

                            //Details Column
                            widget.repeat
                                ? Text(
                                    "${widget.data?.capacity}",
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.6),
                                        fontSize: 14,
                                        fontFamily: ""),
                                  )
                                : Text(
                                    '${widget.data?.capacity}',
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.6),
                                        fontSize: 14,
                                        fontFamily: ""),
                                  ),
                          ],
                        ),

                        //Icon(Icons.keyboard_arrow_right,color: Colors.black.withOpacity(0.4),size: 30,)
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 10, left: 15, right: 15),
                    child: shadowLine(context),
                  ),

                  //Duration Container
                  Container(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, bottom: 0, top: 0),
                    margin: const EdgeInsets.only(bottom: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 0,
                                        blurRadius: 1.5,
                                        offset: const Offset(0, 0))
                                  ]),
                              child: const Icon(
                                Icons.access_time_rounded,
                                size: 20,
                                color: Color(0xff09426d),
                              ),
                            ),

                            const SizedBox(
                              width: 15,
                            ),

                            //Details Column
                            Text(
                              "${widget.data?.timings}",
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.6),
                                  fontSize: 14,
                                  fontFamily: ""),
                            ),
                          ],
                        ),

                        //Icon(Icons.keyboard_arrow_right,color: Colors.black.withOpacity(0.4),size: 30,)
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 10, left: 15, right: 15),
                    child: shadowLine(context),
                  ),

                  //Location Container
                  Container(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, bottom: 0, top: 0),
                    margin: const EdgeInsets.only(bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 0,
                                        blurRadius: 1.5,
                                        offset: const Offset(0, 0))
                                  ]),
                              child: const Icon(
                                Icons.location_on_outlined,
                                size: 20,
                                color: Color(0xff09426d),
                              ),
                            ),

                            const SizedBox(
                              width: 15,
                            ),

                            //Details Column
                            Text(
                              "${widget.data?.location}",
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.6),
                                  fontSize: 14,
                                  fontFamily: ""),
                            ),
                          ],
                        ),

                        //Icon(Icons.keyboard_arrow_right,color: Colors.black.withOpacity(0.4),size: 30,)
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(
                        top: 5, bottom: 0, left: 0, right: 0),
                    child: thickBorder(context),
                  ),

                  //About
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, bottom: 15, top: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("About",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.8),
                                fontWeight: FontWeight.bold,
                                fontFamily: "Helvetica_Bold",
                                fontSize: 18)),
                        const SizedBox(
                          height: 15,
                        ),
                        RichText(
                          maxLines: maxDesc,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              TextSpan(
                                text: "${widget.data?.about}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "",
                                    color: Colors.black.withOpacity(0.8)),
                              ),
                              //   TextSpan(
                              //     text: 'Location: \n',
                              //     style: TextStyle(
                              //         fontWeight: FontWeight.bold,
                              //         fontFamily: "Helvetica_Bold",
                              //         color: Colors.black.withOpacity(0.8),
                              //         fontSize: 13),
                              //   ),
                              //   TextSpan(
                              //       style: TextStyle(
                              //           color: Colors.black.withOpacity(0.8),
                              //           fontSize: 13),
                              //       text:
                              //           'The Beach Hut is situated along the Clifton Beach, which is one of the most famous beach areas in Karachi. It offers stunning views of the sea and is a popular destination for both locals and tourists.'),

                              //   //Day 2
                              //   TextSpan(
                              //     text: '\n\nAmbiance:\n',
                              //     style: TextStyle(
                              //         fontWeight: FontWeight.bold,
                              //         fontFamily: "Helvetica_Bold",
                              //         color: Colors.black.withOpacity(0.8),
                              //         fontSize: 13),
                              //   ),
                              //   TextSpan(
                              //       style: TextStyle(
                              //           color: Colors.black.withOpacity(0.8),
                              //           fontSize: 13),
                              //       text:
                              //           'The Beach Hut provides a laid-back and serene environment. Its a great place to unwind and escape from the hustle and bustle of the city. The venue is designed to offer a rustic and beachy atmosphere.'),

                              //   //Inclusions
                              //   TextSpan(
                              //     text: '\n\nFacilities:\n',
                              //     style: TextStyle(
                              //         fontWeight: FontWeight.bold,
                              //         fontFamily: "Helvetica_Bold",
                              //         color: Colors.black.withOpacity(0.8),
                              //         fontSize: 13),
                              //   ),
                              //   TextSpan(
                              //       style: TextStyle(
                              //           color: Colors.black.withOpacity(0.8),
                              //           fontSize: 13),
                              //       text:
                              //           'Visitors to The Beach Hut can enjoy various amenities, including comfortable seating areas, beachside huts, and private cabanas. There are often beach games and activities available, making it a fun spot for families and friends.'),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        InkWell(
                          onTap: () {
                            if (readDesc == "Read more") {
                              setState(() {
                                maxDesc = 100;
                                readDesc = "Read less";
                              });
                            } else {
                              setState(() {
                                maxDesc = 5;
                                readDesc = "Read more";
                              });
                            }
                          },
                          child: Text(
                            readDesc,
                            style: const TextStyle(
                                fontSize: 13,
                                color: Color(0xff09426d),
                                fontFamily: "Helvetica_Bold"),
                          ),
                        ),
                      ],
                    ),
                  ),

                  thickBorder(context),

                  //Location
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, bottom: 15, top: 15),
                    child: Text("Location",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.8),
                            fontWeight: FontWeight.bold,
                            fontFamily: "Helvetica_Bold",
                            fontSize: 18)),
                  ),

                  //Google Maps Column
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, bottom: 15, top: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        //Google Maps Container
                        GestureDetector(
                          onTap: () {
                            launchMap();
                          },
                          child: Stack(children: [
                            Container(
                              //margin: EdgeInsets.all(15),
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.25,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: const DecorationImage(
                                    image: AssetImage(
                                        "assets/images/logos/Maps_Img.png"),
                                    fit: BoxFit.cover,
                                  )),
                            ),
                            Positioned(
                                right: 10,
                                bottom: 10,
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      top: 5, bottom: 5, left: 10, right: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black.withOpacity(.2),
                                            spreadRadius: 1,
                                            blurRadius: 1.5,
                                            offset: const Offset(0, 0))
                                      ]),
                                  child: const Text(
                                    "View on Google Maps",
                                    style: TextStyle(
                                        color: Color(0xff09426d),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11),
                                  ),
                                ))
                          ]),
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        Row(
                          children: [
                            Text(
                              "French Beach",
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.6),
                                  fontFamily: "",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              "${widget.data?.location}, Karachi City, Sindh",
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.6),
                                  fontSize: 13),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  thickBorder(context),

                  //Photos
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, bottom: 15, top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Photos",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.8),
                                fontWeight: FontWeight.bold,
                                fontFamily: "Helvetica_Bold",
                                fontSize: 18)),
                      ],
                    ),
                  ),

                  //Photos Con
                  Column(
                    children: [
                      CarouselSlider.builder(
                        itemCount: carouselImages?.length ?? 0,
                        itemBuilder: (BuildContext context, int index, int a) {
                          return Container(
                            margin: const EdgeInsets.only(
                                left: 15, right: 15, bottom: 15),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl: carouselImages![index],
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(
                                    color: Color(0xff09426d),
                                    value: 5,
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error,
                                        color: Color(0xff09426d)),
                              ),
                            ),
                          );
                        },
                        options: CarouselOptions(
                          height: MediaQuery.of(context).size.height * 0.2,
                          autoPlay: false,
                          viewportFraction: 1,
                          enlargeCenterPage: false,
                          initialPage: 0,
                          scrollPhysics: const BouncingScrollPhysics(),
                          aspectRatio: 1,
                          scrollDirection: Axis.horizontal,
                          onPageChanged: (index, _) {
                            setState(() {
                              _currentSlide = index;
                            });
                          },
                        ),
                      ),

                      //Pagination Row
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            carouselImages?.length ?? 0,
                            (index) => Container(
                              width: 8,
                              height: 8,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _currentSlide == index
                                    ? const Color(0xff09426d)
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  //Visit Site Con
                  InkWell(
                    onTap: () {
                      launchUrl(Uri.parse(
                          "${widget.data?.webLink ?? "https://cms.bahria.edu.pk/"}"));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      margin: const EdgeInsets.only(
                          left: 15, right: 15, bottom: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                spreadRadius: 1,
                                blurRadius: 1)
                          ]),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "To the event site",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Color(0xff09426d)),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Transform.rotate(
                              angle: 45 * 3.1415926535 / 180,
                              child: const Icon(
                                Icons.arrow_upward,
                                size: 20,
                                color: Color(0xff09426d),
                              ))
                        ],
                      ),
                    ),
                  ),

                  //
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     Padding(
                  //       padding: const EdgeInsets.only(
                  //           left: 15, right: 15, bottom: 15, top: 15),
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         mainAxisAlignment: MainAxisAlignment.start,
                  //         children: [
                  //           //Heading
                  //           const Text(
                  //             "Similar Venues",
                  //             style: TextStyle(
                  //                 fontSize: 18, fontFamily: "Helvetica_Bold"),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //     featuredSlider(context, []),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
      Positioned(
        bottom: 15,
        left: 15,
        right: 15,
        child: Container(
          //height: MediaQuery.of(context).size.height * 0.1,
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          child: //Request to join Container
              Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: InkWell(
                  onTap: () async {
                    if (request == false && widget.repeat == false) {
                      bool result = await showModalBottomSheet(
                          context: context,
                          isDismissible: true,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15))),
                          isScrollControlled: true,
                          builder: (BuildContext context) {
                            return repeatDaysBottomSheet(widget.data);
                          });
                      if (result == true) {
                        setState(() {
                          request = true;
                        });
                      }

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height -
                              (2.75 * kToolbarHeight),
                        ),
                        behavior: SnackBarBehavior.floating,
                        showCloseIcon: true,
                        content: const Text(
                          "Your booking will be confirmed with in 24 hours.",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Helvetica_Bold",
                            fontSize: 12,
                          ),
                        ),
                        backgroundColor: const Color(0xff09426d),
                        duration: const Duration(seconds: 2),
                      ));
                    }

                    if (widget.repeat == true && request == false) {
                      bool result = await showModalBottomSheet(
                          context: context,
                          isDismissible: true,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15))),
                          isScrollControlled: true,
                          builder: (BuildContext context) {
                            return repeatDaysBottomSheet(widget.data);
                          });
                      if (result == true) {
                        setState(() {
                          request = true;
                        });
                      }

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height -
                              (2.75 * kToolbarHeight),
                        ),
                        behavior: SnackBarBehavior.floating,
                        showCloseIcon: true,
                        content: const Text(
                          "Your booking will be confirmed with in 24 hours.",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Helvetica_Bold",
                            fontSize: 12,
                          ),
                        ),
                        backgroundColor: const Color(0xff09426d),
                        duration: const Duration(seconds: 2),
                      ));
                    }
                  },
                  child: request
                      ? Container(
                          constraints: BoxConstraints(maxHeight: 45),
                          padding: const EdgeInsets.only(
                              top: 15, bottom: 15, left: 25, right: 25),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 1.5,
                                  offset: const Offset(0, 0))
                            ],
                            borderRadius: BorderRadius.circular(13),
                            color: const Color(0xff09426d),
                          ),
                          child: const Text(
                            "Booked",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Helvetica_Bold",
                                fontSize: 13),
                          ),
                        )
                      : Container(
                          constraints: BoxConstraints(maxHeight: 45),
                          padding: const EdgeInsets.only(
                              top: 15, bottom: 15, left: 25, right: 25),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13),
                            color: const Color(0xff09426d),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 1.5,
                                  offset: const Offset(0, 0))
                            ],
                          ),
                          child: const Text(
                            "Book now",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Helvetica_Bold",
                                fontSize: 13),
                          ),
                        ),
                ),
              ),

              //Chat Container
              InkWell(
                onTap: () {
                  launchUrl(Uri.parse(
                      "https://api.whatsapp.com/send/?phone=%2B923363434322"));
                },
                child: Container(
                  constraints: BoxConstraints(maxHeight: 45),
                  margin: EdgeInsets.only(left: 15),
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 25, right: 25),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 1.5,
                          offset: const Offset(0, 0))
                    ],
                    borderRadius: BorderRadius.circular(13),
                    color: const Color(0xffffffff),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        CupertinoIcons.chat_bubble_2,
                        size: 20,
                        color: Color(0xff09426d),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text(
                        "Chat",
                        style: TextStyle(
                            color: Color(0xff09426d),
                            fontFamily: "Helvetica_Bold",
                            fontSize: 13),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      )
    ]);
  }

  Widget reviewCon(
      BuildContext context, String title, String comment, String name) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.25,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 1,
                spreadRadius: 1,
                offset: const Offset(1, 1))
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Ratings and Date Row
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 2.0),
                child: AbsorbPointer(
                  absorbing: true,
                  child: RatingBar(
                    initialRating: double.parse("4.4"),
                    allowHalfRating: true,
                    itemSize: 16,
                    ratingWidget: RatingWidget(
                        full: const Icon(
                          Icons.star,
                          color: Color(0xffffc107),
                        ),
                        half: const Icon(
                          Icons.star_half,
                          color: Color(0xffffc107),
                        ),
                        empty: const Icon(
                          Icons.star_border,
                          color: Color(0xffffc107),
                        )),
                    onRatingUpdate: (ratings) => print(ratings),
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              const Text(
                "Verified User",
                style: TextStyle(
                    color: Color(0xff51a81e),
                    fontWeight: FontWeight.bold,
                    fontSize: 11),
              ),
              const Spacer(),
              Text(
                "03/21/2023",
                style: TextStyle(
                    color: Colors.black.withOpacity(0.4), fontSize: 12),
              )
            ],
          ),

          const SizedBox(
            height: 10,
          ),

          //Title Text
          Padding(
            padding: const EdgeInsets.only(left: 2),
            child: Text(
              title,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
          ),

          const SizedBox(
            height: 10,
          ),

          //Comment Text
          Padding(
            padding: const EdgeInsets.only(left: 2),
            child: Text(
              comment,
              style: TextStyle(color: Colors.black.withOpacity(0.4)),
            ),
          ),

          const SizedBox(
            height: 10,
          ),

          //Name Text
          Padding(
            padding: const EdgeInsets.only(left: 2),
            child: Text(
              name,
              style: TextStyle(color: Colors.black.withOpacity(0.4)),
            ),
          ),

          const Spacer(),

          //Like / Dislike Row
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //like Container
              Container(
                child: Row(
                  children: [
                    Icon(
                      Icons.thumb_up_outlined,
                      color: Colors.black.withOpacity(0.75),
                      size: 20,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 7.0),
                      child: Text(
                        "9",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                width: 15,
              ),

              //Dislike Container
              Container(
                child: Row(
                  children: [
                    Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()..scale(-1.0, 1.0, 1.0),
                      child: Icon(
                        Icons.thumb_down_outlined,
                        color: Colors.black.withOpacity(0.75),
                        size: 20,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 7.0),
                      child: Text(
                        "0",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget allReviews(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.85,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Headings(context, "All Ratings"),

          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AbsorbPointer(
                  absorbing: true,
                  child: RatingBar(
                    initialRating: double.parse("4.4"),
                    allowHalfRating: true,
                    itemSize: 20,
                    ratingWidget: RatingWidget(
                        full: const Icon(
                          Icons.star,
                          color: Color(0xffffc107),
                        ),
                        half: const Icon(
                          Icons.star_half,
                          color: Color(0xffffc107),
                        ),
                        empty: const Icon(
                          Icons.star_border,
                          color: Color(0xffffc107),
                        )),
                    onRatingUpdate: (ratings) => print(ratings),
                  ),
                ),
                const SizedBox(
                  width: 2,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2.0),
                  child: Text(
                    "(4.6)",
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.6), fontSize: 12),
                  ),
                )
              ],
            ),
          ),

          const SizedBox(
            height: 10,
          ),

          //5 Stars
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "5 stars",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.black.withOpacity(0.6)),
                ),
                Expanded(
                  child: LinearPercentIndicator(
                    barRadius: const Radius.circular(5),
                    //width: 300.0,
                    lineHeight: 8.0,
                    percent: 360 / 400,

                    trailing: SizedBox(
                        width: 20,
                        child: Text(
                          "20",
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                              fontSize: 12),
                        )),
                    //linearStrokeCap: LinearStrokeCap.butt,
                    backgroundColor: const Color(0xffd5d5d5),
                    progressColor: const Color(0xFF5D5D5D),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 5,
          ),

          //4 Stars
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "4 stars",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.black.withOpacity(0.6)),
                ),
                Expanded(
                  child: LinearPercentIndicator(
                    barRadius: const Radius.circular(5),
                    //width: 300.0,
                    lineHeight: 8.0,
                    percent: 300 / 400,

                    trailing: SizedBox(
                        width: 20,
                        child: Text(
                          "28",
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                              fontSize: 12),
                        )),
                    //linearStrokeCap: LinearStrokeCap.butt,
                    backgroundColor: const Color(0xffd5d5d5),
                    progressColor: const Color(0xFF5D5D5D),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),

          //3 Stars
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "3 stars",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.black.withOpacity(0.6)),
                ),
                Expanded(
                  child: LinearPercentIndicator(
                    barRadius: const Radius.circular(5),
                    //width: 300.0,
                    lineHeight: 8.0,
                    percent: 0 / 400,

                    trailing: SizedBox(
                        width: 20,
                        child: Text(
                          "0",
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                              fontSize: 12),
                        )),
                    //linearStrokeCap: LinearStrokeCap.butt,
                    backgroundColor: const Color(0xffd5d5d5),
                    progressColor: const Color(0xFF5D5D5D),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),

          //2 Stars
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "2 stars",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.black.withOpacity(0.6)),
                ),
                Expanded(
                  child: LinearPercentIndicator(
                    barRadius: const Radius.circular(5),
                    //width: 300.0,
                    lineHeight: 8.0,
                    percent: 0 / 400,

                    trailing: SizedBox(
                        width: 20,
                        child: Text(
                          "0",
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                              fontSize: 12),
                        )),
                    //linearStrokeCap: LinearStrokeCap.butt,
                    backgroundColor: const Color(0xffd5d5d5),
                    progressColor: const Color(0xFF5D5D5D),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),

          //1 Star
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "1 stars",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.black.withOpacity(0.6)),
                ),
                Expanded(
                  child: LinearPercentIndicator(
                    barRadius: const Radius.circular(5),
                    //width: 300.0,
                    lineHeight: 8.0,
                    percent: 0 / 400,

                    trailing: SizedBox(
                        width: 20,
                        child: Text(
                          "0",
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                              fontSize: 12),
                        )),
                    //linearStrokeCap: LinearStrokeCap.butt,
                    backgroundColor: const Color(0xffd5d5d5),
                    progressColor: const Color(0xFF5D5D5D),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 20,
          ),

          shadowLine(context),

          Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  //padding: EdgeInsets.only(top: 3,bottom: 3,left: 15,right: 15),
                  itemCount: 5,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, index) {
                    return Container(
                      //margin: EdgeInsets.only(right: 10),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.25,

                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(0),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                blurRadius: 1,
                                spreadRadius: 1,
                                offset: const Offset(1, 1))
                          ]),

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Ratings and Date Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 2.0),
                                child: AbsorbPointer(
                                  absorbing: true,
                                  child: RatingBar(
                                    initialRating: double.parse("4.4"),
                                    allowHalfRating: true,
                                    itemSize: 16,
                                    ratingWidget: RatingWidget(
                                        full: const Icon(
                                          Icons.star,
                                          color: Color(0xffffc107),
                                        ),
                                        half: const Icon(
                                          Icons.star_half,
                                          color: Color(0xffffc107),
                                        ),
                                        empty: const Icon(
                                          Icons.star_border,
                                          color: Color(0xffffc107),
                                        )),
                                    onRatingUpdate: (ratings) => print(ratings),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Text(
                                "Verified User",
                                style: TextStyle(
                                    color: Color(0xff51a81e),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11),
                              ),
                              const Spacer(),
                              Text(
                                "03/21/2023",
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.4),
                                    fontSize: 12),
                              )
                            ],
                          ),

                          const SizedBox(
                            height: 10,
                          ),

                          //Title Text
                          const Padding(
                            padding: EdgeInsets.only(left: 2),
                            child: Text(
                              "Got to have 'em",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          ),

                          const SizedBox(
                            height: 10,
                          ),

                          //Comment Text
                          Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: Text(
                              "States where I pretty good price and a great size I use two a day and it's something we have to buy",
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.4)),
                            ),
                          ),

                          const SizedBox(
                            height: 10,
                          ),

                          //Name Text
                          Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: Text(
                              "Mark$index",
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.4)),
                            ),
                          ),

                          const Spacer(),

                          //Like / Dislike Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              //like Container
                              Container(
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.thumb_up_outlined,
                                      color: Colors.black.withOpacity(0.75),
                                      size: 20,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(top: 7.0),
                                      child: Text(
                                        "9",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(
                                width: 15,
                              ),

                              //Dislike Container
                              Container(
                                child: Row(
                                  children: [
                                    Transform(
                                      alignment: Alignment.center,
                                      transform: Matrix4.identity()
                                        ..scale(-1.0, 1.0, 1.0),
                                      child: Icon(
                                        Icons.thumb_down_outlined,
                                        color: Colors.black.withOpacity(0.75),
                                        size: 20,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(top: 7.0),
                                      child: Text(
                                        "0",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}

class repeatDaysBottomSheet extends StatefulWidget {
  ServiceResponse? data;
  repeatDaysBottomSheet(this.data);

  @override
  State<repeatDaysBottomSheet> createState() => _repeatDaysBottomSheetState();
}

class _repeatDaysBottomSheetState extends State<repeatDaysBottomSheet> {
  List<bool> weekDays = [false, false, false, false, false, false, false];
  List<String> days = [
    'Monday',
    'Tuesday',
    "Wednesday",
    "Thursday",
    'Friday',
    'Saturday',
    'Sunday'
  ];

  List<DateTime> _selectedDates = [];
  List<DateTime?> _multiDatePickerValueWithDefaultValue = [
    // DateTime(2023, 8, 1),
    // DateTime(2023, 8, 5),
    // DateTime(2023, 8, 14),
    // DateTime(2023, 8, 17),
    // DateTime(2023, 8, 25),
  ];

  // Function to check if a date is Friday, Saturday, or Sunday
  bool _isSelectable(DateTime date) {
    return date.weekday == DateTime.friday ||
        date.weekday == DateTime.saturday ||
        date.weekday == DateTime.sunday;
  }

  List<String> _getSelectedDatesText(
    CalendarDatePicker2Type datePickerType,
    List<DateTime?> values,
  ) {
    values =
        values.map((e) => e != null ? DateUtils.dateOnly(e) : null).toList();

    List<String> selectedDates = [];

    if (datePickerType == CalendarDatePicker2Type.multi) {
      selectedDates = values
          .map((v) => v != null ? DateFormat('d-M-yyyy').format(v) : '')
          .toList();
    } else if (datePickerType == CalendarDatePicker2Type.range) {
      if (values.isNotEmpty) {
        final startDate =
            values[0] != null ? DateFormat('d-M-yyyy').format(values[0]!) : '';
        final endDate = values.length > 1
            ? (values[1] != null
                ? DateFormat('d-M-yyyy').format(values[1]!)
                : '')
            : '';
        selectedDates.add('$startDate to $endDate');
      }
    }

    return selectedDates;
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
          : ' ';
    } else if (datePickerType == CalendarDatePicker2Type.range) {
      if (values.isNotEmpty) {
        final startDate = values[0].toString().replaceAll('00:00:00.000', '');
        final endDate = values.length > 1
            ? values[1].toString().replaceAll('00:00:00.000', '')
            : ' ';
        valueText = '$startDate to $endDate';
      } else {
        return ' ';
      }
    }

    return valueText;
  }

  Widget _buildDefaultMultiDatePickerWithValue() {
    final config = CalendarDatePicker2Config(
      selectableDayPredicate: (DateTime date) {
        // Allow selection only if the day is Friday, Saturday, or Sunday.
        return !date.isBefore(DateTime.now());
      },
      calendarType: CalendarDatePicker2Type.multi,
      selectedDayHighlightColor: Color(0xff09426d),
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CalendarDatePicker2(
          config: config,
          value: _multiDatePickerValueWithDefaultValue,
          onValueChanged: (dates) =>
              setState(() => _multiDatePickerValueWithDefaultValue = dates),
        ),
        //const SizedBox(height: 10),
        Container(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Wrap(
            runSpacing: 10,
            children: [
              Text(
                'Selected Dates: ',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(0.8)),
              ),
              const SizedBox(width: 10),
              Text(
                _getValueText(
                  config.calendarType,
                  _multiDatePickerValueWithDefaultValue,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                softWrap: false,
              ),
            ],
          ),
        ),
        const SizedBox(height: 25),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    final config = CalendarDatePicker2Config(
      selectableDayPredicate: (DateTime date) {
        // Allow selection only if the day is Friday, Saturday, or Sunday.
        return !date.isBefore(DateTime.now());
      },
      calendarType: CalendarDatePicker2Type.multi,
      selectedDayHighlightColor: Color(0xff09426d),
    );
    void BookService(UserProvider userProvider) async {
      var url = await Uri.parse(
          'https://everythingforpageants.com/msp/api/bookPackage.php');
      var response = await http.post(url,
          body: json.encode({
            "user_id": userProvider.userID,
            "service_id": widget.data?.id,
            "date": _getSelectedDatesText(
                config.calendarType, _multiDatePickerValueWithDefaultValue)
          }));

      print(response.body);
      var decodedJson = jsonDecode(response.body) as Map<String, dynamic>;
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - (2.75 * kToolbarHeight),
        ),
        behavior: SnackBarBehavior.floating,
        showCloseIcon: true,
        content: const Text(
          "Your booking will be confirmed with in 24 hours.",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Helvetica_Bold",
            fontSize: 12,
          ),
        ),
        backgroundColor: const Color(0xff09426d),
        duration: const Duration(seconds: 2),
      ));
      // _signInApiResponse = SignInResp.fromJson(decodedJson);

      // if (_signInApiResponse?.status == "200") {
      //   // print(_signInApiResponse?.modelId);
      //   authProvider.setUser(_signInApiResponse);
      //   Navigator.pushNamed(context, "/Dashboard");
      //   setState(() {
      //     isLoading = false;
      //   });
      // }
    }

    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Headings(context, "Choose specific day(s)"),

            _buildDefaultMultiDatePickerWithValue(),

            // TableCalendar(
            //   firstDay: DateTime.utc(2010, 10, 16),
            //   lastDay: DateTime.utc(2030, 3, 14),
            //   focusedDay: DateTime.now(),
            //   startingDayOfWeek: StartingDayOfWeek.sunday,
            //   availableGestures: AvailableGestures.horizontalSwipe,
            //   calendarStyle: CalendarStyle(
            //     todayDecoration: BoxDecoration(
            //       color: Colors.blueAccent,
            //       shape: BoxShape.circle,
            //     ),
            //     selectedDecoration: BoxDecoration(
            //       color: Colors.deepOrange,
            //       shape: BoxShape.circle,
            //     ),
            //     selectedTextStyle: TextStyle(color: Colors.white),
            //     todayTextStyle: TextStyle(color: Colors.white),
            //     weekendTextStyle: TextStyle(color: Colors.blue),
            //   ),
            //   daysOfWeekStyle: DaysOfWeekStyle(
            //     weekendStyle: TextStyle(color: Colors.blue),
            //   ),
            //   availableCalendarFormats: const {
            //     CalendarFormat.month: 'Month',
            //   },
            //   calendarBuilders: CalendarBuilders(
            //
            //     todayBuilder: (context, date, events) {
            //       // Customize the day cells here
            //       if (!_isSelectable(date)) {
            //         return Container();
            //       }
            //       return Container(
            //         alignment: Alignment.center,
            //         decoration: BoxDecoration(
            //           shape: BoxShape.circle,
            //         ),
            //         child: Text(
            //           date.day.toString(),
            //           style: TextStyle(fontSize: 18,color: Colors.black),
            //         ),
            //       );
            //     },
            //   ),
            //
            //   onDaySelected: (selectedDay, focusedDay) {
            //     setState(() {
            //       // update `_focusedDay` here as well
            //     });
            //   },
            // ),

            InkWell(
              onTap: () {
                BookService(userProvider);
              },
              child: Container(
                margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                padding: const EdgeInsets.only(
                    top: 15, bottom: 15, left: 25, right: 25),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  color: const Color(0xff09426d),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 1.5,
                        offset: const Offset(0, 0))
                  ],
                ),
                child: const Text(
                  "Book now",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Helvetica_Bold",
                      fontSize: 13),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
