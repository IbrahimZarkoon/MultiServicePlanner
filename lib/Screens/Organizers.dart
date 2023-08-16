import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialapp/CustomWidgets/CustomAppBar.dart';
import 'package:socialapp/CustomWidgets/Headings.dart';
import 'package:socialapp/CustomWidgets/OrgSlider.dart';
import 'package:socialapp/Screens/SingleOrganizer.dart';

import '../Providers/CacheManager.dart';
import 'MyProfile.dart';

class Organizers extends StatefulWidget {
  const Organizers({Key? key}) : super(key: key);

  @override
  State<Organizers> createState() => _OrganizersState();
}

class _OrganizersState extends State<Organizers> {

  final GlobalKey<ScaffoldState> _organizersScaffoldKey = GlobalKey<ScaffoldState>();



  double topStoreMarginLeft = 15;
  double topStoreMarginRight = 0;

  ScrollController topStoreController = ScrollController();

  _topStoreScrollListener() {
    if (topStoreController.offset >=
        topStoreController.position.maxScrollExtent &&
        topStoreMarginRight == 0) {
      setState(() {
        topStoreMarginRight = 15;
        topStoreMarginLeft = 0;
      });
    }

    if (topStoreController.offset <=
        topStoreController.position.minScrollExtent &&
        topStoreMarginLeft == 0) {
      setState(() {
        topStoreMarginRight = 0;
        topStoreMarginLeft = 15;
      });
    }
  }

  @override
  void dispose()
  {
    topStoreController.dispose();
    topStoreController.removeListener(_topStoreScrollListener);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    topStoreController.addListener(_topStoreScrollListener);

    final cacheManager = Provider.of<CacheManagerProvider>(context).cacheManager;

    return Scaffold(

      key: _organizersScaffoldKey,
      endDrawer: Drawer(
        elevation: 10,
        shadowColor: Colors.black.withOpacity(0.5),
        child: const MyProfile(),

      ),

      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(kToolbarHeight*2),
      //   child: CustomAppBar(),
      // ),

      body: RefreshIndicator(
        onRefresh: ()
        {
          return Future.delayed(const Duration(seconds: 2));
        },
        color: const Color(0xffff1f6f),
        backgroundColor: Colors.white,
        child: Container(
          height: MediaQuery.of(context).size.height*0.85,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              color: Colors.white
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 5),
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,

            child: Column(
              children: [

                //Featured Org
                Padding(
                  padding: const EdgeInsets.only(left: 5,right: 15),
                  child: Headings(context, "Featured Organizers"),
                ),

                //Featured Org Carousel
                Container(
                  padding: const EdgeInsets.only(top: 5),
                  child: CarouselSlider(
                      items: [
                        //1st Item
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            //color: Colors.red,
                              borderRadius: BorderRadius.circular(15)),
                          child: Stack(
                            children: [
                              Container(
                                foregroundDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                      Colors.transparent,
                                      Colors.black.withOpacity(0.65)
                                    ],
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(15),
                                    // image: const DecorationImage(
                                    //     image: NetworkImage(
                                    //         "https://images.pexels.com/photos/1350789/pexels-photo-1350789.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"),
                                    //     fit: BoxFit.fill)
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),

                                  child: CachedNetworkImage(
                                    imageUrl: "https://images.pexels.com/photos/1350789/pexels-photo-1350789.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                                    cacheManager: cacheManager,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator(
                                        color: Color(0xffff1f6f),
                                        value: 5,
                                      ),
                                    ),
                                    errorWidget: (context, url, error) => const Center(child: Icon(Icons.error,color: Color(0xffff1f6f),)),
                                  ),
                                ),
                              ),

                              Positioned(
                                  top: 15,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: const Text(
                                      "Upto 50% Off On Furniture",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )),

                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(14),
                                        bottomLeft: Radius.circular(14)),
                                    //color: Colors.white70,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        bottomRight: Radius.circular(14),
                                        bottomLeft: Radius.circular(14)),
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 5, sigmaY: 5),
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                            top: 20, bottom: 20),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          const BorderRadius.only(
                                              bottomRight:
                                              Radius.circular(14),
                                              bottomLeft:
                                              Radius.circular(
                                                  14)),
                                          color: Colors.black
                                              .withOpacity(0.4),
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: const [
                                            Text(
                                              "View profile",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight:
                                                FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Icon(
                                              Icons
                                                  .arrow_forward_ios_outlined,
                                              color: Colors.white,
                                              size: 18,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )

                              // Positioned(
                              //     bottom: 0,left: 0,right: 0,
                              //     child: Container(
                              //       padding: EdgeInsets.only(top: 20,bottom: 20),
                              //       decoration: BoxDecoration(
                              //         borderRadius: BorderRadius.circular(14),
                              //         color: Colors.white70
                              //
                              //       ),
                              //       child: Row(
                              //         crossAxisAlignment: CrossAxisAlignment.center,
                              //         mainAxisAlignment: MainAxisAlignment.center,
                              //         children: [
                              //           Text("See offers",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                              //
                              //           const SizedBox(width: 5,),
                              //
                              //           Icon(Icons.arrow_forward_ios_outlined,color: Colors.white,size: 18,)
                              //         ],
                              //       ),
                              //     ))
                            ],
                          ),
                        ),

                        //2nd Item
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            //color: Colors.red,
                              borderRadius: BorderRadius.circular(15)),
                          child: Stack(
                            children: [
                              Container(
                                foregroundDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                      Colors.transparent,
                                      Colors.black.withOpacity(0.65)
                                    ],
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(15),
                                    // image: const DecorationImage(
                                    //     image: NetworkImage(
                                    //         "https://www.rollingstone.com/wp-content/uploads/2020/02/best-4k-projector.jpg"),
                                    //     fit: BoxFit.fill)
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),

                                  child: CachedNetworkImage(
                                    imageUrl: "https://www.rollingstone.com/wp-content/uploads/2020/02/best-4k-projector.jpg",
                                    cacheManager: cacheManager,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator(
                                        color: Color(0xffff1f6f),
                                        value: 5,
                                      ),
                                    ),
                                    errorWidget: (context, url, error) => const Center(child: Icon(Icons.error,color: Color(0xffff1f6f),)),
                                  ),
                                ),
                              ),

                              Positioned(
                                  top: 15,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: const Text(
                                      "Upto 50% Off On Furniture",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )),

                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(14),
                                        bottomLeft: Radius.circular(14)),
                                    //color: Colors.white70,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        bottomRight: Radius.circular(14),
                                        bottomLeft: Radius.circular(14)),
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 5, sigmaY: 5),
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                            top: 20, bottom: 20),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          const BorderRadius.only(
                                              bottomRight:
                                              Radius.circular(14),
                                              bottomLeft:
                                              Radius.circular(
                                                  14)),
                                          color: Colors.black
                                              .withOpacity(0.4),
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: const [
                                            Text(
                                              "View profile",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight:
                                                FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Icon(
                                              Icons
                                                  .arrow_forward_ios_outlined,
                                              color: Colors.white,
                                              size: 18,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )

                              // Positioned(
                              //     bottom: 0,left: 0,right: 0,
                              //     child: Container(
                              //       padding: EdgeInsets.only(top: 20,bottom: 20),
                              //       decoration: BoxDecoration(
                              //         borderRadius: BorderRadius.circular(14),
                              //         color: Colors.white70
                              //
                              //       ),
                              //       child: Row(
                              //         crossAxisAlignment: CrossAxisAlignment.center,
                              //         mainAxisAlignment: MainAxisAlignment.center,
                              //         children: [
                              //           Text("See offers",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                              //
                              //           const SizedBox(width: 5,),
                              //
                              //           Icon(Icons.arrow_forward_ios_outlined,color: Colors.white,size: 18,)
                              //         ],
                              //       ),
                              //     ))
                            ],
                          ),
                        ),
                      ],
                      options: CarouselOptions(
                          height:
                          MediaQuery.of(context).size.height * 0.3,
                          aspectRatio: 0.9,
                          viewportFraction: 0.9,
                          enlargeCenterPage: true)),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20,bottom: 10,top: 25),
                  child: shadowLine(context),
                ),


                // Padding(
                //   padding: const EdgeInsets.only(left: 5,right: 15,),
                //   child: Headings(context, "Discover Organizers"),
                // ),
                //
                // OrgSlider(context),

                Padding(
                  padding: const EdgeInsets.only(left: 5,right: 15,top: 5),
                  child: Headings(context, "Popular Organizers"),
                ),

                //Popular Org Grid
                GridView.count(
                  padding: const EdgeInsets.only(left: 20,right: 0,top: 5,bottom: 5),
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1,

                  children: [
                    orgContainer(context, "Urvashi", "https://pbs.twimg.com/media/FY0CAnOXgAYINm3.jpg:large",false),
                    orgContainer(context, "Zarkoon", "https://scontent.fkhi10-1.fna.fbcdn.net/v/t39.30808-6/250257682_428425348641425_4991061791746409319_n.jpg?_nc_cat=106&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeHR1m_1X_chjQnazvIgyyPb9QIj0VOECw31AiPRU4QLDTPBam2yTUfaV8Pqh3YQ1UORvvKaQfS2gv0RLskRbOcA&_nc_ohc=Y1IBYzhTQXgAX8JlpVl&_nc_ht=scontent.fkhi10-1.fna&oh=00_AfB-lFBSa8CXuxPE40xXAQnyEfIN4iJEFMaihZXooTfsaQ&oe=64B6D181",true),
                    orgContainer(context, "Facebook", "https://www.edigitalagency.com.au/wp-content/uploads/Facebook-logo-blue-circle-large-transparent-png.png",true),
                    orgContainer(context, "Instagram", "https://img.freepik.com/premium-vector/purple-gradiend-social-media-logo_197792-1883.jpg?w=2000",false),
                    orgContainer(context, "Twitter", "https://www.fabelia.com/wp-content/uploads/2021/03/pick-up.jpg",true),
                    orgContainer(context, "Urvashi", "https://pbs.twimg.com/media/FY0CAnOXgAYINm3.jpg:large",false),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20,bottom: 10),
                  child: shadowLine(context),
                ),



                Padding(
                  padding: const EdgeInsets.only(left: 5,right: 15),
                  child: Headings(context, "Recommended Organizers"),
                ),

                //Recommended Org Grid
                GridView.count(
                  padding: const EdgeInsets.only(left: 20,right: 0,top: 5,bottom: 5),
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 0,
                  childAspectRatio: 1.1,

                  children: [
                    orgContainer(context, "Urvashi", "https://pbs.twimg.com/media/FY0CAnOXgAYINm3.jpg:large",true),
                    orgContainer(context, "Zarkoon", "https://scontent.fkhi10-1.fna.fbcdn.net/v/t39.30808-6/250257682_428425348641425_4991061791746409319_n.jpg?_nc_cat=106&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeHR1m_1X_chjQnazvIgyyPb9QIj0VOECw31AiPRU4QLDTPBam2yTUfaV8Pqh3YQ1UORvvKaQfS2gv0RLskRbOcA&_nc_ohc=Y1IBYzhTQXgAX8JlpVl&_nc_ht=scontent.fkhi10-1.fna&oh=00_AfB-lFBSa8CXuxPE40xXAQnyEfIN4iJEFMaihZXooTfsaQ&oe=64B6D181",false),
                    orgContainer(context, "Facebook", "https://www.edigitalagency.com.au/wp-content/uploads/Facebook-logo-blue-circle-large-transparent-png.png",false),
                    orgContainer(context, "Instagram", "https://img.freepik.com/premium-vector/purple-gradiend-social-media-logo_197792-1883.jpg?w=2000",false),
                    orgContainer(context, "Twitter", "https://www.fabelia.com/wp-content/uploads/2021/03/pick-up.jpg",false),
                    orgContainer(context, "Urvashi", "https://pbs.twimg.com/media/FY0CAnOXgAYINm3.jpg:large",true),
                    orgContainer(context, "Urvashi", "https://pbs.twimg.com/media/FY0CAnOXgAYINm3.jpg:large",false),
                    orgContainer(context, "Zarkoon", "https://scontent.fkhi10-1.fna.fbcdn.net/v/t39.30808-6/250257682_428425348641425_4991061791746409319_n.jpg?_nc_cat=106&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeHR1m_1X_chjQnazvIgyyPb9QIj0VOECw31AiPRU4QLDTPBam2yTUfaV8Pqh3YQ1UORvvKaQfS2gv0RLskRbOcA&_nc_ohc=Y1IBYzhTQXgAX8JlpVl&_nc_ht=scontent.fkhi10-1.fna&oh=00_AfB-lFBSa8CXuxPE40xXAQnyEfIN4iJEFMaihZXooTfsaQ&oe=64B6D181",false),
                    orgContainer(context, "Facebook", "https://www.edigitalagency.com.au/wp-content/uploads/Facebook-logo-blue-circle-large-transparent-png.png",false),
                    orgContainer(context, "Instagram", "https://img.freepik.com/premium-vector/purple-gradiend-social-media-logo_197792-1883.jpg?w=2000",false),
                    orgContainer(context, "Twitter", "https://www.fabelia.com/wp-content/uploads/2021/03/pick-up.jpg",true),
                    orgContainer(context, "Urvashi", "https://pbs.twimg.com/media/FY0CAnOXgAYINm3.jpg:large",true),
                  ],
                ),


              ],
            ),
          ),
        ),
      ),

      /// body: SingleChildScrollView(
      //     padding: const EdgeInsets.only(top: 0,bottom: 15),
      //     physics: const BouncingScrollPhysics(),
      //     scrollDirection: Axis.vertical,
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.start,
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //
      //       children: [
      //
      //         Headings(context, "Featured Organizers"),
      //
      //         featuredOrg(context),
      //
      //         Headings(context, "Discover Organizers"),
      //
      //         OrgSlider(context),
      //
      //         // Headings(context, "Popular Organizers"),
      //         //
      //         // OrgGrid(context),
      //
      //
      //
      //       ],
      //     )),
    );
  }

  Widget orgContainer(BuildContext context,String title, String image,bool verified)
  {
    final cacheManager = Provider.of<CacheManagerProvider>(context).cacheManager;

    return GestureDetector(
      onTap: ()
      {
        Navigator.push(context, CupertinoPageRoute(builder: (BuildContext context) => SingleOrganizer(image: image,name: title,)));
      },
      child: Stack(
        children:[
        Container(
          constraints: const BoxConstraints(
            //minWidth: 130
          ),
          //color: Colors.blue,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 1.5,
                          offset: const Offset(0, 0)),
                    ],
                    image: DecorationImage(
                        image: NetworkImage(image), fit: BoxFit.cover)
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CachedNetworkImage(
                    imageUrl: image,
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
              const SizedBox(
                height: 5,
              ),
              Text(
                title,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                maxLines: 2,
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),

          Positioned(
              right: 40,
              bottom: 40,
              child:verified? Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: const Icon(Icons.verified,size: 20,color: Color(0xffff1f6f),)) : const SizedBox()
          )
      ]
      ),
    );
  }

  Widget featuredOrg(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
          color: const Color(0xffff1f6f),
          borderRadius: BorderRadius.circular(5)),
      //padding: const EdgeInsets.only(top: 10,bottom: 10),
      margin:
      EdgeInsets.only(left: topStoreMarginLeft, right: topStoreMarginRight),
      constraints: BoxConstraints(
        minHeight: 120,
        minWidth: MediaQuery.of(context).size.width,
        maxHeight: 140
      ),
      child: ListView.builder(
        controller: topStoreController,
        primary: false,
        padding: const EdgeInsets.only(top: 0, bottom: 0),
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (BuildContext context, index) {
          return orgCon(
              context,
              "Facebook",
              "https://www.fabelia.com/wp-content/uploads/2021/03/pick-up.jpg",
              "Recommended");
        },
      ),
    );
  }

  Widget orgCon(BuildContext context, String storeName, String storeImage,String status)
  {
    String? _SN = storeName;
    String? _SI = storeImage;
    String? _SS = status;

    final cacheManager = Provider.of<CacheManagerProvider>(context).cacheManager;


    return GestureDetector(
      onTap: ()
      {
        //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) { return SingleStore(SID: _SID,tag: _SID,); }));
      },
      child: Container(
        margin: const EdgeInsets.only(left: 5),
        //padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          //color: Colors.blue,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            //Image Con
            Container(
              padding: const EdgeInsets.all(10),
              constraints: const BoxConstraints(
                maxWidth: 100,
                maxHeight: 100,
                minWidth: 100,
                minHeight: 100,
              ),
              decoration: BoxDecoration(
                color: const Color(0xfff9f9f9),
                borderRadius: BorderRadius.circular(5),

              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CachedNetworkImage(
                  imageUrl: storeImage,
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

            const SizedBox(height: 7),

            //Text Con
            Container(
              width: 110,
              child: Text(
                storeName,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                softWrap: false,
                style: const TextStyle(fontFamily: "Fira-Regular", fontSize: 12, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
