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

class Services extends StatefulWidget {
  const Services({Key? key}) : super(key: key);

  @override
  State<Services> createState() => _ServicesState();
}

class _ServicesState extends State<Services> {

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
        color: const Color(0xff09426d),
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
                  padding: const EdgeInsets.only(left: 5,right: 5,top: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Headings(context, "FEATURED"),
                    ],
                  ),
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
                                    imageUrl: "https://img.freepik.com/free-photo/handsome-african-guy-with-stylish-haircut-taking-photo-digital-camera_171337-1345.jpg?w=2000&t=st=1694217855~exp=1694218455~hmac=284011734ce2c9f335e4295039fb3d9957163bdec4784ae193076a83754348c4",
                                    cacheManager: cacheManager,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator(
                                        color: Color(0xff09426d),
                                        value: 5,
                                      ),
                                    ),
                                    errorWidget: (context, url, error) => const Center(child: Icon(Icons.error,color: Color(0xff09426d),)),
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
                                      "Upto 25% Off on Photosessions",
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
                                    imageUrl: "https://img.freepik.com/free-photo/close-up-people-serving-themselves-fruits-buffet-restaurant_8353-9872.jpg?w=2000&t=st=1694217942~exp=1694218542~hmac=49e921666343ec613fd80caff8b21ab41c835147528b985753d4c146e7df1925",
                                    cacheManager: cacheManager,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator(
                                        color: Color(0xff09426d),
                                        value: 5,
                                      ),
                                    ),
                                    errorWidget: (context, url, error) => const Center(child: Icon(Icons.error,color: Color(0xff09426d),)),
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
                                      "Upto 30% Off on Catering",
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

                //Photographers
                Padding(
                  padding: const EdgeInsets.only(left: 5,right: 5,top: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Headings(context, "Photographers"),
                    ],
                  ),
                ),

                //Popular Org Grid
                GridView.count(
                  padding: const EdgeInsets.only(left: 15,right: 15,top: 5,bottom: 5),

                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.85,

                  children: [
                    orgContainer(context, "PixelPerfect Moments", "https://img.freepik.com/free-photo/people-working-together-new-movie_23-2149066321.jpg?w=2000&t=st=1694219857~exp=1694220457~hmac=af7b18895070ba727c2600f473252abe1bed9c514d2d9d53ce52cdc150656561",true),
                    orgContainer(context, "LensCrafted Photography", "https://img.freepik.com/free-photo/people-working-together-new-film_23-2149066343.jpg?w=2000&t=st=1694219850~exp=1694220450~hmac=fdbfd1e6651231c7add8e2b84f875b8ad90133ac2af6792416cb9b7172482d84",false),
                    orgContainer(context, "ShutterMagic Studios", "https://img.freepik.com/free-photo/meeting-with-other-photographers-office_329181-12371.jpg?w=2000&t=st=1694219851~exp=1694220451~hmac=0d0c3d4540b3698c8a1d832517fdf0ba9f3771de736570ab1ca22c38f396c916",true),
                    orgContainer(context, "FocusEra Photography", "https://img.freepik.com/free-photo/woman-man-looking-camera-photos_23-2148532473.jpg?w=2000&t=st=1694219852~exp=1694220452~hmac=1700f48a97efcefba80a4cbda5dd68dc8482d0a339ad11bcb907a69fe92e51d9",true),
                    orgContainer(context, "SnapVista Creations", "https://img.freepik.com/free-photo/man-filming-with-professional-camera_23-2149066342.jpg?w=2000&t=st=1694219854~exp=1694220454~hmac=035045ebd35cfb6ef2f6b97992e6ab9a57417b4ed7f64facff02a10a2616a113",false),

                  ],
                ),

                //shadow line
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20,bottom: 10),
                  child: shadowLine(context),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 5,right: 5,top: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Headings(context, "Decorators"),
                    ],
                  ),
                ),

                //Popular Org Grid
                GridView.count(
                  padding: const EdgeInsets.only(left: 15,right: 15,top: 5,bottom: 5),

                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.85,


                  children: [
                    orgContainer(context, "DecorWonders Events", "https://img.freepik.com/free-photo/stylish-young-coworkers-with-laptop_23-2147668842.jpg?w=2000&t=st=1694219958~exp=1694220558~hmac=3e33e17e65c0bcd17739135a39f91a5fa459352f23d6016b19d3c50148ff6826",false),
                    orgContainer(context, "EnchantingSpaces Decor", "https://img.freepik.com/free-photo/teammates-working-together_1098-342.jpg?w=2000&t=st=1694219959~exp=1694220559~hmac=285c9ea3ea9e020667ec25884d5f2b577476a19b63555218dfa7171431256ae0",true),
                    orgContainer(context, "EleganceMasters Design", "https://img.freepik.com/free-photo/business-partners-hold-discussions-men-business-suits-are-talking-man-suspenders-with-beard_1157-43484.jpg?w=2000&t=st=1694219962~exp=1694220562~hmac=77961e2c92eb04e9d5e34513a907d2534efd61803fdb59d9b3c246fd214dc96a",true),
                    orgContainer(context, "BlissfulTouches Decor", "https://img.freepik.com/free-photo/smiling-smart-woman-designer-demonstrating-unrolled-paper_23-2148180680.jpg?w=2000&t=st=1694219966~exp=1694220566~hmac=f2f603051eb501524ba4520ef0d1fbe3953dcb6aa3c4c85b6bd5430e25d40258",false),
                    orgContainer(context, "DreamScape Styling", "https://img.freepik.com/free-photo/young-people-watching-laptop_23-2147668843.jpg?w=2000&t=st=1694219967~exp=1694220567~hmac=b42dd230f908c307744a3543f835d1767ce0082d470c4e59755812d964cd2b1f",true),
                    orgContainer(context, "Opulent Occasions Decor", "https://img.freepik.com/free-photo/content-friends-clinking-with-glasses_23-2147668936.jpg?w=2000&t=st=1694219969~exp=1694220569~hmac=8de1dbd034515fb9ad47953414021a072fa5ce46b9ded0dfa92b7ded228f690f",false),
                  ],
                ),

                //shadow line
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20,bottom: 10),
                  child: shadowLine(context),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 5,right: 5,top: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Headings(context, "Caterers"),
                    ],
                  ),
                ),

                //Popular Org Grid
                GridView.count(
                  padding: const EdgeInsets.only(left: 15,right: 15,top: 5,bottom: 5),
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.85,


                  children: [
                    orgContainer(context, "Gourmet Delights Catering", "https://img.freepik.com/free-photo/happy-young-waiter-holding-glass-champagne-towel_171337-5290.jpg?w=2000&t=st=1694219751~exp=1694220351~hmac=657837dd691241a6effb2c82a3870ce1b2f0ca4925d6c54deb577c25eb975670",false),
                    orgContainer(context, "Culinary Creations Caterers", "https://img.freepik.com/free-photo/young-waiter-showing-appetizers_23-2148244957.jpg?w=2000&t=st=1694219760~exp=1694220360~hmac=7021d37ae4a3507fd5fa8c18916c520ec8e222bbc92bbd71b69c91571ce9783f",true),
                    orgContainer(context, "TasteBud Treasures Catering", "https://img.freepik.com/free-photo/view-canapes-tartlets-buffet-table_1262-2061.jpg?1&w=2000&t=st=1694219738~exp=1694220338~hmac=e003298e38fa2cf7c6310d7f6e9e64a3286e9bfb9c523645dca00a1a4767f219",true),

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
        Navigator.push(context, CupertinoPageRoute(builder: (BuildContext context) => SingleServiceProvider(image: image,name: title,)));
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
                        color: Color(0xff09426d),
                        value: 5,
                      ),
                    ),
                    errorWidget: (context, url, error) => const Icon(Icons.error, color: Color(0xff09426d)),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                title,
                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.normal),
                maxLines: 2,
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),

          Positioned(
              right: 20,
              bottom: 55,
              child:verified? Container(
                  decoration: BoxDecoration(
                    color: Color(0xfff9f9f9),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: const Icon(Icons.verified,size: 20,color: Color(
                      0xff23a3dd),)) : const SizedBox()
          )
      ]
      ),
    );
  }

  Widget featuredOrg(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
          color: const Color(0xff09426d),
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
                      color: Color(0xff09426d),
                      value: 5,
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error, color: Color(0xff09426d)),
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
