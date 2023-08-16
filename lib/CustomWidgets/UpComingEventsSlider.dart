import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:provider/provider.dart';
import 'package:socialapp/Screens/SingleEvent.dart';

import '../Providers/CacheManager.dart';

Widget upComingSlider(BuildContext context)
{
  return Container(
    height: MediaQuery.of(context).size.height*0.22+20,

    child: ListView(
      padding: const EdgeInsets.only(left: 15,right: 15),
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,

      children: [

        //1st Item
        eventCon(context,"Ariana Grande",
          "21 Oct",
          "https://seatgeek.com/images/performers-landscape/ariana-grande-7f84f2/13852/1100x1900.jpg"
        ),

        eventCon(context, "The National Event", "15 Oct", "https://www.apma.org/files/2017/images/APMA_ASM23_homepage_v2.png"),

        eventCon(context,"Rave Party",
            "06 July",
            "https://agendabrussels.imgix.net/004a2b71108438b08b4c2d39af2e4173770c6408.jpg"
        ),
        eventCon(context,"Ariana Grande",
            "21 Oct",
            "https://seatgeek.com/images/performers-landscape/ariana-grande-7f84f2/13852/1100x1900.jpg"
        ),
        eventCon(context,"Ariana Grande",
            "21 Oct",
            "https://seatgeek.com/images/performers-landscape/ariana-grande-7f84f2/13852/1100x1900.jpg"
        ),
      ],
    ),

  );
}

Widget openAirSlider(BuildContext context)
{
  return Container(
    height: MediaQuery.of(context).size.height*0.22+20,

    child: ListView(
      padding: const EdgeInsets.only(left: 15,right: 15),
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,

      children: [

        //1st Item
        eventCon(context,"Ariana Grande",
            "21 Oct",
            "https://images.news.iu.edu/dams/3duyrpcxyz_actual.jpg"
        ),

        eventCon(context, "The National Event", "15 Oct", "https://codaaudio.com/wp-content/uploads/2018/01/Open-Air-Festival-55323994-900.jpg"),

        eventCon(context,"Rave Party",
            "06 July",
            "https://www.goldplast.com/dam/jcr:b820f3a5-32a9-4f19-a6de-44720bfedd0a/evento-en-plein-air.jpg"
        ),
        eventCon(context,"Ariana Grande",
            "21 Oct",
            "https://seatgeek.com/images/performers-landscape/ariana-grande-7f84f2/13852/1100x1900.jpg"
        ),
        eventCon(context,"Ariana Grande",
            "21 Oct",
            "https://seatgeek.com/images/performers-landscape/ariana-grande-7f84f2/13852/1100x1900.jpg"
        ),
      ],
    ),

  );
}

Widget eventVenueSlider(BuildContext context)
{
  return Container(
    height: MediaQuery.of(context).size.height*0.22+20,

    child: ListView(
      padding: const EdgeInsets.only(left: 15,right: 15),
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,

      children: [

        //1st Item
        eventCon(context,"Metropol",
            "750 - 1000 Persons",
            "https://prestigiousvenues.com/wp-content/uploads/bb-plugin/cache/Gala-Dinner-Venue-In-London-Gibson-Hall-Prestigious-Venues-panorama.jpg"
        ),

        eventCon(context, "The Audit", "1000 - 1500 Persons", "https://whova.com/wp-content/uploads/2015/06/choose-perfect-event-venue.jpg"),

        eventCon(context,"Rooftop Sitting",
            "50 - 75 Persons",
            "https://uploads-ssl.webflow.com/6074635e07fbbbc45f34a580/62ec4ee841fac723b6ffc030_Facebook-.jpg"
        ),
        eventCon(context,"Ariana Grande",
            "21 Oct",
            "https://seatgeek.com/images/performers-landscape/ariana-grande-7f84f2/13852/1100x1900.jpg"
        ),
        eventCon(context,"Ariana Grande",
            "21 Oct",
            "https://seatgeek.com/images/performers-landscape/ariana-grande-7f84f2/13852/1100x1900.jpg"
        ),
      ],
    ),

  );
}

Widget eventCon(BuildContext context, String title, String date, String image) {
  final cacheManager = Provider.of<CacheManagerProvider>(context).cacheManager;

  return InkWell(
    onTap: () {
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) => SingleEvent(title: title, image: image, repeat: false,past: false,),
      );
    },
    child: Container(
      margin: const EdgeInsets.only(right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 5),
            width: 140,
            height: MediaQuery.of(context).size.height * 0.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xfff9f9f9)
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
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
                errorWidget: (context, url, error) => const Icon(Icons.error,color: Color(0xffff1f6f),),
              ),
            ),
          ),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.black.withOpacity(0.8),
              fontSize: 12,
              fontWeight: FontWeight.bold,
              fontFamily: "Helvetica_Bold",
            ),
          ),
          const SizedBox(height: 2),
          Text(
            date,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.black.withOpacity(0.6),
              fontSize: 10,
              fontWeight: FontWeight.normal,
              fontFamily: "",
            ),
          ),
        ],
      ),
    ),
  );
}

//
// Widget eventCon(BuildContext context,String title,String date, String image)
// {
//   return InkWell(
//     onTap: ()
//     {
//       showModalBottomSheet(
//           isScrollControlled: true,
//           context: context, builder: (BuildContext context) => SingleEvent(title: title, image: image));
//     },
//     child: Container(
//       margin: const EdgeInsets.only(right: 10),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Container(
//             margin: const EdgeInsets.only(bottom: 5),
//             width: 140,
//             height: MediaQuery.of(context).size.height*0.2,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 gradient: LinearGradient(
//                     colors: [
//                       Colors.transparent,
//                       Colors.black.withOpacity(0.8)
//                     ],
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter),
//                 image: DecorationImage(
//                     image: NetworkImage(
//                         image),
//                     fit: BoxFit.cover)),
//           ),
//
//           Text(title,maxLines: 1,overflow: TextOverflow.ellipsis,
//             style: TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 12,fontWeight: FontWeight.bold,fontFamily: "Helvetica_Bold"),),
//
//           const SizedBox(height: 2,),
//
//           Text(date,maxLines: 1,overflow: TextOverflow.ellipsis,
//             style: TextStyle(color: Colors.black.withOpacity(0.6),fontSize: 10,fontWeight: FontWeight.normal,fontFamily: ""),),
//         ],
//       ),
//     ),
//   );
// }