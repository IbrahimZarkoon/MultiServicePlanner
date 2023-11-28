import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:provider/provider.dart';

import '../Enums/Colors.dart';
import '../Providers/CacheManager.dart';

// Widget catGrid(BuildContext context)
// {
//   return GridView(
//     padding: const EdgeInsets.only(top: 15,left: 15,right: 15),
//     scrollDirection: Axis.vertical,
//     physics: const BouncingScrollPhysics(),
//     shrinkWrap: true,
//     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         mainAxisSpacing: 0,
//         crossAxisSpacing: 15,
//         childAspectRatio: 1.275
//     ),
//     children: [
//
//       //1st Cat
//       catCon(context, "New Groups", "https://media.istockphoto.com/id/1136784887/video/silhouette-of-friends-jumping-on-beach-during-sunset-time-with-happy-emotion-4k-resolution.jpg?s=640x640&k=20&c=jEFvOMtbglxd5ysJt66eCUIWink_ri_ZQhWcCw-AXCg="),
//
//       catCon(context, "Art & Culture", "https://le-cdn.website-editor.net/s/4e1230f718ec46c292cf5c59ec48b940/dms3rep/multi/opt/1-7-1-98-1-Pottery-Painting-at-Quarry-Pottery-396w.jpg?Expires=1688404325&Signature=W26mBjtligNOWO0ua~cbB-DDMiGMKVT-SjLKLuFmoRYfJSFmyS8BQfKV7SSMUG4sWJwZK4Madregb8dHflZw6smKGysJuNsYxV0~o9WpxSJX5LXGlAdZQwXzCYSsacgvAmWjCFygs2pDDQWNMBZgVFPjxdNLsvgEJy4-tn9XwiP9DG82nbJcj5mUP5VSkecz5zMlhxHjVWmqVES~UKf9KfNhSg-g50hN1sUNEJlaxkZIQEbcjdBYeXrmPgL0oII0TD3-xN3r2C9GqtwmiJQ8W0uXHygtGmf95rvk~6DPlZlvGAez319GHqhIUzhbBK45Xpep1DZZwOFlUIL23ciYsw__&Key-Pair-Id=K2NXBXLF010TJW"),
//
//       catCon(context, "Career & Business", "https://media.istockphoto.com/id/1136998992/photo/the-monthly-management-meeting-has-begun.jpg?s=612x612&w=0&k=20&c=aYVmHLnNkx6NeybPpoSd7alpKPl0CwNlO3YFqRlRs04="),
//
//       catCon(context, "Dancing", "https://s.itl.cat/pngfile/s/11-112946_hd-wallpaper-dance-hip-hop-girl.jpg"),
//
//       catCon(context, "Games", "https://www.digitaltrends.com/wp-content/uploads/2018/04/htc-vive-pro-2018-review-5.jpg?fit=720%2C720&p=1"),
//
//       catCon(context, "Health & Wellbeing", "https://c0.wallpaperflare.com/preview/56/956/1001/yoga-zen-meditating-pose.jpg"),
//
//       catCon(context, "Hobbies & Passion", "https://images5.alphacoders.com/512/512811.jpg"),
//
//       catCon(context, "Music", "https://images.pexels.com/videos/15288810/bagpipes-scottish-15288810.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
//
//       catCon(context, "Social Activities", "https://media.istockphoto.com/id/891187194/photo/group-of-people-holding-hand-together-in-the-park.jpg?s=612x612&w=0&k=20&c=KIGXrdriCrbc4iOo8h5ILGuHHdVrJL7snylDbAE2C2I="),
//
//
//     ],
//   );
// }

Widget catCon(BuildContext context,String title, String image)
{
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      Container(
        height: 100,
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color(0xff545353),
          image: DecorationImage(
            image: NetworkImage(image),
            fit: BoxFit.cover
          )
        ),
      ),

      Text(title,
        style: const TextStyle(fontSize: 12,fontFamily: "Helvetica_Bold",color: Colors.white,fontWeight: FontWeight.bold),)
    ],
  );
}

Widget categoriesCon(BuildContext context)
{
  final cacheManager = Provider.of<CacheManagerProvider>(context).cacheManager;



  return Container(
    padding: const EdgeInsets.only(left: 15,right: 15),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [

        //1st Row
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: catCon2(context, "New Groups", "https://media.istockphoto.com/id/1136784887/video/silhouette-of-friends-jumping-on-beach-during-sunset-time-with-happy-emotion-4k-resolution.jpg?s=640x640&k=20&c=jEFvOMtbglxd5ysJt66eCUIWink_ri_ZQhWcCw-AXCg="),

            ),

            Expanded(
              child: catCon2(context, "Career & Business",
                  "https://media.istockphoto.com/id/1136998992/photo/the-monthly-management-meeting-has-begun.jpg?s=612x612&w=0&k=20&c=aYVmHLnNkx6NeybPpoSd7alpKPl0CwNlO3YFqRlRs04="),

            ),

            Expanded(
              child: catCon2(context, "Dancing", "https://s.itl.cat/pngfile/s/11-112946_hd-wallpaper-dance-hip-hop-girl.jpg"),

            ),
          ],
        ),

        const SizedBox(height: 5,),

        //2nd Row
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Stack(
                  children: [
                    Container(
                      height: 110,
                      //width: 110,
                      constraints: BoxConstraints(
                        minWidth: MediaQuery.of(context).size.width/1.7
                      ),
                      margin: const EdgeInsets.only(bottom: 10,right: 10),
                      foregroundDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        // gradient: LinearGradient(
                        //     colors: [
                        //       Colors.transparent,
                        //       Colors.black.withOpacity(0.75)
                        //     ],
                        //     stops: [0.1,1],
                        //     begin: Alignment.topCenter,
                        //     end: Alignment.bottomCenter
                        // ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                          color: const Color(0xff545353),
                          //image: const DecorationImage(image: NetworkImage("https://le-cdn.website-editor.net/s/4e1230f718ec46c292cf5c59ec48b940/dms3rep/multi/opt/1-7-1-98-1-Pottery-Painting-at-Quarry-Pottery-396w.jpg?Expires=1688404325&Signature=W26mBjtligNOWO0ua~cbB-DDMiGMKVT-SjLKLuFmoRYfJSFmyS8BQfKV7SSMUG4sWJwZK4Madregb8dHflZw6smKGysJuNsYxV0~o9WpxSJX5LXGlAdZQwXzCYSsacgvAmWjCFygs2pDDQWNMBZgVFPjxdNLsvgEJy4-tn9XwiP9DG82nbJcj5mUP5VSkecz5zMlhxHjVWmqVES~UKf9KfNhSg-g50hN1sUNEJlaxkZIQEbcjdBYeXrmPgL0oII0TD3-xN3r2C9GqtwmiJQ8W0uXHygtGmf95rvk~6DPlZlvGAez319GHqhIUzhbBK45Xpep1DZZwOFlUIL23ciYsw__&Key-Pair-Id=K2NXBXLF010TJW"), fit: BoxFit.cover)
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),

                        child: CachedNetworkImage(
                          imageUrl: "https://le-cdn.website-editor.net/s/4e1230f718ec46c292cf5c59ec48b940",
                          cacheManager: cacheManager,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(
                              color: appPrimary,
                              value: 5,
                            ),
                          ),
                          errorWidget: (context, url, error) => const Icon(Icons.error,color: appPrimary,),
                        ),
                      ),
                    ),

                    const Positioned(
                        top: 50,
                        left: 80,right: 15,
                        child: Text("Arts & Culture",
                          style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.bold),))
                  ]
              )
            ),

            Expanded(
              child: catCon2(context, "Games",
                  "https://www.digitaltrends.com/wp-content/uploads/2018/04/htc-vive-pro-2018-review-5.jpg?fit=720%2C720&p=1"),

            ),
          ],
        ),

        const SizedBox(height: 5,),

        //3rd Row
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: catCon2(context, "Health & Wellbeing", "https://c0.wallpaperflare.com/preview/56/956/1001/yoga-zen-meditating-pose.jpg"),

            ),

            Expanded(
              child: catCon2(context, "Hobbies & Passion", "https://images5.alphacoders.com/512/512811.jpg"),

            ),

            Expanded(
              child: catCon2(context, "Music", "https://images.pexels.com/videos/15288810/bagpipes-scottish-15288810.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),

            ),
          ],
        ),
      ],
    ),
  );
}

Widget catCon2(BuildContext context, String title, String image)
{
  final cacheManager = Provider.of<CacheManagerProvider>(context).cacheManager;


  return Stack(
    children: [
    Container(
      height: 110,
      width: 110,
      margin: const EdgeInsets.only(bottom: 10),
      foregroundDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: const LinearGradient(
            colors: [
              Colors.transparent,
              Colors.black
            ],
            stops: [0.1,1],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
        ),
      ),
      decoration: BoxDecoration(

          borderRadius: BorderRadius.circular(8),
          color: const Color(0xff545353),
          // image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover)
      ),
      child:  ClipRRect(
        borderRadius: BorderRadius.circular(8),
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
          errorWidget: (context, url, error) => const Icon(Icons.error,color: appPrimary,),
        ),
      ),
    ),

      Positioned(
        top: 50,
          left: 15,right: 15,
          child: Text(title,
          style: const TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.bold),))
  ]
  );
}


