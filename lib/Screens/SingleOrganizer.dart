import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:socialapp/CustomWidgets/CustomAppBar.dart';

import '../CustomWidgets/Headings.dart';
import '../CustomWidgets/OrgSlider.dart';
import '../CustomWidgets/TodaySlider.dart';
import '../CustomWidgets/UpComingEventsSlider.dart';
import '../Providers/CacheManager.dart';
import 'MyProfile.dart';
import 'ProfileDrawer/userDrawer.dart';

class SingleOrganizer extends StatefulWidget {
   SingleOrganizer({Key? key,required this.name, required this.image}) : super(key: key);

  String name;
  String image;

  @override
  State<SingleOrganizer> createState() => _SingleOrganizerState();
}

class _SingleOrganizerState extends State<SingleOrganizer> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  var items = [
    'Page 1',
    'Page 2',
    'Page 3',
    'Page 4',
    'Page 5',
  ];

  bool verifiedFBV = false;
  bool alloffers = false;
  bool codes = false;
  bool deals = false;

  bool progress = false;
  bool Absorb = false;

  ScrollController reviewTabController = ScrollController();
  ScrollController allDealController = ScrollController();
  ScrollController allCodeController = ScrollController();

  final GlobalKey<ScaffoldState> _SingleOrgKey = GlobalKey<ScaffoldState>();


  int reviewTab = 3;
  // int allDealCount = 10;
  // int allCodeCount = 10;

  bool showContent = false;

  bool following = false;
  bool notifications = false;




  reviewTabListener() {
    if (reviewTabController.offset >= reviewTabController.position.maxScrollExtent &&
        reviewTab < int.parse("100")) {
      setState(() {
        Absorb = true;
        progress = true;

        ((reviewTab + 10)!%10 == 0 && (reviewTab + 10) < int.parse("100"))? reviewTab += 10 : reviewTab += 10;

        reviewTabController.animateTo(
          reviewTabController.offset - 10,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut,
        );

        Future.delayed(const Duration(milliseconds: 1000), () {
          setState(() {
            progress = false;
            Absorb = false;
          });
        });
      });
    }
  }
  //
  // allDealListener() {
  //   if (allDealController.offset >= allDealController.position.maxScrollExtent &&
  //       allDealCount < int.parse("${couponList?.length}")) {
  //     setState(() {
  //       Absorb = true;
  //
  //       progress = true;
  //
  //       (allDealCount + 10)!%10 == 0 && (allDealCount + 10) < int.parse("${couponList?.length}")? allDealCount += 10 : allDealCount = int.parse("${couponList?.length}");
  //
  //       allDealController.animateTo(
  //         allDealController.offset - 10,
  //         duration: Duration(milliseconds: 500),
  //         curve: Curves.easeOut,
  //       );
  //
  //       Future.delayed(Duration(milliseconds: 1000), () {
  //         setState(() {
  //           progress = false;
  //           Absorb = false;
  //
  //         });
  //       });
  //     });
  //   }
  // }
  //
  // allCodeListener() {
  //   if (allCodeController.offset >= allCodeController.position.maxScrollExtent &&
  //       allCodeCount < int.parse("${couponList?.length}")) {
  //     setState(() {
  //       Absorb = true;
  //
  //       progress = true;
  //
  //       (allCodeCount + 10)!%10 == 0 && (allCodeCount + 10) < int.parse("${couponList?.length}")? allCodeCount += 10 : allCodeCount = int.parse("${couponList?.length}");
  //
  //       allCodeController.animateTo(
  //         allCodeController.offset - 10,
  //         duration: Duration(milliseconds: 500),
  //         curve: Curves.easeOut,
  //       );
  //
  //       Future.delayed(Duration(milliseconds: 1000), () {
  //         setState(() {
  //           progress = false;
  //           Absorb = false;
  //
  //         });
  //       });
  //     });
  //   }
  // }

  bool topContHeight = true;

  //ScrollController scrollcontroller = ScrollController();

  var unselected = Colors.black.withOpacity(0.6);
  var selected = const Color(0xffff1f6f);

  // _scrollListener() {
  //   // if (scrollcontroller.offset >= scrollcontroller.position.maxScrollExtent &&
  //   //     !scrollcontroller.position.outOfRange) {
  //   //   setState(() {
  //   //     topContHeight = false;
  //   //     print("reached end");
  //   //   });
  //   // }
  //   if (scrollcontroller.offset <= scrollcontroller.position.minScrollExtent &&
  //       topContHeight == false) {
  //     setState(() {
  //       topContHeight = true;
  //       unselected = Colors.black;
  //       selected = const Color(0xff9933ff);
  //       // print("reached top");
  //     });
  //   }
  //   if (scrollcontroller.offset < scrollcontroller.position.maxScrollExtent &&
  //       scrollcontroller.offset > scrollcontroller.position.minScrollExtent &&
  //       topContHeight == true) {
  //     setState(() {
  //       topContHeight = false;
  //       unselected = Colors.white;
  //       selected = Colors.white;
  //       // print("started scrolling");
  //     });
  //   }
  // }

  @override
  void dispose()
  {
    reviewTabController.dispose();
    allDealController.dispose();
    allCodeController.dispose();
    //scrollcontroller.dispose();
    super.dispose();
  }

  Future<void> _refreshData() async {
    // Fetch the latest data from the API

    // Update the state with the new data

  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        showContent = true;
      });
    });
    _refreshData();
  }

  @override
  Widget build(BuildContext context) {

    reviewTabController.addListener(reviewTabListener);

    final cacheManager = Provider.of<CacheManagerProvider>(context).cacheManager;

    //scrollcontroller.addListener(_scrollListener);

    return Scaffold(

      key: _SingleOrgKey,

      endDrawer: Drawer(
        elevation: 10,
        shadowColor: Colors.black.withOpacity(0.5),
        child:  userDrawer(context),


      ),

      backgroundColor: const Color(0xffffffff),



      appBar: AppBar(
        backgroundColor: const Color(0xffff1f6f),
        leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_outlined,size: 23,color: Colors.white,)),
        centerTitle: true,
        elevation: 0,
        title:  Text(widget.name,
          style: const TextStyle(color: Colors.white,fontSize: 16,fontFamily: "Helvetica_Bold"),),

        actions: [
          //Profile Image Container
          InkWell(
            onTap: () {
              _SingleOrgKey.currentState?.openEndDrawer();

            },
            child: Container(
              margin: const EdgeInsets.only(right: 15,bottom: 10,top: 10),
              padding: const EdgeInsets.all(3),
              constraints: const BoxConstraints(
                  maxHeight: 50,
              ),
              decoration: BoxDecoration(
                //color: Color(0xffffffff),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white,width: 2)
              ),
              child: const Icon(Icons.person,size: 25,color: Colors.white,),
            ),
          ),
        ],

        // bottom: PreferredSize(
        //   preferredSize: const Size.fromHeight(kToolbarHeight),
        //   child: Container(
        //     constraints: const BoxConstraints(
        //         maxHeight: 40
        //     ),
        //     //width: MediaQuery.of(context).size.width*0.8,
        //     margin: const EdgeInsets.only(left: 15,right: 15,bottom: 15,top: 0),
        //     padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5,top: 5),
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(10),
        //       color: Colors.white,
        //       boxShadow: [
        //         BoxShadow(
        //           color: Colors.black.withOpacity(0.1),
        //           spreadRadius: 0,
        //           blurRadius: 3,
        //           offset: const Offset(0, 0), // changes position of shadow
        //         ),
        //       ],
        //     ),
        //
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.start,
        //       children: [
        //
        //         Container(
        //             padding: const EdgeInsets.only(left: 5,right: 0,top: 0,bottom: 0),
        //             decoration: BoxDecoration(
        //                 borderRadius: BorderRadius.circular(12),
        //                 color: const Color(0xffffffff)
        //             ),
        //             child: const Icon(Icons.search,color: Color(0xffff1f6f), size: 22,)),
        //
        //         const SizedBox(width: 10),
        //
        //         Expanded(
        //             child: Container(
        //               padding: const EdgeInsets.only(bottom: 0),
        //               child: TextField(
        //                 enabled: true,
        //                 //controller: _searchCon,
        //                 //controller: _searchCon,
        //                 //focusNode: _focusNode,
        //                 //onChanged: (query) => setState(() {}),
        //                 style: const TextStyle(color: Colors.black, height: 1, fontSize: 14),
        //                 decoration: InputDecoration(
        //                   //prefixIcon: Icon(Icons.search, color: Color(0xFF5D5D67), size: 23),
        //                     hintText: "Search",
        //                     hintStyle: TextStyle(color: Colors.black.withOpacity(0.35),fontWeight: FontWeight.bold ,fontSize: 13),
        //                     border: InputBorder.none),
        //               ),
        //             )),
        //
        //       ],
        //     ),
        //   ),
        // ),
      ),

      //Filters Button
      // floatingActionButton: GestureDetector(
      //   onTap: () {
      //     showModalBottomSheet(
      //         isScrollControlled: true,
      //         shape: const RoundedRectangleBorder(
      //             borderRadius: BorderRadius.only(
      //                 topLeft: Radius.circular(30),
      //                 topRight: Radius.circular(30))),
      //         context: context,
      //         builder: (BuildContext context) {
      //           return Container(
      //               height: MediaQuery.of(context).size.height * 0.5,
      //               child: filterCon(context));
      //         });
      //   },
      //   child: Container(
      //     decoration: BoxDecoration(
      //         color: const Color(0xff9933ff),
      //         borderRadius: BorderRadius.circular(100)),
      //     padding: const EdgeInsets.all(15),
      //     child: const Icon(
      //       Icons.filter_alt_outlined,
      //       color: Colors.white,
      //     ),
      //   ),
      // ),

      body: AbsorbPointer(
        absorbing: Absorb,
        child: SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(children: [

              Container(
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(top: 0,bottom: 15),
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      //Top Details Container
                      Container(
                        margin: const EdgeInsets.only(
                            top: 0, bottom: 0, left: 15, right: 15),
                        width: MediaQuery.of(context).size.width,
                        //height: MediaQuery.of(context).size.height*0.2,

                        //height: topContHeight? null : 0,
                        padding: const EdgeInsets.only(
                            left: 0, right: 0, top: 10, bottom: 0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                            const BorderRadius.only(
                                bottomRight:
                                Radius.circular(
                                    10),
                                bottomLeft:
                                Radius.circular(
                                    10)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black
                                      .withOpacity(0.1),
                                  offset: const Offset(0, 0),
                                  blurRadius: 10)
                            ]),
                        child: Column(
                          children: [
                            //Image & Title Row
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15),
                              child: Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                        right: 10),
                                    height: 75,
                                    width: 75,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(
                                            10),
                                        // image: DecorationImage(
                                        //     image: NetworkImage(
                                        //         "https://www.findbestvouchers.com/assets/uploads/required/placeholder.png"),
                                        //     fit: BoxFit.contain),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black
                                                  .withOpacity(0.2),
                                              blurRadius: 5,
                                              offset: const Offset(
                                                  0, 0))
                                        ]),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: CachedNetworkImage(
                                        imageUrl: widget.image,
                                        cacheManager: cacheManager,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => const Center(
                                          child: CircularProgressIndicator(
                                            color: Color(0xffff1f6f),
                                            value: 5,
                                          ),
                                        ),
                                        errorWidget: (context, url, error) => const Icon(Icons.error, color: Color(0xffff1f6f)),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        //Title
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Row(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 2),
                                                  child: Text(
                                                      widget.name,
                                                      maxLines: 2,
                                                      overflow:
                                                      TextOverflow
                                                          .ellipsis,
                                                      style: const TextStyle(
                                                          fontFamily:
                                                          "Helvetica_Bold",
                                                          fontSize: 17)),
                                                ),


                                                Container(
                                                    margin: const EdgeInsets.only(left: 5),
                                                    decoration: BoxDecoration(
                                                      //color: Colors.white,
                                                      borderRadius: BorderRadius.circular(10),

                                                    ),
                                                    child: const Icon(Icons.verified,size: 20,color: Color(0xffffc107),)),
                                              ],
                                            ),

                                            //Following
                                            InkWell(
                                              onTap: ()
                                              {
                                                setState(() {
                                                  following = !following;
                                                });

                                                if(following == true) {
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(
                                                        behavior: SnackBarBehavior.floating,
                                                        duration: const Duration(seconds: 2),
                                                        showCloseIcon: true,
                                                        padding: const EdgeInsets.all(15),
                                                        backgroundColor: Colors.black.withOpacity(0.7),
                                                        closeIconColor: Colors.white,
                                                        //width: MediaQuery.of(context).size.width,
                                                        margin: const EdgeInsets.all(15),
                                                        content: Container(
                                                          child: Text("You started following ${widget.name}",
                                                            style: const TextStyle(fontSize: 12,color: Colors.white),),
                                                        )
                                                    )
                                                );
                                                }else
                                                  {
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                        SnackBar(
                                                            behavior: SnackBarBehavior.floating,
                                                            duration: const Duration(seconds: 2),
                                                            showCloseIcon: true,
                                                            padding: const EdgeInsets.all(15),
                                                            backgroundColor: Colors.black.withOpacity(0.7),
                                                            closeIconColor: Colors.white,
                                                            //width: MediaQuery.of(context).size.width,
                                                            margin: const EdgeInsets.all(15),
                                                            content: Container(
                                                              child: Text("You stopped following ${widget.name}",
                                                                style: const TextStyle(fontSize: 12,color: Colors.white),),
                                                            )
                                                        )
                                                    );
                                                  }
                                              },
                                              child: Container(
                                                padding: const EdgeInsets.only(top: 5 , bottom: 5,left: 10,right: 10),
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    color:following? const Color(0xffff1f6f) : Colors.white,
                                                    borderRadius: BorderRadius.circular(20),
                                                    border: Border.all(color:const Color(0xffff1f6f),width: 0.5)
                                                ),
                                                child:following? const Text("Following",
                                                  style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,
                                                      fontSize: 12),)
                                                :
                                                const Text("Follow",
                                                  style: TextStyle(color: Color(0xffff1f6f),fontWeight: FontWeight.bold,
                                                      fontSize: 12),),
                                              ),
                                            )
                                          ],
                                        ),


                                        const SizedBox(
                                          height: 10,
                                        ),

                                        //Location / Joining Row
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .start,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(Icons.location_on_outlined,color: Colors.black.withOpacity(0.6),size: 15),
                                                const SizedBox(width: 2,),
                                                Text("Cupertino, CA",
                                                  style: TextStyle(color: Colors.black.withOpacity(0.6),fontSize: 12),),
                                              ],
                                            ),

                                            const SizedBox(width: 5,),

                                            Row(
                                              children: [
                                                Icon(Icons.calendar_month_outlined,color: Colors.black.withOpacity(0.6),size: 15,),
                                                const SizedBox(width: 2,),
                                                Text("Joined in 2020",
                                                  maxLines: 1,overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(color: Colors.black.withOpacity(0.6),fontSize: 12),),
                                              ],
                                            )
                                          ],
                                        ),

                                        const SizedBox(
                                          height: 10,
                                        ),

                                        //Following / Followers Row
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 3),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text("0 ",
                                                    style: TextStyle(color: Colors.black.withOpacity(0.8),fontWeight: FontWeight.bold,fontSize: 12),),

                                                  Text("Following",
                                                    style: TextStyle(color: Colors.black.withOpacity(0.6),fontSize: 12),),
                                                ],
                                              ),

                                              const SizedBox(width: 10,),

                                              Row(
                                                children: [
                                                  Text("9.1M ",
                                                    style: TextStyle(color: Colors.black.withOpacity(0.8),fontWeight: FontWeight.bold,fontSize: 12),),

                                                  Text("Followers",
                                                    style: TextStyle(color: Colors.black.withOpacity(0.6),fontSize: 12),),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),

                            const SizedBox(
                              height: 20,
                            ),

                            //Fav Store & Visit Store Row
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,

                                    children: [

                                      //Fav Container
                                      GestureDetector(
                                        onTap: ()
                                        {
                                          Share.share("123");
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                              left: 0, right: 10),
                                          alignment: Alignment.center,
                                          padding:
                                          const EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                              BorderRadius.circular(
                                                  10),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.2),
                                                    blurRadius: 1.5,
                                                    offset: const Offset(
                                                        0, 0))
                                              ]),
                                          child: const Icon(
                                            Icons.share_outlined,
                                            color: Color(0xffff1f6f),
                                          ),
                                        ),
                                      ),

                                      //Notifications Container
                                      GestureDetector(
                                        onTap: ()
                                        {
                                          setState(() {
                                            notifications = !notifications;
                                          });
                                          if(notifications == true) {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                  behavior: SnackBarBehavior.floating,
                                                  duration: const Duration(seconds: 3),
                                                  showCloseIcon: true,
                                                  padding: const EdgeInsets.all(15),
                                                  backgroundColor: Colors.black.withOpacity(0.7),
                                                  closeIconColor: Colors.white,
                                                  //width: MediaQuery.of(context).size.width,
                                                  margin: const EdgeInsets.all(15),
                                                  content: Container(
                                                    child: Text("Notifications are turned on for ${widget.name}",
                                                      style: const TextStyle(fontSize: 12,color: Colors.white),),
                                                  )
                                              )
                                          );
                                          }else
                                            {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(
                                                      behavior: SnackBarBehavior.floating,
                                                      duration: const Duration(seconds: 3),
                                                      showCloseIcon: true,
                                                      padding: const EdgeInsets.all(15),
                                                      backgroundColor: Colors.black.withOpacity(0.7),
                                                      closeIconColor: Colors.white,
                                                      //width: MediaQuery.of(context).size.width,
                                                      margin: const EdgeInsets.all(15),
                                                      content: Container(
                                                        child: Text("Notifications are turned off for ${widget.name}",
                                                          style: const TextStyle(fontSize: 12,color: Colors.white),),
                                                      )
                                                  )
                                              );
                                            }
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                              left: 0, right: 10),
                                          alignment: Alignment.center,
                                          padding:
                                          const EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                              color: notifications? const Color(0xffff1f6f) : Colors.white,
                                              borderRadius:
                                              BorderRadius.circular(
                                                  10),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.2),
                                                    blurRadius: 1.5,
                                                    offset: const Offset(
                                                        0, 0))
                                              ]),
                                          child: notifications?

                                          const Icon(
                                            Icons.notifications,
                                            color: Colors.white,
                                          )
                                              :
                                          const Icon(
                                            Icons.notification_add_outlined,
                                            color: Color(0xffff1f6f),
                                          )
                                        ),
                                      ),
                                    ],
                                  ),

                                  //Visit Store
                                  Expanded(
                                    child: Container(
                                      //alignment: Alignment.center,
                                      padding:
                                      const EdgeInsets.only(

                                          top: 10,
                                          bottom: 10),
                                      decoration: BoxDecoration(
                                          color: const Color(
                                              0xffff1f6f),
                                          borderRadius:
                                          BorderRadius
                                              .circular(10)),

                                      child: Center(
                                        child: Row(

                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children:  [
                                            Text(
                                              "Visit ${widget.name}'s site",
                                              style: const TextStyle(
                                                  color:
                                                  Colors.white,
                                                  fontFamily:
                                                  ""),
                                            ),

                                            const SizedBox(width: 10,),

                                            const Icon(
                                              Icons.arrow_forward,
                                              color: Colors.white,
                                              size: 18,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            //About Row
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                    isScrollControlled: true,
                                    shape:
                                    const RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.only(
                                            topLeft: Radius
                                                .circular(
                                                20),
                                            topRight: Radius
                                                .circular(
                                                20))),
                                    context: context,
                                    builder:
                                        (BuildContext context) {
                                      return aboutstoreCon(context);
                                    });
                              },
                              child: Container(
                                  margin: const EdgeInsets.only(
                                      right: 0, left: 0, top: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                      const BorderRadius.only(
                                          bottomRight:
                                          Radius.circular(
                                              10),
                                          bottomLeft:
                                          Radius.circular(
                                              10)),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black
                                                .withOpacity(0.2),
                                            blurRadius: 1.5,
                                            offset:
                                            const Offset(0, 0))
                                      ]),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      Container(
                                          padding:
                                          const EdgeInsets
                                              .only(
                                              left: 15,
                                              right: 15,
                                              top: 10,
                                              bottom: 10),
                                          child: Row(
                                            //mainAxisAlignment: MainAxisAlignment.center,
                                            children:  [
                                              const Icon(
                                                Icons
                                                    .info_outline,
                                                size: 20,
                                                color: Color(
                                                    0xff606060),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                "More about ${widget.name}",
                                                style: const TextStyle(
                                                    fontFamily:
                                                    "",
                                                    fontSize:
                                                    14,
                                                    color: Color(
                                                        0xff606060)),
                                              ),
                                            ],
                                          ))

                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),



                      Container(
                        height: MediaQuery.of(context).size.height * 0.7,
                        margin: const EdgeInsets.only(top: 10),
                        child: DefaultTabController(
                            length: 3,
                            initialIndex: 0,
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border(bottom: BorderSide(color: Colors.black.withOpacity(0.1),width: 1))
                                  ),
                                  child: TabBar(

                                    labelColor: selected,
                                    unselectedLabelColor: unselected,
                                    unselectedLabelStyle:
                                    const TextStyle(fontSize: 12),
                                    indicatorColor: selected,
                                    indicatorPadding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                    indicatorWeight: 2,
                                    //indicatorPadding: EdgeInsets.only(left: 15,right: 15),
                                    labelPadding: const EdgeInsets.only(
                                        bottom: 10, top: 10),
                                    labelStyle: const TextStyle(
                                        fontFamily: 'Helvetica_Bold',
                                        fontSize: 12),
                                    tabs: <Widget>[
                                      Container(
                                          alignment: Alignment.bottomCenter,
                                          //padding: EdgeInsets.only(top: 20,left: 20,right:20),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [

                                              const Icon(Icons.grid_on_outlined,size: 22,),

                                              // SizedBox(width: 5,),
                                              // const Text(
                                              //     "Overview "),
                                            ],
                                          )),
                                      Container(
                                          alignment: Alignment.bottomCenter,
                                          // padding: EdgeInsets.only(top: 20,left: 20,right:20),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [

                                              const Icon(Icons.reviews_outlined,size: 21,),

                                              // SizedBox(width: 5,),
                                              // const Text(
                                              //   "Reviews",
                                              // ),
                                            ],
                                          )),
                                      Container(
                                          alignment: Alignment.bottomCenter,
                                          //padding: EdgeInsets.only(top: 20,left: 20,right:20),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [

                                              const Icon(Icons.person_pin_outlined,size: 22,),

                                              // SizedBox(width: 5,),
                                              // const Text("More"),
                                            ],
                                          )),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: TabBarView(
                                    physics: const BouncingScrollPhysics(),
                                    children: [
                                      overviewTab(context),
                                      reviewsTab(context),
                                      moreTab(context)
                                    ],
                                  ),
                                )
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              // Container(
              //
              //   height: MediaQuery.of(context).size.height * 0.16,
              //   decoration: const BoxDecoration(
              //       borderRadius: BorderRadius.only(
              //           bottomRight: Radius.circular(30),
              //           bottomLeft: Radius.circular(30)),
              //       image: DecorationImage(
              //           image: AssetImage(
              //               "assets/images/crowd-people-are-gathered-club-with-pink-purple-light.jpg"),
              //           alignment: Alignment.topCenter,
              //           fit: BoxFit.cover)),
              //   padding: const EdgeInsets.only(
              //       top: 30, bottom: 30, left: 20, right: 20),
              // ),
              // Positioned(
              //   bottom: 0,
              //   left: 0,
              //   right: 0,
              //   top: 0,
              //   child: Container(
              //     height: MediaQuery.of(context).size.height,
              //     child: SingleChildScrollView(
              //       padding: EdgeInsets.only(top: 0,bottom: 15),
              //       physics: const NeverScrollableScrollPhysics(),
              //       child: Column(
              //         children: [
              //           //Top Details Container
              //           Container(
              //             margin: const EdgeInsets.only(
              //                 top: 0, bottom: 0, left: 0, right: 0),
              //             width: MediaQuery.of(context).size.width,
              //             //height: MediaQuery.of(context).size.height*0.2,
              //
              //             //height: topContHeight? null : 0,
              //             padding: const EdgeInsets.only(
              //                 left: 0, right: 0, top: 10, bottom: 0),
              //             decoration: BoxDecoration(
              //                 color: Colors.white,
              //                 borderRadius: BorderRadius.circular(10),
              //                 boxShadow: [
              //                   BoxShadow(
              //                       color: Colors.black
              //                           .withOpacity(0.15),
              //                       offset: const Offset(0, 0),
              //                       blurRadius: 10)
              //                 ]),
              //             child: Column(
              //               children: [
              //                 //Image & Title Row
              //                 Padding(
              //                   padding: const EdgeInsets.only(
              //                       left: 15, right: 15),
              //                   child: Row(
              //                     children: [
              //                       Container(
              //                         margin: const EdgeInsets.only(
              //                             right: 10),
              //                         height: 75,
              //                         width: 75,
              //                         decoration: BoxDecoration(
              //                             borderRadius:
              //                             BorderRadius.circular(
              //                                 10),
              //                             // image: DecorationImage(
              //                             //     image: NetworkImage(
              //                             //         "https://www.findbestvouchers.com/assets/uploads/required/placeholder.png"),
              //                             //     fit: BoxFit.contain),
              //                             color: Colors.white,
              //                             boxShadow: [
              //                               BoxShadow(
              //                                   color: Colors.black
              //                                       .withOpacity(0.2),
              //                                   blurRadius: 5,
              //                                   offset: const Offset(
              //                                       0, 0))
              //                             ]),
              //                         child: ClipRRect(
              //                           borderRadius: BorderRadius.circular(100),
              //                           child: CachedNetworkImage(
              //                             imageUrl: widget.image,
              //                             cacheManager: cacheManager,
              //                             fit: BoxFit.cover,
              //                             placeholder: (context, url) => const Center(
              //                               child: CircularProgressIndicator(
              //                                 color: Color(0xffff1f6f),
              //                                 value: 5,
              //                               ),
              //                             ),
              //                             errorWidget: (context, url, error) => const Icon(Icons.error, color: Color(0xffff1f6f)),
              //                           ),
              //                         ),
              //                       ),
              //                       Expanded(
              //                         child: Column(
              //                           crossAxisAlignment:
              //                           CrossAxisAlignment.start,
              //                           children: [
              //                             //Title
              //                              Row(
              //                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                                crossAxisAlignment: CrossAxisAlignment.end,
              //                                children: [
              //                                  Row(
              //                                    children: [
              //                                      Padding(
              //                                        padding: const EdgeInsets.symmetric(horizontal: 2),
              //                                        child: Text(
              //                                           widget.name,
              //                                           maxLines: 2,
              //                                           overflow:
              //                                           TextOverflow
              //                                               .ellipsis,
              //                                           style: TextStyle(
              //                                               fontFamily:
              //                                               "Helvetica_Bold",
              //                                               fontSize: 17)),
              //                                      ),
              //
              //
              //                                      Container(
              //                                        margin: EdgeInsets.only(left: 5),
              //                                          decoration: BoxDecoration(
              //                                              //color: Colors.white,
              //                                              borderRadius: BorderRadius.circular(10),
              //
              //                                          ),
              //                                          child: const Icon(Icons.verified,size: 20,color: Color(0xffffc107),)),
              //                                    ],
              //                                  ),
              //
              //                                  //Following
              //                                  Container(
              //                                    padding: EdgeInsets.only(top: 5 , bottom: 5,left: 10,right: 10),
              //                                    alignment: Alignment.center,
              //                                    decoration: BoxDecoration(
              //                                      color: Colors.white,
              //                                      borderRadius: BorderRadius.circular(20),
              //                                      border: Border.all(color: Colors.black.withOpacity(0.5),width: 0.5)
              //                                    ),
              //                                    child: Text("Following",
              //                                    style: TextStyle(color: Colors.black.withOpacity(0.8),fontWeight: FontWeight.bold,
              //                                    fontSize: 12),),
              //                                  )
              //                                ],
              //                              ),
              //
              //
              //                             const SizedBox(
              //                               height: 10,
              //                             ),
              //
              //                             //Location / Joining Row
              //                             Row(
              //                               mainAxisAlignment:
              //                               MainAxisAlignment
              //                                   .start,
              //                               children: [
              //                                 Row(
              //                                   children: [
              //                                     Icon(Icons.location_on_outlined,color: Colors.black.withOpacity(0.6),size: 15),
              //                                     const SizedBox(width: 2,),
              //                                     Text("Cupertino, CA",
              //                                     style: TextStyle(color: Colors.black.withOpacity(0.6),fontSize: 12),),
              //                                   ],
              //                                 ),
              //
              //                                 const SizedBox(width: 5,),
              //
              //                                 Row(
              //                                   children: [
              //                                     Icon(Icons.calendar_month_outlined,color: Colors.black.withOpacity(0.6),size: 15,),
              //                                     const SizedBox(width: 2,),
              //                                     Text("Joined in 2020",
              //                                       maxLines: 1,overflow: TextOverflow.ellipsis,
              //                                       style: TextStyle(color: Colors.black.withOpacity(0.6),fontSize: 12),),
              //                                   ],
              //                                 )
              //                               ],
              //                             ),
              //
              //                             const SizedBox(
              //                               height: 10,
              //                             ),
              //
              //                             //Following / Followers Row
              //                             Padding(
              //                               padding: const EdgeInsets.symmetric(horizontal: 3),
              //                               child: Row(
              //                                 mainAxisAlignment:
              //                                 MainAxisAlignment
              //                                     .start,
              //                                 children: [
              //                                   Row(
              //                                     children: [
              //                                       Text("0 ",
              //                                         style: TextStyle(color: Colors.black.withOpacity(0.8),fontWeight: FontWeight.bold,fontSize: 12),),
              //
              //                                       Text("Following",
              //                                         style: TextStyle(color: Colors.black.withOpacity(0.6),fontSize: 12),),
              //                                     ],
              //                                   ),
              //
              //                                   const SizedBox(width: 10,),
              //
              //                                   Row(
              //                                     children: [
              //                                       Text("9.1M ",
              //                                         style: TextStyle(color: Colors.black.withOpacity(0.8),fontWeight: FontWeight.bold,fontSize: 12),),
              //
              //                                       Text("Followers",
              //                                         style: TextStyle(color: Colors.black.withOpacity(0.6),fontSize: 12),),
              //                                     ],
              //                                   ),
              //                                 ],
              //                               ),
              //                             ),
              //                           ],
              //                         ),
              //                       )
              //                     ],
              //                   ),
              //                 ),
              //
              //                 const SizedBox(
              //                   height: 20,
              //                 ),
              //
              //                 //Fav Store & Visit Store Row
              //                 Padding(
              //                   padding: const EdgeInsets.only(
              //                       left: 15, right: 15),
              //                   child: Row(
              //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                     children: [
              //                       //Fav Container
              //                       GestureDetector(
              //                         onTap: ()
              //                         {
              //                           Share.share("123");
              //                         },
              //                         child: Container(
              //                           margin: const EdgeInsets.only(
              //                               left: 10, right: 20),
              //                           alignment: Alignment.center,
              //                           padding:
              //                           const EdgeInsets.all(6),
              //                           decoration: BoxDecoration(
              //                               color: Colors.white,
              //                               borderRadius:
              //                               BorderRadius.circular(
              //                                   10),
              //                               boxShadow: [
              //                                 BoxShadow(
              //                                     color: Colors.black
              //                                         .withOpacity(0.2),
              //                                     blurRadius: 1.5,
              //                                     offset: const Offset(
              //                                         0, 0))
              //                               ]),
              //                           child: const Icon(
              //                             Icons.share_outlined,
              //                             color: Color(0xffff1f6f),
              //                           ),
              //                         ),
              //                       ),
              //
              //                       //Visit Store
              //                       Expanded(
              //                         child: Container(
              //                           //alignment: Alignment.center,
              //                           padding:
              //                           const EdgeInsets.only(
              //
              //                               top: 10,
              //                               bottom: 10),
              //                           decoration: BoxDecoration(
              //                               color: const Color(
              //                                   0xffff1f6f),
              //                               borderRadius:
              //                               BorderRadius
              //                                   .circular(10)),
              //
              //                           child: Center(
              //                             child: Row(
              //
              //                               mainAxisAlignment: MainAxisAlignment.center,
              //                               children:  [
              //                                 Text(
              //                                   "Visit ${widget.name}'s site",
              //                                   style: TextStyle(
              //                                       color:
              //                                       Colors.white,
              //                                       fontFamily:
              //                                       ""),
              //                                 ),
              //
              //                                 const SizedBox(width: 10,),
              //
              //                                 Icon(
              //                                   Icons.arrow_forward,
              //                                   color: Colors.white,
              //                                   size: 18,
              //                                 )
              //                               ],
              //                             ),
              //                           ),
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //
              //                 //About Row
              //                 GestureDetector(
              //                   onTap: () {
              //                     showModalBottomSheet(
              //                         isScrollControlled: true,
              //                         shape:
              //                         const RoundedRectangleBorder(
              //                             borderRadius:
              //                             BorderRadius.only(
              //                                 topLeft: Radius
              //                                     .circular(
              //                                     30),
              //                                 topRight: Radius
              //                                     .circular(
              //                                     30))),
              //                         context: context,
              //                         builder:
              //                             (BuildContext context) {
              //                           return aboutstoreCon(context);
              //                         });
              //                   },
              //                   child: Container(
              //                       margin: const EdgeInsets.only(
              //                           right: 0, left: 0, top: 10),
              //                       decoration: BoxDecoration(
              //                           color: Colors.white,
              //                           borderRadius:
              //                           const BorderRadius.only(
              //                               bottomRight:
              //                               Radius.circular(
              //                                   10),
              //                               bottomLeft:
              //                               Radius.circular(
              //                                   10)),
              //                           boxShadow: [
              //                             BoxShadow(
              //                                 color: Colors.black
              //                                     .withOpacity(0.2),
              //                                 blurRadius: 1.5,
              //                                 offset:
              //                                 const Offset(0, 0))
              //                           ]),
              //                       child: Row(
              //                         mainAxisAlignment:
              //                         MainAxisAlignment.center,
              //                         children: [
              //                           Container(
              //                               padding:
              //                               const EdgeInsets
              //                                   .only(
              //                                   left: 15,
              //                                   right: 15,
              //                                   top: 10,
              //                                   bottom: 10),
              //                               child: Row(
              //                                 //mainAxisAlignment: MainAxisAlignment.center,
              //                                 children:  [
              //                                   Icon(
              //                                     Icons
              //                                         .info_outline,
              //                                     size: 20,
              //                                     color: Color(
              //                                         0xff606060),
              //                                   ),
              //                                   SizedBox(
              //                                     width: 5,
              //                                   ),
              //                                   Text(
              //                                     "More about ${widget.name}",
              //                                     style: TextStyle(
              //                                         fontFamily:
              //                                         "",
              //                                         fontSize:
              //                                         14,
              //                                         color: Color(
              //                                             0xff606060)),
              //                                   ),
              //                                 ],
              //                               ))
              //
              //                         ],
              //                       )),
              //                 ),
              //               ],
              //             ),
              //           ),
              //
              //
              //
              //           Container(
              //             height: MediaQuery.of(context).size.height * 0.7,
              //             margin: const EdgeInsets.only(top: 10),
              //             child: DefaultTabController(
              //                 length: 3,
              //                 initialIndex: 0,
              //                 child: Column(
              //                   children: [
              //                     Container(
              //                       decoration: BoxDecoration(
              //                           border: Border(bottom: BorderSide(color: Colors.black.withOpacity(0.1),width: 1))
              //                       ),
              //                       child: TabBar(
              //
              //                         labelColor: selected,
              //                         unselectedLabelColor: unselected,
              //                         unselectedLabelStyle:
              //                         const TextStyle(fontSize: 14),
              //                         indicatorColor: selected,
              //                         indicatorPadding:
              //                         const EdgeInsets.only(left: 20, right: 20),
              //                         indicatorWeight: 2,
              //                         //indicatorPadding: EdgeInsets.only(left: 15,right: 15),
              //                         labelPadding: const EdgeInsets.only(
              //                             bottom: 10, top: 10),
              //                         labelStyle: const TextStyle(
              //                             fontFamily: 'Helvetica_Bold',
              //                             fontSize: 15),
              //                         tabs: <Widget>[
              //                           Container(
              //                               alignment: Alignment.bottomCenter,
              //                               //padding: EdgeInsets.only(top: 20,left: 20,right:20),
              //                               child: const Text(
              //                                   "Overview ")),
              //                           Container(
              //                               alignment: Alignment.bottomCenter,
              //                               // padding: EdgeInsets.only(top: 20,left: 20,right:20),
              //                               child: const Text(
              //                                 "Reviews",
              //                               )),
              //                           Container(
              //                               alignment: Alignment.bottomCenter,
              //                               //padding: EdgeInsets.only(top: 20,left: 20,right:20),
              //                               child: const Text("More")),
              //                         ],
              //                       ),
              //                     ),
              //                     Expanded(
              //                       child: TabBarView(
              //                         physics: const BouncingScrollPhysics(),
              //                         children: [
              //                           overviewTab(context),
              //                           reviewsTab(context),
              //                           moreTab(context)
              //                         ],
              //                       ),
              //                     )
              //                   ],
              //                 )),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),

              progress ? const Positioned(
                top: 0,bottom: 0,left: 0,right: 0,
                child: Center(child: CircularProgressIndicator(strokeWidth: 3,color: Color(0xffff1f6f),),),
              ) : const SizedBox(),
            ]),
          ),
        ),
      ),
    );
  }

  Widget overviewTab(BuildContext context)
  {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      //height: MediaQuery.of(context).size.height * 0.85,
      child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: kToolbarHeight+15),
          physics: const BouncingScrollPhysics(),
          //controller: reviewTabController,
          scrollDirection: Axis.vertical,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [



                Headings(context, "Upcoming Events"),

                //Upcoming Slider
                todaySlider(context),


                Headings(context, "Past Events"),

                todaySlider(context),

                Headings(context, "Cancelled Events"),

                openAirSlider(context),


              ]
          )
      ),
    );

  }
  
  Widget reviewsTab(BuildContext context)
  {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      //height: MediaQuery.of(context).size.height * 0.85,
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: kToolbarHeight+15),
        physics: const BouncingScrollPhysics(),
        controller: reviewTabController,
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            //Total Ratings Con
            Column(
              children: [
                Headings(context, "All Reviews"),

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
              ],
            ),

            const SizedBox(
              height: 20,
            ),

            shadowLine(context),

            ListView.builder(
                shrinkWrap: true,
                //padding: EdgeInsets.only(top: 3,bottom: 3,left: 15,right: 15),
                itemCount: reviewTab,
                physics: const NeverScrollableScrollPhysics(),
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
                })
          ],
        ),
      ),
    );
  }

  Widget moreTab(BuildContext context)
  {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      //height: MediaQuery.of(context).size.height * 0.85,
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: kToolbarHeight+15),
        physics: const BouncingScrollPhysics(),
        //controller: reviewTabController,
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [


            AnimatedOpacity(
              opacity: 1.0,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn,
              child: Headings(context, "Discover More Organizers"),
            ),
            const SizedBox(height: 0),

            AnimatedOpacity(
              opacity: 1.0,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn,
              child: discoverOrgGrid(context),
            ),

            // Container(
            //   width: 200,height: 150,
            //   color: Colors.yellow,
            // )
          ],
        ),
      ),
    );
  }
  //

  // Widget allTab(BuildContext context)
  // {
  //   return Column(
  //     children: [
  //
  //       Headings(context, "Codes"),
  //
  //       Expanded(
  //         child: Container(
  //           height: MediaQuery.of(context).size.height,
  //           child: ListView.builder(
  //               shrinkWrap: false,
  //               padding: EdgeInsets.only(bottom: 0,top: 0),
  //               physics: NeverScrollableScrollPhysics(),
  //               itemCount: 4,
  //               itemBuilder: (context,index){
  //                 return voucherCon3(context, "Snuggy", "assets/images/Brand_Snuggy.png", "Flat 15% off on your first order for a limited time.");
  //               }),
  //         ),
  //       ),
  //
  //       Headings(context, "Deals"),
  //
  //       Expanded(child: dealsListVertical(context)),
  //     ],
  //   );
  // }

  // Widget dealsTab(BuildContext context)
  // {
  //   return Column(
  //     children: [
  //       Headings(context, "Deals"),
  //
  //       Expanded(child: dealsListVertical(context)),
  //     ],
  //   );
  // }
  //
  // Widget codesTab(BuildContext context)
  // {
  //   return Column(
  //     children: [
  //       Headings(context, "Codes"),
  //
  //       Expanded(
  //         child: Container(
  //           height: MediaQuery.of(context).size.height,
  //           child: ListView.builder(
  //               shrinkWrap: false,
  //               padding: EdgeInsets.only(bottom: 0,top: 0),
  //               physics: NeverScrollableScrollPhysics(),
  //               itemCount: 4,
  //               itemBuilder: (context,index){
  //                 return voucherCon3(context, "Snuggy", "assets/images/Brand_Snuggy.png", "Flat 15% off on your first order for a limited time.");
  //               }),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // Widget filterSubHeading(String keyname, Icon keyIcon, bool isLast,
  //     BuildContext context, bool Switch) {
  //   // bool _last = isLast;
  //   return StatefulBuilder(
  //     builder: (BuildContext context, StateSetter setState) {
  //       return Container(
  //         padding:
  //         const EdgeInsets.only(top: 15, bottom: 15, left: 15, right: 15),
  //         alignment: Alignment.centerLeft,
  //         decoration: BoxDecoration(
  //           //color: Colors.red,
  //           border: Border(
  //             bottom: BorderSide(
  //                 width: 0,
  //                 color: Colors.black.withOpacity(isLast ? 0.0 : 0.2)),
  //             // bottom: BorderSide(width: 0,color: Colors.black.withOpacity(0))
  //           ),
  //           //borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
  //           // color: Colors.white
  //         ),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           children: [
  //             Container(
  //                 margin: const EdgeInsets.only(right: 10),
  //                 padding: const EdgeInsets.all(0),
  //                 alignment: Alignment.center,
  //                 width: 30,
  //                 height: 30,
  //                 decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.circular(30),
  //                     color: const Color(0xFFf1f1f1)),
  //                 child: keyIcon),
  //
  //             Expanded(
  //                 child: Text(
  //                   keyname,
  //                   style:
  //                   const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
  //                 )),
  //
  //             //Spacer(),
  //
  //             CupertinoSwitch(
  //                 activeColor: const Color(0xff9933ff),
  //                 value: Switch,
  //                 onChanged: (bool newValue) {
  //                   setState(() {
  //                     Switch = newValue;
  //                   });
  //                 })
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
  //
  // Widget filterCon(BuildContext context) {
  //   return Scaffold(
  //     //key: scaffoldKey,
  //     backgroundColor: Colors.transparent,
  //     body: SafeArea(
  //       child: Column(
  //         children: [
  //           Container(
  //             padding: const EdgeInsets.only(right: 20, left: 5),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Headings(context, "Filter & Sort: "),
  //                 GestureDetector(
  //                   onTap: () {
  //                     Navigator.pop(context);
  //                   },
  //                   child: Container(
  //                       padding: const EdgeInsets.all(2),
  //                       decoration: BoxDecoration(
  //                           color: const Color(0xffdcdcdc),
  //                           borderRadius: BorderRadius.circular(100)),
  //                       child: const Icon(Icons.close)),
  //                 )
  //               ],
  //             ),
  //           ),
  //           filterSubHeading(
  //               "Verified by FindBestVouchers",
  //               const Icon(
  //                 Icons.verified,
  //                 color: Colors.green,
  //               ),
  //               false,
  //               context,
  //               verifiedFBV),
  //           filterSubHeading(
  //               "All Offers",
  //               const Icon(
  //                 Icons.local_offer_outlined,
  //                 color: Colors.orange,
  //               ),
  //               false,
  //               context,
  //               alloffers),
  //           filterSubHeading(
  //               "Codes",
  //               const Icon(
  //                 Icons.code_outlined,
  //                 color: Color(0xff9933ff),
  //               ),
  //               false,
  //               context,
  //               codes),
  //           filterSubHeading(
  //               "Deals",
  //               const Icon(
  //                 Icons.handshake_outlined,
  //                 color: Color(0xff9933ff),
  //               ),
  //               true,
  //               context,
  //               deals),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  //
  Widget aboutstoreCon(BuildContext context) {
    return SafeArea(
      child: Container(
        //margin: EdgeInsets.only(top: 20),
        padding: const EdgeInsets.only(top: 10, bottom: 50),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(right: 10, left: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Container(
                      padding: const EdgeInsets.only(top: 20,bottom: 20 , left:15 , right:15),
                      child: const Text("About",overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          maxLines: 2,
                          style:
                          TextStyle(color: Colors.black87,fontFamily: 'Fira-SemiBold',fontWeight: FontWeight.bold, fontSize: 18)),
                    ),
                    //
                    // GestureDetector(
                    //   onTap: () {
                    //     Navigator.pop(context);
                    //   },
                    //   child: Container(
                    //       padding: const EdgeInsets.all(2),
                    //       decoration: BoxDecoration(
                    //           color: const Color(0xffdcdcdc),
                    //           borderRadius: BorderRadius.circular(100)),
                    //       child: const Icon(Icons.close)),
                    // )
                  ],
                ),
              ),
              // Padding(
              //     padding: const EdgeInsets.only(left: 15, right: 15),
              //     child: Html(
              //       data: "${storeData?.description}",
              //     ))
            ],
          ),
        ),
      ),
    );
  }
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
