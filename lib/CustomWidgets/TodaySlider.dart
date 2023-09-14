import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:provider/provider.dart';
import 'package:socialapp/Screens/SingleEvent.dart';

import '../Providers/CacheManager.dart';

Widget popularSlider(BuildContext context)
{
  return Container(
    height: MediaQuery.of(context).size.height*0.22+30,

    child: ListView(
      padding: const EdgeInsets.only(left: 15,right: 15),
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,

      children: [

        eventCon(context,"The Mansion Marquee",
            "Starting from 449,999 PKR",
            "https://lh3.googleusercontent.com/p/AF1QipMMA2FZL6AoCxpYGlnPW0j0gkxZsoutgA6C2dsL=s1360-w1360-h1020"
        ),

        //1st Item
        eventCon(context,"Ramada Plaza Airport",
            "Starting from 349,999 PKR",
            "https://ramadalewistonmaine.com/wp-content/uploads/2019/02/ritz.jpg"
        ),

        eventCon(context,"Sofitel Luxury Banquet",
            "Starting from 199,000 PKR",
            "https://lh3.googleusercontent.com/p/AF1QipNlchkC4483B9cyd0JgOSdnCJdKsNjB-P04N8nd=s1360-w1360-h1020"
        ),

        eventCon(context, "Ramada by Wyndham", "Starting from 299,999 PKR", "https://cdn0.weddingwire.in/vendor/3689/3_2/960/jpeg/whatsapp-image-2021-01-14-at-3-56-13-pm_15_273689-161082888490224.jpeg"),



      ],
    ),

  );
}

Widget eventCon(BuildContext context,String title,String date, String image)
{
  final cacheManager = Provider.of<CacheManagerProvider>(context).cacheManager;

  return InkWell(
    onTap: ()
    {
      showModalBottomSheet(
          isScrollControlled: true,
          context: context, builder: (BuildContext context) => SingleEvent(title: title, image: image, repeat: true,past: false,));
    },
    child: Container(
      margin: const EdgeInsets.only(right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            width: MediaQuery.of(context).size.width/1.2,
            height: MediaQuery.of(context).size.height*0.2,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.8)
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter),
                // image: DecorationImage(
                //     image: NetworkImage(
                //         image),
                //     fit: BoxFit.cover)
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                imageUrl: image,
                cacheManager: cacheManager,
                fit: BoxFit.cover,
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(
                    color: Color(0xff09426d),
                    value: 5,
                  ),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error,color: Color(0xff09426d),),
              ),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(title,maxLines: 1,overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 14,fontWeight: FontWeight.bold,fontFamily: "Helvetica_Bold"),),

                  const SizedBox(height: 2,),

                  Text(date,maxLines: 1,overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.black.withOpacity(0.6),fontSize: 12,fontWeight: FontWeight.normal,fontFamily: ""),),
                ],
              ),
              //
              // Container(
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(20),
              //       border: Border.all(color: Color(0xffff1f6f))
              //   ),
              //   padding: EdgeInsets.only(top: 5,bottom: 5,left: 5,right: 5),
              //   //alignment: Alignment.center,
              //   child: Text("View details",
              //     style: TextStyle(color: Color(0xffff1f6f),fontSize: 10),),
              // )
            ],
          ),
        ],
      ),
    ),
  );
}