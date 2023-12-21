
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_service_planner/Response/SingleVendorPackagesResponse.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../CustomWidgets/Headings.dart';
import '../../CustomWidgets/UpComingEventsSlider.dart';
import '../../Enums/Colors.dart';
import '../../Providers/CacheManager.dart';

class OrgSingleEvent extends StatefulWidget {
  OrgSingleEvent({Key? key,required this.title,required this.image,required this.past,required this.data}) : super(key: key);

  String title;
  String image;
  bool past;
  SingleVendorPackagesResponse data;

  @override
  State<OrgSingleEvent> createState() => _OrgSingleEventState();
}

class _OrgSingleEventState extends State<OrgSingleEvent> {


  double _top = 0;

  int maxDesc = 5;
  String readDesc = "Read more";

  void launchMap() async {
    const double latitude = 37.422;
    const double longitude = -122.084;
    const String mapUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

    if (await canLaunch(mapUrl)) {
      await launch(mapUrl);
    } else {
      throw 'Could not launch $mapUrl';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    carouselImages = widget.data.relatedImg;
  }

  final ImagePicker _BannerPicker = ImagePicker();

  int _currentSlide = 0;

   List<String>? carouselImages = [];

  @override
  Widget build(BuildContext context) {
    final cacheManager = Provider.of<CacheManagerProvider>(context).cacheManager;


    return Stack(
        children: [
          Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height,
            margin:  const EdgeInsets.only(top: kToolbarHeight - 20,),
            child: Scaffold(
              backgroundColor: Colors.white,

              appBar: AppBar(
                elevation: 0.4,
                backgroundColor: Colors.white,
                leading: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back_outlined,
                      size: 25,
                      color: Colors.black.withOpacity(0.8),
                    )),
                title: Text(
                  "Event Details",
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.8),
                      fontFamily: "Helvetica_Bold",
                      fontSize: 16),
                ),
                centerTitle: true,
                automaticallyImplyLeading: false,
                actions: [
                  InkWell(
                    onTap: () => Share.share(                                 " ${widget.data.venueMapLink}",
                    ),
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
                color: Colors.white,

                margin: const EdgeInsets.only(top: 0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Image Container
                      Stack(
                        children:[
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
                              color: appPrimary,
                              value: 5,
                            ),
                          ),
                          errorWidget: (context, url, error) => const Icon(
                            Icons.error,
                            color: appPrimary,
                          ),
                        ),
                      ),
                    ),

                         widget.past? Positioned(
                              top: 15,left: 15,right: 15,
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.only(top: 8,bottom: 8),
                                decoration: const BoxDecoration(
                                  color: Color(0xff727272),
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15))
                                ),
                                child: const Text("This event has ended.",
                                style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.bold),),
                              ),

                         )
                             :
                             const SizedBox()
                  ]
                      ),

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
                          "\$${widget.data.priceRangeStart} - \$${widget.data.priceRangeEnd}",
                          textScaleFactor: 1.3,
                          style: TextStyle(
                            decoration: widget.past? TextDecoration.lineThrough : TextDecoration.none,
                              color: widget.past? Colors.black.withOpacity(0.4) : Colors.black.withOpacity(0.8),
                              fontSize: 12,
                              fontWeight: widget.past? FontWeight.normal : FontWeight.bold,
                              fontFamily: ""),
                        ),
                      ),

                      // //CAT ROW
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   children: [
                      //     Container(
                      //       margin: const EdgeInsets.only(left: 15),
                      //       decoration: BoxDecoration(
                      //           color: Colors.white,
                      //           borderRadius: BorderRadius.circular(20),
                      //           boxShadow: [
                      //             BoxShadow(
                      //                 color: Colors.black.withOpacity(0.1),
                      //                 spreadRadius: 1,
                      //                 blurRadius: 1.5)
                      //           ]),
                      //       padding: const EdgeInsets.only(
                      //           top: 5, bottom: 5, left: 15, right: 15),
                      //       alignment: Alignment.center,
                      //       child: const Text(
                      //         "Music",
                      //         style: TextStyle(
                      //             color: appPrimary,
                      //             fontWeight: FontWeight.bold,
                      //             fontSize: 12),
                      //       ),
                      //     ),
                      //     Container(
                      //       margin: const EdgeInsets.only(left: 15),
                      //       decoration: BoxDecoration(
                      //           color: Colors.white,
                      //           borderRadius: BorderRadius.circular(20),
                      //           boxShadow: [
                      //             BoxShadow(
                      //                 color: Colors.black.withOpacity(0.1),
                      //                 spreadRadius: 1,
                      //                 blurRadius: 1.5)
                      //           ]),
                      //       padding: const EdgeInsets.only(
                      //           top: 5, bottom: 5, left: 15, right: 15),
                      //       alignment: Alignment.center,
                      //       child: const Text(
                      //         "Rap",
                      //         style: TextStyle(
                      //             color: appPrimary,
                      //             fontWeight: FontWeight.bold,
                      //             fontSize: 12),
                      //       ),
                      //     ),
                      //     Container(
                      //       margin: const EdgeInsets.only(left: 15),
                      //       decoration: BoxDecoration(
                      //           color: Colors.white,
                      //           borderRadius: BorderRadius.circular(20),
                      //           boxShadow: [
                      //             BoxShadow(
                      //                 color: Colors.black.withOpacity(0.1),
                      //                 spreadRadius: 1,
                      //                 blurRadius: 1.5)
                      //           ]),
                      //       padding: const EdgeInsets.only(
                      //           top: 5, bottom: 5, left: 15, right: 15),
                      //       alignment: Alignment.center,
                      //       child: const Text(
                      //         "Today",
                      //         style: TextStyle(
                      //             color: appPrimary,
                      //             fontWeight: FontWeight.bold,
                      //             fontSize: 12),
                      //       ),
                      //     ),
                      //   ],
                      // ),

                      //Date Container
                      Container(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, bottom: 0, top: 0),
                        margin: const EdgeInsets.only(bottom: 0,top: 15),
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
                                    color: appPrimary,
                                  ),
                                ),

                                const SizedBox(
                                  width: 15,
                                ),

                                //Details Column
                                Text(
                                 " ${widget.data.timings}",
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
                        padding: const EdgeInsets.only(top: 10,bottom: 10,left: 15,right: 15),
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
                                    Icons.reduce_capacity,
                                    size: 20,
                                    color: appPrimary,
                                  ),
                                ),

                                const SizedBox(
                                  width: 15,
                                ),

                                //Details Column
                                Text(
                                  " ${widget.data.capacity}",

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
                        padding: const EdgeInsets.only(top: 10,bottom: 10,left: 15,right: 15),

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
                                    color: appPrimary,
                                  ),
                                ),

                                const SizedBox(
                                  width: 15,
                                ),

                                //Details Column
                                Text(
                                    " ${widget.data.location}",
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
                        padding: const EdgeInsets.only(top: 5,bottom: 0,left: 0,right: 0),
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

                            Text("About",overflow: TextOverflow.ellipsis,
                                style:
                                 TextStyle(color: Colors.black.withOpacity(0.8),fontWeight: FontWeight.bold,fontFamily: "Helvetica_Bold", fontSize: 18)),


                            const SizedBox(height: 15 ,),

                            RichText(
                              maxLines: maxDesc,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                style: DefaultTextStyle.of(context).style,
                                children: <TextSpan>[
                                  TextSpan(
                                    text: '${widget.data.about}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Helvetica_Bold",
                                        color: Colors.black.withOpacity(0.8)),
                                  ),
            //                 TextSpan(
            //                 text: 'Day: 1\n',
            //                 style: TextStyle(
            //                 fontWeight: FontWeight.bold,
            //                 fontFamily: "Helvetica_Bold",
            //                 color: Colors.black.withOpacity(0.8),fontSize: 13),
            // ),
            //                       TextSpan(
            //                         style: TextStyle(
            //                             color: Colors.black.withOpacity(0.8),
            //                             fontSize: 13),
            //                         text:
            //                         '07:00 AM - 09:00 AM: Reach Kodaikanal on your own transport, Have Freshen Up & Breakfast.\n09:00 AM: Start trek from KodaikanaI(Dolphin Nose) to Vellagavi\n01:00 PM; Reach Campsite & have Lunch\n02:00 PM: Trek to View point'
            //                     "\n05:00 PM: Reach back to Campsite"
            //                     "\n07:00 PM: Enjoy Campfire & have Dinner(Overnight stay in Tents)"
            //                       ),
            //
            //                       //Day 2
            //                       TextSpan(
            //                         text: '\n\nDay: 2\n',
            //                         style: TextStyle(
            //                             fontWeight: FontWeight.bold,
            //                             fontFamily: "Helvetica_Bold",
            //                             color: Colors.black.withOpacity(0.8),fontSize: 13),
            //                       ),
            //                       TextSpan(
            //                           style: TextStyle(
            //                               color: Colors.black.withOpacity(0.8),
            //                               fontSize: 13),
            //                           text:
            //                           '07:00 AM - 09:00 AM: Reach Kodaikanal on your own transport, Have Freshen Up & Breakfast.\n09:00 AM: Start trek from KodaikanaI(Dolphin Nose) to Vellagavi\n01:00 PM; Reach Campsite & have Lunch\n02:00 PM: Trek to View point'
            //                               "\n05:00 PM: Reach back to Campsite"
            //                               "\n07:00 PM: Enjoy Campfire & have Dinner(Overnight stay in Tents)"
            //                       ),
            //
            //                       //Inclusions
            //                       TextSpan(
            //                         text: '\n\nInclusions\n',
            //                         style: TextStyle(
            //                             fontWeight: FontWeight.bold,
            //                             fontFamily: "Helvetica_Bold",
            //                             color: Colors.black.withOpacity(0.8),fontSize: 13),
            //                       ),
            //                       TextSpan(
            //                           style: TextStyle(
            //                               color: Colors.black.withOpacity(0.8),
            //                               fontSize: 13),
            //                           text:
            //                           'Trekking Guide.\nAccomodation(Sharing Tents)\nCampfire\n1 Breakfast / 1 Lunch / 1 Dinner'
            //                               "\nForest Permissions"
            //                               "\nBasic First-Aid"
            //                       ),
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
                                    color: appPrimary,
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
                        child: Text("Location",overflow: TextOverflow.ellipsis,
                            style:
                            TextStyle(color: Colors.black.withOpacity(0.8),fontWeight: FontWeight.bold,fontFamily: "Helvetica_Bold", fontSize: 18)),
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
                                    // image: const DecorationImage(
                                    //   image: NetworkImage(
                                    //       "https://developers.google.com/static/maps/images/landing/hero_maps_static_api.png"),
                                    //   fit: BoxFit.cover,
                                    // )
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: CachedNetworkImage(
                                      imageUrl: "https://developers.google.com/static/maps/images/landing/hero_maps_static_api.png",
                                      cacheManager: cacheManager,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => const Center(
                                        child: CircularProgressIndicator(
                                          color: appPrimary,
                                          value: 5,
                                        ),
                                      ),
                                      errorWidget: (context, url, error) => const Icon(Icons.error,color: appPrimary,),
                                    ),
                                  ),
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
                                            color: appPrimary,
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
                                  "Foschini Park",
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
                                  "278 River St - Berlin, Germany",
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Text("Photos",overflow: TextOverflow.ellipsis,
                                style:
                                TextStyle(color: Colors.black.withOpacity(0.8),fontWeight: FontWeight.bold,fontFamily: "Helvetica_Bold", fontSize: 18)),

                            InkWell(
                              onTap: ()
                              {
                                showCupertinoModalPopup(
                                    context: context, builder: (BuildContext context)
                                {
                                  return CupertinoActionSheet(
                                    title: const Text("Edit Photo"),
                                    cancelButton: CupertinoActionSheetAction(
                                      onPressed: ()
                                      {
                                        Navigator.pop(context);
                                      }, child: const Text("Cancel",style: TextStyle(color: Color(
                                        0xffff0000)),),
                                    ),
                                    actions: [
                                      CupertinoActionSheetAction(
                                          onPressed: () async {
                                            final XFile? image = await _BannerPicker.pickImage(source: ImageSource.gallery);
                                            if (image == null) return;
                                            // final imageTemp = File(image.path);
                                            //setState(() => Provider.of<UserClass>(context).profilePicture = imageTemp);
                                          },
                                          child: const Text("Choose Photo",style: TextStyle(color: appPrimary),)),

                                      CupertinoActionSheetAction(
                                          onPressed: () async {
                                            final XFile? photo = await _BannerPicker.pickImage(source: ImageSource.camera);
                                          },
                                          child: const Text("Take Photo",style: TextStyle(color: appPrimary),)),

                                    ],
                                  );
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: const [

                                  Icon(Icons.camera_alt,color: appPrimary,size: 20,),

                                  SizedBox(width: 5,),

                                  Text("Add photos",overflow: TextOverflow.ellipsis,
                                      style:
                                      TextStyle(color: appPrimary,fontWeight: FontWeight.bold,fontFamily: "", fontSize: 14)),



                                ],
                              ),
                            ),

                          ],
                        ),
                      ),

                      //Photos Con
                      Column(
                        children: [
                          CarouselSlider.builder(
                            itemCount: carouselImages?.length ?? 0,
                            itemBuilder: (BuildContext context, int index,int a) {
                              return Container(
                                margin: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
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
                                        color: appPrimary,
                                        value: 5,
                                      ),
                                    ),
                                    errorWidget: (context, url, error) => const Icon(Icons.error, color: appPrimary),
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
                                  margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: _currentSlide == index ?  appPrimary : Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      //Visit Site Con
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        margin: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
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
                                  color: appPrimary),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Transform.rotate(
                                angle: 45 * 3.1415926535 / 180,
                                child: const Icon(
                                  Icons.arrow_upward,
                                  size: 20,
                                  color: appPrimary,
                                ))
                          ],
                        ),
                      ),

                      thickBorder(context),


                    ],
                  ),
                ),
              ),
            ),
          ),

          Positioned(

            bottom: 15,left: 15,right: 15,
            child: Container(
              //height: MediaQuery.of(context).size.height * 0.1,
              decoration: const BoxDecoration(
                color: Colors.transparent,

              ),
              child: //Request to join Container
              widget.past?
              Container(
                padding: const EdgeInsets.only(
                    top: 15, bottom: 15, left: 25, right: 25),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xffc7c6c6),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: const Offset(0,0)
                    )
                  ],
                ),
                child: const Text(
                  "Event Ended",
                  style: TextStyle(
                      color: Color(0xff414141),
                      fontFamily: "Helvetica_Bold",
                      fontSize: 13),
                ),
              )
                  :
              Container(
                padding: const EdgeInsets.only(
                    top: 15, bottom: 15, left: 25, right: 25),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color:  appPrimary,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 1.5,
                        offset: const Offset(0,0)
                    )
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [

                    Icon(Icons.edit_calendar,color: Color(0xffffffff),size: 15,),

                    SizedBox(width: 5,),

                    Text(
                      "Edit Event",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Helvetica_Bold",
                          fontSize: 12),
                    ),
                  ],
                ),
              ),

            ),)
        ]
    );
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
          borderRadius: BorderRadius.circular(10),
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
                style:
                TextStyle(color: Colors.black.withOpacity(0.4), fontSize: 12),
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
                  color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
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
                              color: Colors.black.withOpacity(0.6), fontSize: 12),
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
                              color: Colors.black.withOpacity(0.6), fontSize: 12),
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
                              color: Colors.black.withOpacity(0.6), fontSize: 12),
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
                              color: Colors.black.withOpacity(0.6), fontSize: 12),
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
                              color: Colors.black.withOpacity(0.6), fontSize: 12),
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
                              style:
                              TextStyle(color: Colors.black.withOpacity(0.4)),
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
                              style:
                              TextStyle(color: Colors.black.withOpacity(0.4)),
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
