import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:socialapp/CustomWidgets/CategoriesGrid.dart';
import 'package:socialapp/CustomWidgets/Headings.dart';
import 'package:socialapp/CustomWidgets/PopularNowSlider.dart';
import 'package:socialapp/LocationPage.dart';

import '../CustomWidgets/CustomAppBar.dart';
import '../CustomWidgets/Sort&Filter.dart';
import '../Providers/CacheManager.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {

  Color inDoorColor = const Color(0xfffcfafa);
  String _selectedSize = "Sort By";

  final Completer<GoogleMapController> _controller = Completer();
  LatLng _currentLatLng = LatLng(0, 0); // Default to (0, 0) or any other initial value

  bool _locationLoaded = false;

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();

  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await determinePosition();

      setState(() {
        _currentLatLng = LatLng(position.latitude, position.longitude);
        _locationLoaded = true; // Mark that the location has been loaded
      });

      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(
        CameraUpdate.newLatLngZoom(_currentLatLng, 7),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCurrentLocation();
  }


  @override
  Widget build(BuildContext context) {

    final cacheManager = Provider.of<CacheManagerProvider>(context).cacheManager;


    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        // appBar: PreferredSize(
        //   preferredSize: Size.fromHeight(kToolbarHeight*2),
        //   child: CustomAppBar(),
        // ),
        body: RefreshIndicator(
          onRefresh: ()
          {
            return Future.delayed(Duration(seconds: 2));
          },
          color: const Color(0xffff1f6f),
          backgroundColor: Colors.white,
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 0),
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Container(
                  height: MediaQuery.of(context).size.height*0.065,

                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.black.withOpacity(0.1)))
                  ),
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(left: 10,bottom: 10,top: 10),
                    scrollDirection: Axis.horizontal,
                    children: [

                      //Sort By
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            context: context,
                            builder: (BuildContext context) => const SortandFilter(),
                          );
                        },
                        child: Container(
                          alignment: Alignment.center,
                          //width: MediaQuery.of(context).size.width*0.25,

                          margin: const EdgeInsets.only(right: 15),
                          padding: const EdgeInsets.only(left: 25,right: 25,bottom: 5,top: 5),

                          decoration: BoxDecoration(
                              color: const Color(0xfffcfafa),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.15),
                                    blurRadius: 1,
                                    offset: const Offset(0, 0))
                              ]),
                          child: Row(
                            children: [

                              Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.identity()..scale(-1.0, 1.0, 1.0),
                                child: const Icon(Icons.sort,size: 17,color: Color(0xffff1f6f)),
                              ),

                              const SizedBox(width: 5,),

                              Text(
                                "$_selectedSize",
                                style: const TextStyle(color: Color(0xffff1f6f),fontWeight: FontWeight.bold,fontSize: 12),
                              ),

                              const SizedBox(width: 5,),

                              const Icon(Icons.keyboard_arrow_down,size: 18,color: Color(0xffff1f6f))
                            ],
                          ),
                        ),
                      ),

                      //In Door Container
                      GestureDetector(
                        onTap: ()
                        {
                          setState(() {
                            inDoorColor = const Color(0xffff1f6f);
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          //width: MediaQuery.of(context).size.width*0.25,

                          margin: const EdgeInsets.only(right: 15),
                          padding: const EdgeInsets.only(left: 25,right: 25,bottom: 5,top: 5),
                          decoration: BoxDecoration(
                              color: inDoorColor,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.15),
                                    blurRadius: 1,
                                    offset: const Offset(0, 0))
                              ]),
                          child: Text(
                            "In Door",
                            style:  TextStyle(color: (inDoorColor == const Color(0xffff1f6f))? Colors.white : Color(0xffff1f6f) ,fontWeight: FontWeight.bold,fontSize: 12),
                          ),
                        ),
                      ),

                      // //Price Range
                      // GestureDetector(
                      //   onTap: () {
                      //     showModalBottomSheet(
                      //
                      //       shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(
                      //         top: Radius.circular(15),
                      //       ),),
                      //       context: context,
                      //       builder: (BuildContext context) {
                      //         return  Container(
                      //             height: MediaQuery.of(context).size.height*0.35,
                      //             decoration: BoxDecoration(
                      //               borderRadius: BorderRadius.circular(15),
                      //             ),
                      //             child: PriceRangeFilter());
                      //       },
                      //     );
                      //   },
                      //   child: Container(
                      //     alignment: Alignment.center,
                      //     //width: MediaQuery.of(context).size.width*0.25,
                      //
                      //     margin: const EdgeInsets.only(right: 0),
                      //     padding: const EdgeInsets.only(left: 25,right: 25,bottom: 5,top: 5),
                      //
                      //     decoration: BoxDecoration(
                      //         color: const Color(0xfff3f5f7),
                      //         borderRadius: BorderRadius.circular(15),
                      //         boxShadow: [
                      //           BoxShadow(
                      //               color: Colors.black.withOpacity(0.15),
                      //               blurRadius: 1,
                      //               offset: const Offset(0, 0))
                      //         ]),
                      //     child: Row(
                      //       children: [
                      //
                      //         Container(
                      //             decoration: BoxDecoration(
                      //                 borderRadius: BorderRadius.circular(50),
                      //                 color: const Color(0xfff3f5f7),
                      //                 border: Border.all(color: Colors.black.withOpacity(0.5))
                      //               // boxShadow: [
                      //               //   BoxShadow(
                      //               //     color: Colors.black.withOpacity(0.5),
                      //               //     spreadRadius: 1,
                      //               //     blurRadius: 0.5,
                      //               //     offset: Offset(0,0)
                      //               //   )
                      //               // ]
                      //             ),
                      //             padding: const EdgeInsets.all(2),
                      //             child: const Icon(Icons.price_check,size: 12,)),
                      //
                      //         const SizedBox(width: 5,),
                      //
                      //         const Text(
                      //           "Price Range",
                      //           style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),
                      //         ),
                      //
                      //         const SizedBox(width: 5,),
                      //
                      //         const Icon(Icons.keyboard_arrow_down,size: 18,)
                      //       ],
                      //     ),
                      //   ),
                      // ),

                      //Clear all Filters
                      GestureDetector(
                        onTap: ()
                        {
                          setState(() {
                            inDoorColor = Color(0xfffcfafa);
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          //width: MediaQuery.of(context).size.width*0.25,

                          padding: const EdgeInsets.only(left: 25,right: 25,bottom: 5,top: 5),
                          // decoration: BoxDecoration(
                          //     color: inStoreColor,
                          //     borderRadius: BorderRadius.circular(20),
                          //     boxShadow: [
                          //       BoxShadow(
                          //           color: Colors.black.withOpacity(0.15),
                          //           blurRadius: 1,
                          //           offset: const Offset(0, 0))
                          //     ]),
                          child:  Text(
                            "Clear all",
                            style:  TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 12,fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),

                // //Searchbar
                // Container(
                //   color: const Color(0xffff1f6f),
                //   child: Container(
                //     height: 40,
                //     //width: MediaQuery.of(context).size.width*0.8,
                //     margin: const EdgeInsets.only(left: 20,right: 20,bottom: 20,top: 20),
                //     padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5,top: 5),
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(15),
                //       color: const Color(0xfff4f4f6),
                //       boxShadow: [
                //         BoxShadow(
                //           color: Colors.black.withOpacity(0.1),
                //           spreadRadius: 1,
                //           blurRadius: 1,
                //           offset: const Offset(0, 0), // changes position of shadow
                //         ),
                //       ],
                //     ),
                //
                //     child: Row(
                //       crossAxisAlignment: CrossAxisAlignment.center,
                //       mainAxisAlignment: MainAxisAlignment.start,
                //       children: [
                //
                //         Hero(
                //           tag: "widget.tag",
                //
                //           child: Container(
                //               padding: const EdgeInsets.only(left: 5,right: 0,top: 0,bottom: 0),
                //               decoration: BoxDecoration(
                //                   borderRadius: BorderRadius.circular(12),
                //                 color: const Color(0xfff4f4f6),
                //
                //               ),
                //               child: const Icon(Icons.search,color: Colors.black, size: 20,)),
                //         ),
                //
                //         const SizedBox(width: 10),
                //
                //         Expanded(
                //             child: Container(
                //               padding: const EdgeInsets.only(bottom: 0),
                //               child: const TextField(
                //                 cursorColor: Color(0xffff1f6f),
                //                 //onChanged: (query) => setState(() {}),
                //                 style: TextStyle(color: Colors.black, height: 1.1, fontSize: 14),
                //                 decoration: InputDecoration(
                //                   //prefixIcon: Icon(Icons.search, color: Color(0xFF5D5D67), size: 23),
                //                     hintText: "Explore upcoming events",
                //                     hintStyle: TextStyle(color: Color(0xFF8F8F9E), fontSize: 14),
                //                     border: InputBorder.none),
                //               ),
                //             )),
                //
                //       ],
                //     ),
                //   ),
                // ),
                //
                // shadowLine(context),
                //
                // const SizedBox(height: 15,),


                InkWell(
                  onTap: () => Navigator.push(context, CupertinoPageRoute(builder: (_) => LocationPage())),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15,bottom: 15, top: 15),
                        child: Row(
                          children: [
                            Text("Find events near: ",
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.8),fontWeight: FontWeight.bold,fontSize: 15,fontFamily: "Helvetica_Bold"
                            ),),

                            const Text("KHI, PAK",
                              style: TextStyle(
                                  color: Color(0xffff1f6f),fontWeight: FontWeight.bold,fontSize: 15,fontFamily: "Helvetica_Bold"
                              ),),

                            const SizedBox(width: 10,),

                            Container(
                                decoration: const BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Color(0xffff1f6f),width: 1))
                                ),
                                child: const Icon(Icons.edit,size: 12,color: Color(0xffff1f6f)))
                          ],
                        ),
                      ),

                      //Google Maps Container
                      AbsorbPointer(
                        absorbing: true,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height*0.25,
                          margin: const EdgeInsets.only(left: 15,right: 15,bottom: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            // image: const DecorationImage(
                            //   image: NetworkImage(
                            //     "https://www.google.com/maps/d/thumbnail?mid=1wMZLD-KoIBt-zG0r8ziRkZeqgUA&hl=en_US"
                            //   ),
                            //   fit: BoxFit.cover
                            // )
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: GoogleMap(
                              onMapCreated: (GoogleMapController controller) {
                                _controller.complete(controller);
                              },
                              zoomControlsEnabled: false,
                              initialCameraPosition: _locationLoaded
                                  ? CameraPosition(target: _currentLatLng, zoom: 7)
                                  : CameraPosition(target: LatLng(0, 0), zoom: 7),

                              mapType: MapType.normal,
                              markers: {
                                Marker(
                                  markerId: MarkerId('currentLocation'),
                                  position: _currentLatLng,
                                  icon: BitmapDescriptor.defaultMarker,
                                ),
                              },
                            ),
                          ),
                          // child: ClipRRect(
                          //   borderRadius: BorderRadius.circular(8),
                          //   child: CachedNetworkImage(
                          //     imageUrl: "https://www.google.com/maps/d/thumbnail?mid=1wMZLD-KoIBt-zG0r8ziRkZeqgUA&hl=en_US",
                          //     cacheManager: cacheManager,
                          //     fit: BoxFit.cover,
                          //     placeholder: (context, url) => const Center(
                          //       child: CircularProgressIndicator(
                          //         color: Color(0xffff1f6f),
                          //         value: 5,
                          //       ),
                          //     ),
                          //     errorWidget: (context, url, error) => const Icon(Icons.error,color: Color(0xffff1f6f),),
                          //   ),
                          // ),
                        ),
                      ),
                    ],
                  ),
                ),

                thickBorder(context),


                const Padding(
                  padding: EdgeInsets.only(left: 15,top: 15,bottom: 0),
                  child: Text("Explore",overflow: TextOverflow.ellipsis,
                      style:
                      TextStyle(fontFamily: "Helvetica_Bold",color: Color(0xff000000),fontWeight: FontWeight.bold, fontSize: 18)),
                ),

                //Popular Now
                Padding(
                  padding: const EdgeInsets.only(left: 15,top: 10),
                  child: Text("Popular now",
                  style: TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 14,fontFamily: "Helvetica_Bold"),),
                ),

                //Popular now List View
                popNowSlider(context),

                //Outdoors & Adventure
                Padding(
                  padding: const EdgeInsets.only(left: 15,top: 10,right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Outdoors & Adventure",
                        style: TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 14,fontFamily: "Helvetica_Bold"),),

                      const Text("See all",
                      style: TextStyle(
                        color: Color(0xff000000),
                        fontWeight: FontWeight.bold,fontSize: 13
                      ),)
                    ],
                  ),
                ),

                outDoorSlider(context),

                //Learning
                Padding(
                  padding: const EdgeInsets.only(left: 15,top: 10,right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Learning",
                        style: TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 14,fontFamily: "Helvetica_Bold"),),

                      const Text("See all",
                        style: TextStyle(
                            color: Color(0xff000000),
                            fontWeight: FontWeight.bold,fontSize: 13
                        ),)
                    ],
                  ),
                ),

                learningSlider(context),

                //Health & Wellness
                Padding(
                  padding: const EdgeInsets.only(left: 15,top: 10,right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Health & Wellness",
                        style: TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 14,fontFamily: "Helvetica_Bold"),),

                      const Text("See all",
                        style: TextStyle(
                            color: Color(0xff000000),
                            fontWeight: FontWeight.bold,fontSize: 13
                        ),)
                    ],
                  ),
                ),

                healthSlider(context),

                thickBorder(context),


                //Categories Container
                Container(
                  padding: const EdgeInsets.only(bottom: 15,top: 15),
                  width: MediaQuery.of(context).size.width,
                  // decoration: BoxDecoration(
                  //   // color: Color(0xff00556e),
                  //   gradient: LinearGradient(
                  //     begin: Alignment.topLeft,
                  //     end: Alignment.bottomRight,
                  //     stops: [0.1,0.5],
                  //     colors: [
                  //       Color(0xff7dd1ef),
                  //       Color(0xff00556e),
                  //     ]
                  //   )
                  // ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,

                    children: [

                      //Cat Heading
                      Padding(
                        padding: const EdgeInsets.only(left: 15,bottom: 15),
                        child: Text("BROWSE BY CATEGORIES",
                            style:
                            TextStyle(fontFamily: "Helvetica_Bold",color: Colors.black.withOpacity(0.8),fontWeight: FontWeight.bold, fontSize: 18)),
                      ),

                      //Categories Con
                      categoriesCon(context)
                    ],
                  ),
                )



              ],
            ),
          ),
        ),


      ),
    );
  }
}
