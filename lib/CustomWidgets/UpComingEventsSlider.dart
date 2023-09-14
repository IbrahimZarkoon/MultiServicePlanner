import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:provider/provider.dart';
import 'package:socialapp/Screens/SingleEvent.dart';
import 'package:socialapp/Screens/SingleOrganizer.dart';

import '../Enums/Colors.dart';
import '../Providers/CacheManager.dart';

Widget featuredSlider(BuildContext context)
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
        eventCon(context,"Beach Hut",
            "Starting from 65,000 PKR",
            "https://vistavenues.com/wp-content/uploads/2022/04/Artboard-3-3.webp",true
        ),

        eventCon(context, "City Banquet", "Starting from 199,999 PKR", "https://lh3.googleusercontent.com/p/AF1QipN58xgq9tgCaji7OA83flZUwhPBIWQB7Dib0c3a=s1360-w1360-h1020",true),

        eventCon(context,"Neha Grande",
            "Photographer",
            "https://img.freepik.com/free-photo/cheerful-photographer-giving-instructions-studio_53876-146577.jpg?w=2000&t=st=1694210530~exp=1694211130~hmac=e5769008f9a2be22bda06472d697585c35c62a4b1c0bf4494d3b57e13e0c53e1",
          false
        ),


        eventCon(context,"Mehmil Banquet",
            "Starting from 75,000 PKR",
            "https://lh3.googleusercontent.com/p/AF1QipNZnM22L2u35UpvbdkwUoz0AjAnqdowyJIVdQkR=s1360-w1360-h1020",true
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
        eventCon(context, "Ramada by Wyndham", "Starting from 299,999 PKR", "https://cdn0.weddingwire.in/vendor/3689/3_2/960/jpeg/whatsapp-image-2021-01-14-at-3-56-13-pm_15_273689-161082888490224.jpeg",true),


        eventCon(context,"Beach Hut",
            "Starting from 65,000 PKR",
            "https://vistavenues.com/wp-content/uploads/2022/04/Artboard-3-3.webp",true
        ),

        eventCon(context,"Rooftop Sitting",
            "50 - 75 Persons",
            "https://uploads-ssl.webflow.com/6074635e07fbbbc45f34a580/62ec4ee841fac723b6ffc030_Facebook-.jpg",true
        ),

        eventCon(context,"Kolachi",
            "Starting from 29,000 PKR",
            "https://www.goldplast.com/dam/jcr:b820f3a5-32a9-4f19-a6de-44720bfedd0a/evento-en-plein-air.jpg",true
        ),

      ],
    ),

  );
}

Widget inDoorSlider(BuildContext context)
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
        eventCon(context,"The Mansion Marquee",
            "Starting from 449,999 PKR",
            "https://lh3.googleusercontent.com/p/AF1QipMMA2FZL6AoCxpYGlnPW0j0gkxZsoutgA6C2dsL=s1360-w1360-h1020",true
        ),

        eventCon(context,"Ramada Plaza Airport",
            "Starting from 349,999 PKR",
            "https://ramadalewistonmaine.com/wp-content/uploads/2019/02/ritz.jpg",true
        ),

        eventCon(context,"Sofitel Luxury Banquet",
            "Starting from 199,000 PKR",
            "https://lh3.googleusercontent.com/p/AF1QipNlchkC4483B9cyd0JgOSdnCJdKsNjB-P04N8nd=s1360-w1360-h1020",true
        ),
      ],
    ),

  );
}

Widget eventCon(BuildContext context, String title, String date, String image,bool venue) {
  final cacheManager = Provider.of<CacheManagerProvider>(context).cacheManager;

  return InkWell(
    onTap: () {
      venue? showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) => SingleEvent(title: title, image: image, repeat: false,past: false,),
      ) 
      :
      Navigator.push(context, CupertinoPageRoute(builder: (BuildContext context) => SingleServiceProvider(name: title, image: image)));
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
                      color: appPrimary,
                      value: 5,
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error,color: Color(0xff09426d),),
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
