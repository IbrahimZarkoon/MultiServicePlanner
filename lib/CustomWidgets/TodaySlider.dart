import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:provider/provider.dart';
import 'package:socialapp/Screens/SingleEvent.dart';

import '../Providers/CacheManager.dart';

Widget todaySlider(BuildContext context)
{
  return Container(
    height: MediaQuery.of(context).size.height*0.22+30,

    child: ListView(
      padding: const EdgeInsets.only(left: 15,right: 15),
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,

      children: [

        //1st Item
        eventCon(context,"Twenty One Pilots",
            "20 June",
            "https://www.papercitymag.com/wp-content/uploads/2019/11/Twenty-One-Pilots-press-photo-2018-cr-Brad-Heaton-billboard-1548.jpg"
        ),

        eventCon(context, "50 Cent", "15 Oct", "https://climatepledgearena.com/wp-content/uploads/2023/05/23-50CENT_CPA-Web_1600x900.jpg"),

        eventCon(context,"Rave Party",
            "06 July",
            "https://siachenstudios.com/wp-content/uploads/2021/05/what-is-rave-party.jpg"
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
                    color: Color(0xffff1f6f),
                    value: 5,
                  ),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error,color: Color(0xffff1f6f),),
              ),
            ),
          ),

          Text(title,maxLines: 1,overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 14,fontWeight: FontWeight.bold,fontFamily: "Helvetica_Bold"),),

          const SizedBox(height: 2,),

          Text(date,maxLines: 1,overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.black.withOpacity(0.6),fontSize: 12,fontWeight: FontWeight.normal,fontFamily: ""),),
        ],
      ),
    ),
  );
}