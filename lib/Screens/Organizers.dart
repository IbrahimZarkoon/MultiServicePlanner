import 'dart:convert';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;
import '../CustomWidgets/Headings.dart';
import '../Providers/CacheManager.dart';
import '../Response/ServiceResponse.dart';
import '../modals/AllServiceProvider.dart';
import 'MyProfile.dart';
import 'SingleOrganizer.dart';

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
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    topStoreController.addListener(_topStoreScrollListener);
    var allServiceProv = Provider.of<AllServiceProvider>(context,listen:false);


    return Scaffold(
      key: _organizersScaffoldKey,
      endDrawer: Drawer(
        elevation: 10,
        shadowColor: Colors.black.withOpacity(0.5),
        child: const MyProfile(),

      ),


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
                GridView.builder(
                  padding: const EdgeInsets.only(left: 15,right: 15,top: 5,bottom: 5),

                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  // crossAxisCount: 3,
                  // mainAxisSpacing: 10,
                  // crossAxisSpacing: 10,
                  // childAspectRatio: 0.85,
                  itemCount: allServiceProv.photographers?.length ?? 0,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.85,
                  ), itemBuilder: (BuildContext context, int index) {
                  return orgContainer(context, "${allServiceProv.photographers?[index].venueName ?? ""}",
                      "https://everythingforpageants.com/msp/${allServiceProv.photographers?[index].bannerImg ?? ""}",
                      "${allServiceProv.photographers?[index].userId ?? ""}");

                },
                  // children: [
                  //   orgContainer(context, "PixelPerfect Moments", "https://img.freepik.com/free-photo/people-working-together-new-movie_23-2149066321.jpg?w=2000&t=st=1694219857~exp=1694220457~hmac=af7b18895070ba727c2600f473252abe1bed9c514d2d9d53ce52cdc150656561",true),
                  //   orgContainer(context, "LensCrafted Photography", "https://img.freepik.com/free-photo/people-working-together-new-film_23-2149066343.jpg?w=2000&t=st=1694219850~exp=1694220450~hmac=fdbfd1e6651231c7add8e2b84f875b8ad90133ac2af6792416cb9b7172482d84",false),
                  //   orgContainer(context, "ShutterMagic Studios", "https://img.freepik.com/free-photo/meeting-with-other-photographers-office_329181-12371.jpg?w=2000&t=st=1694219851~exp=1694220451~hmac=0d0c3d4540b3698c8a1d832517fdf0ba9f3771de736570ab1ca22c38f396c916",true),
                  //   orgContainer(context, "FocusEra Photography", "https://img.freepik.com/free-photo/woman-man-looking-camera-photos_23-2148532473.jpg?w=2000&t=st=1694219852~exp=1694220452~hmac=1700f48a97efcefba80a4cbda5dd68dc8482d0a339ad11bcb907a69fe92e51d9",true),
                  //   orgContainer(context, "SnapVista Creations", "https://img.freepik.com/free-photo/man-filming-with-professional-camera_23-2149066342.jpg?w=2000&t=st=1694219854~exp=1694220454~hmac=035045ebd35cfb6ef2f6b97992e6ab9a57417b4ed7f64facff02a10a2616a113",false),
                  //
                  // ],
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
                      Headings(context, "Venues"),
                    ],
                  ),
                ),

                //Venues Grid
                GridView.builder(
                  padding: const EdgeInsets.only(left: 15,right: 15,top: 5,bottom: 5),

                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  // crossAxisCount: 3,
                  // mainAxisSpacing: 10,
                  // crossAxisSpacing: 10,
                  // childAspectRatio: 0.85,
                  itemCount: allServiceProv.venues?.length ?? 0,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.85,
                  ), itemBuilder: (BuildContext context, int index) {
                  return orgContainer(context, "${allServiceProv.venues?[index].venueName ?? ""}",
                      "https://everythingforpageants.com/msp/${allServiceProv.venues?[index].bannerImg ?? ""}",
                      "${allServiceProv.venues?[index].userId ?? ""}");

                },
                  // children: [
                  //   orgContainer(context, "PixelPerfect Moments", "https://img.freepik.com/free-photo/people-working-together-new-movie_23-2149066321.jpg?w=2000&t=st=1694219857~exp=1694220457~hmac=af7b18895070ba727c2600f473252abe1bed9c514d2d9d53ce52cdc150656561",true),
                  //   orgContainer(context, "LensCrafted Photography", "https://img.freepik.com/free-photo/people-working-together-new-film_23-2149066343.jpg?w=2000&t=st=1694219850~exp=1694220450~hmac=fdbfd1e6651231c7add8e2b84f875b8ad90133ac2af6792416cb9b7172482d84",false),
                  //   orgContainer(context, "ShutterMagic Studios", "https://img.freepik.com/free-photo/meeting-with-other-photographers-office_329181-12371.jpg?w=2000&t=st=1694219851~exp=1694220451~hmac=0d0c3d4540b3698c8a1d832517fdf0ba9f3771de736570ab1ca22c38f396c916",true),
                  //   orgContainer(context, "FocusEra Photography", "https://img.freepik.com/free-photo/woman-man-looking-camera-photos_23-2148532473.jpg?w=2000&t=st=1694219852~exp=1694220452~hmac=1700f48a97efcefba80a4cbda5dd68dc8482d0a339ad11bcb907a69fe92e51d9",true),
                  //   orgContainer(context, "SnapVista Creations", "https://img.freepik.com/free-photo/man-filming-with-professional-camera_23-2149066342.jpg?w=2000&t=st=1694219854~exp=1694220454~hmac=035045ebd35cfb6ef2f6b97992e6ab9a57417b4ed7f64facff02a10a2616a113",false),
                  //
                  // ],
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

                //Decors Grid
                GridView.builder(
                  padding: const EdgeInsets.only(left: 15,right: 15,top: 5,bottom: 5),

                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  // crossAxisCount: 3,
                  // mainAxisSpacing: 10,
                  // crossAxisSpacing: 10,
                  // childAspectRatio: 0.85,
                  itemCount: allServiceProv.decors?.length ?? 0,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.85,
                  ), itemBuilder: (BuildContext context, int index) {
                  return orgContainer(context, "${allServiceProv.decors?[index].venueName ?? ""}",
                      "https://everythingforpageants.com/msp/${allServiceProv.decors?[index].bannerImg ?? ""}",
                      "${allServiceProv.decors?[index].userId ?? ""}");

                },
                  // children: [
                  //   orgContainer(context, "PixelPerfect Moments", "https://img.freepik.com/free-photo/people-working-together-new-movie_23-2149066321.jpg?w=2000&t=st=1694219857~exp=1694220457~hmac=af7b18895070ba727c2600f473252abe1bed9c514d2d9d53ce52cdc150656561",true),
                  //   orgContainer(context, "LensCrafted Photography", "https://img.freepik.com/free-photo/people-working-together-new-film_23-2149066343.jpg?w=2000&t=st=1694219850~exp=1694220450~hmac=fdbfd1e6651231c7add8e2b84f875b8ad90133ac2af6792416cb9b7172482d84",false),
                  //   orgContainer(context, "ShutterMagic Studios", "https://img.freepik.com/free-photo/meeting-with-other-photographers-office_329181-12371.jpg?w=2000&t=st=1694219851~exp=1694220451~hmac=0d0c3d4540b3698c8a1d832517fdf0ba9f3771de736570ab1ca22c38f396c916",true),
                  //   orgContainer(context, "FocusEra Photography", "https://img.freepik.com/free-photo/woman-man-looking-camera-photos_23-2148532473.jpg?w=2000&t=st=1694219852~exp=1694220452~hmac=1700f48a97efcefba80a4cbda5dd68dc8482d0a339ad11bcb907a69fe92e51d9",true),
                  //   orgContainer(context, "SnapVista Creations", "https://img.freepik.com/free-photo/man-filming-with-professional-camera_23-2149066342.jpg?w=2000&t=st=1694219854~exp=1694220454~hmac=035045ebd35cfb6ef2f6b97992e6ab9a57417b4ed7f64facff02a10a2616a113",false),
                  //
                  // ],
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

                //Caterers Grid
                GridView.builder(
                  padding: const EdgeInsets.only(left: 15,right: 15,top: 5,bottom: 5),

                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  // crossAxisCount: 3,
                  // mainAxisSpacing: 10,
                  // crossAxisSpacing: 10,
                  // childAspectRatio: 0.85,
                  itemCount: allServiceProv.caterers?.length ?? 0,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.85,
                  ), itemBuilder: (BuildContext context, int index) {
                  return orgContainer(context, "${allServiceProv.caterers?[index].venueName ?? ""}",
                      "https://everythingforpageants.com/msp/${allServiceProv.caterers?[index].bannerImg ?? ""}",
                      "${allServiceProv.caterers?[index].userId ?? ""}");

                },
                  // children: [
                  //   orgContainer(context, "PixelPerfect Moments", "https://img.freepik.com/free-photo/people-working-together-new-movie_23-2149066321.jpg?w=2000&t=st=1694219857~exp=1694220457~hmac=af7b18895070ba727c2600f473252abe1bed9c514d2d9d53ce52cdc150656561",true),
                  //   orgContainer(context, "LensCrafted Photography", "https://img.freepik.com/free-photo/people-working-together-new-film_23-2149066343.jpg?w=2000&t=st=1694219850~exp=1694220450~hmac=fdbfd1e6651231c7add8e2b84f875b8ad90133ac2af6792416cb9b7172482d84",false),
                  //   orgContainer(context, "ShutterMagic Studios", "https://img.freepik.com/free-photo/meeting-with-other-photographers-office_329181-12371.jpg?w=2000&t=st=1694219851~exp=1694220451~hmac=0d0c3d4540b3698c8a1d832517fdf0ba9f3771de736570ab1ca22c38f396c916",true),
                  //   orgContainer(context, "FocusEra Photography", "https://img.freepik.com/free-photo/woman-man-looking-camera-photos_23-2148532473.jpg?w=2000&t=st=1694219852~exp=1694220452~hmac=1700f48a97efcefba80a4cbda5dd68dc8482d0a339ad11bcb907a69fe92e51d9",true),
                  //   orgContainer(context, "SnapVista Creations", "https://img.freepik.com/free-photo/man-filming-with-professional-camera_23-2149066342.jpg?w=2000&t=st=1694219854~exp=1694220454~hmac=035045ebd35cfb6ef2f6b97992e6ab9a57417b4ed7f64facff02a10a2616a113",false),
                  //
                  // ],
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

  Widget orgContainer(BuildContext context,String title, String image,String vendorID)
  {
    final cacheManager = Provider.of<CacheManagerProvider>(context).cacheManager;

    return GestureDetector(
      onTap: ()
      {
        Navigator.push(context, CupertinoPageRoute(builder: (BuildContext context) => SingleServiceProvider(image: image,name: title,id: vendorID,)));
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
          //
          // Positioned(
          //     right: 20,
          //     bottom: 55,
          //     child:Container(
          //         decoration: BoxDecoration(
          //             color: Color(0xfff9f9f9),
          //             borderRadius: BorderRadius.circular(10)
          //         ),
          //         child: const Icon(Icons.verified,size: 20,color: Color(
          //             0xff23a3dd),))
          // )
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
