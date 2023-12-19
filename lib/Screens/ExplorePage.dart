import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../CustomWidgets/CustomAppBar.dart';
import '../CustomWidgets/Headings.dart';
import '../CustomWidgets/Sort&Filter.dart';
import '../CustomWidgets/TodaySlider.dart';
import '../CustomWidgets/UpComingEventsSlider.dart';
import '../Providers/CacheManager.dart';
import '../modals/AllServiceProvider.dart';

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

      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {

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

    var allServiceProv = Provider.of<AllServiceProvider>(context,listen:false);

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
          color: const Color(0xff09426d),
          backgroundColor: Colors.white,
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 0),
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                //Filters Con
                // Container(
                //   height: MediaQuery.of(context).size.height*0.065,
                //
                //   decoration: BoxDecoration(
                //       border: Border(bottom: BorderSide(color: Colors.black.withOpacity(0.1)))
                //   ),
                //   child: ListView(
                //     physics: const BouncingScrollPhysics(),
                //     padding: const EdgeInsets.only(left: 10,bottom: 10,top: 10),
                //     scrollDirection: Axis.horizontal,
                //     children: [
                //
                //       //Sort By
                //       GestureDetector(
                //         onTap: () {
                //           showModalBottomSheet(
                //             isScrollControlled: true,
                //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                //             context: context,
                //             builder: (BuildContext context) => const SortandFilter(),
                //           );
                //         },
                //         child: Container(
                //           alignment: Alignment.center,
                //           //width: MediaQuery.of(context).size.width*0.25,
                //
                //           margin: const EdgeInsets.only(right: 15),
                //           padding: const EdgeInsets.only(left: 25,right: 25,bottom: 5,top: 5),
                //
                //           decoration: BoxDecoration(
                //               color: const Color(0xfffcfafa),
                //               borderRadius: BorderRadius.circular(20),
                //               boxShadow: [
                //                 BoxShadow(
                //                     color: Colors.black.withOpacity(0.15),
                //                     blurRadius: 1,
                //                     offset: const Offset(0, 0))
                //               ]),
                //           child: Row(
                //             children: [
                //
                //               Transform(
                //                 alignment: Alignment.center,
                //                 transform: Matrix4.identity()..scale(-1.0, 1.0, 1.0),
                //                 child: const Icon(Icons.sort,size: 17,color: Color(0xff09426d)),
                //               ),
                //
                //               const SizedBox(width: 5,),
                //
                //               Text(
                //                 "$_selectedSize",
                //                 style: const TextStyle(color: Color(0xff09426d),fontWeight: FontWeight.bold,fontSize: 12),
                //               ),
                //
                //               const SizedBox(width: 5,),
                //
                //               const Icon(Icons.keyboard_arrow_down,size: 18,color: Color(0xff09426d))
                //             ],
                //           ),
                //         ),
                //       ),
                //
                //       //In Door Container
                //       GestureDetector(
                //         onTap: ()
                //         {
                //           setState(() {
                //             inDoorColor = const Color(0xff09426d);
                //           });
                //         },
                //         child: Container(
                //           alignment: Alignment.center,
                //           //width: MediaQuery.of(context).size.width*0.25,
                //
                //           margin: const EdgeInsets.only(right: 15),
                //           padding: const EdgeInsets.only(left: 25,right: 25,bottom: 5,top: 5),
                //           decoration: BoxDecoration(
                //               color: inDoorColor,
                //               borderRadius: BorderRadius.circular(20),
                //               boxShadow: [
                //                 BoxShadow(
                //                     color: Colors.black.withOpacity(0.15),
                //                     blurRadius: 1,
                //                     offset: const Offset(0, 0))
                //               ]),
                //           child: Text(
                //             "In Door",
                //             style:  TextStyle(color: (inDoorColor == const Color(0xff09426d))? Colors.white : Color(0xff09426d) ,fontWeight: FontWeight.bold,fontSize: 12),
                //           ),
                //         ),
                //       ),
                //
                //       // //Price Range
                //       // GestureDetector(
                //       //   onTap: () {
                //       //     showModalBottomSheet(
                //       //
                //       //       shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(
                //       //         top: Radius.circular(15),
                //       //       ),),
                //       //       context: context,
                //       //       builder: (BuildContext context) {
                //       //         return  Container(
                //       //             height: MediaQuery.of(context).size.height*0.35,
                //       //             decoration: BoxDecoration(
                //       //               borderRadius: BorderRadius.circular(15),
                //       //             ),
                //       //             child: PriceRangeFilter());
                //       //       },
                //       //     );
                //       //   },
                //       //   child: Container(
                //       //     alignment: Alignment.center,
                //       //     //width: MediaQuery.of(context).size.width*0.25,
                //       //
                //       //     margin: const EdgeInsets.only(right: 0),
                //       //     padding: const EdgeInsets.only(left: 25,right: 25,bottom: 5,top: 5),
                //       //
                //       //     decoration: BoxDecoration(
                //       //         color: const Color(0xfff3f5f7),
                //       //         borderRadius: BorderRadius.circular(15),
                //       //         boxShadow: [
                //       //           BoxShadow(
                //       //               color: Colors.black.withOpacity(0.15),
                //       //               blurRadius: 1,
                //       //               offset: const Offset(0, 0))
                //       //         ]),
                //       //     child: Row(
                //       //       children: [
                //       //
                //       //         Container(
                //       //             decoration: BoxDecoration(
                //       //                 borderRadius: BorderRadius.circular(50),
                //       //                 color: const Color(0xfff3f5f7),
                //       //                 border: Border.all(color: Colors.black.withOpacity(0.5))
                //       //               // boxShadow: [
                //       //               //   BoxShadow(
                //       //               //     color: Colors.black.withOpacity(0.5),
                //       //               //     spreadRadius: 1,
                //       //               //     blurRadius: 0.5,
                //       //               //     offset: Offset(0,0)
                //       //               //   )
                //       //               // ]
                //       //             ),
                //       //             padding: const EdgeInsets.all(2),
                //       //             child: const Icon(Icons.price_check,size: 12,)),
                //       //
                //       //         const SizedBox(width: 5,),
                //       //
                //       //         const Text(
                //       //           "Price Range",
                //       //           style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),
                //       //         ),
                //       //
                //       //         const SizedBox(width: 5,),
                //       //
                //       //         const Icon(Icons.keyboard_arrow_down,size: 18,)
                //       //       ],
                //       //     ),
                //       //   ),
                //       // ),
                //
                //       //Clear all Filters
                //       GestureDetector(
                //         onTap: ()
                //         {
                //           setState(() {
                //             inDoorColor = Color(0xfffcfafa);
                //           });
                //         },
                //         child: Container(
                //           alignment: Alignment.center,
                //           //width: MediaQuery.of(context).size.width*0.25,
                //
                //           padding: const EdgeInsets.only(left: 25,right: 25,bottom: 5,top: 5),
                //           // decoration: BoxDecoration(
                //           //     color: inStoreColor,
                //           //     borderRadius: BorderRadius.circular(20),
                //           //     boxShadow: [
                //           //       BoxShadow(
                //           //           color: Colors.black.withOpacity(0.15),
                //           //           blurRadius: 1,
                //           //           offset: const Offset(0, 0))
                //           //     ]),
                //           child:  Text(
                //             "Clear all",
                //             style:  TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 12,fontWeight: FontWeight.bold),
                //           ),
                //         ),
                //       ),
                //
                //     ],
                //   ),
                // ),

                Column(
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
                                color: Color(0xff09426d),fontWeight: FontWeight.bold,fontSize: 15,fontFamily: "Helvetica_Bold"
                            ),),

                          // const SizedBox(width: 10,),
                          //
                          // Container(
                          //     decoration: const BoxDecoration(
                          //       border: Border(bottom: BorderSide(color: Color(0xff09426d),width: 1))
                          //     ),
                          //     child: const Icon(Icons.edit,size: 12,color: Color(0xff09426d)))
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
                        //         color: Color(0xff09426d),
                        //         value: 5,
                        //       ),
                        //     ),
                        //     errorWidget: (context, url, error) => const Icon(Icons.error,color: Color(0xff09426d),),
                        //   ),
                        // ),
                      ),
                    ),
                  ],
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
                  padding: const EdgeInsets.only(left: 15,top: 10,bottom: 10),
                  child: Text("Popular now",
                  style: TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 16,fontFamily: "Helvetica_Bold"),),
                ),

                //Popular now List View
                popularSlider(context,[]),

                //Outdoors & Adventure
                Padding(
                  padding: const EdgeInsets.only(left: 15,top: 10,bottom: 10),

                  child: Text("Outdoors & Adventure",
                    style: TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 16,fontFamily: "Helvetica_Bold"),),
                ),

                decorSlider(context,allServiceProv.decors ?? []),

                //Learning
                Padding(
                  padding: const EdgeInsets.only(left: 15,top: 10,bottom: 10),

                  child: Text("Surprising",
                    style: TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 16,fontFamily: "Helvetica_Bold"),),
                ),

                CatererSlider(context,allServiceProv.caterers ?? []),

                const SizedBox(height: kToolbarHeight/2,)
              ],
            ),
          ),
        ),


      ),
    );
  }
}
