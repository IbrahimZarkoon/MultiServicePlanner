import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:provider/provider.dart';
import '../Providers/CacheManager.dart';
import '../Response/ServiceResponse.dart';
import '../Screens/SingleEvent.dart';

Widget popularSlider(BuildContext context,List<ServiceResponse> data)
{
  return Container(
    height: MediaQuery.of(context).size.height*0.22+30,

    child: ListView.builder(
      itemCount: data.length ?? 0,
      padding: const EdgeInsets.only(left: 15,right: 15),
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context,index)
      {
        return eventCon(context,"${data[index].venueName ?? ""}",
            "Starting from ${data[index].priceRangeStart ?? ""} PKR",
            "https://everythingforpageants.com/msp/${data[index].bannerImg ?? ""}",
        );
      },
      // children: [
      //
      //   //1st Item
      //   eventCon(context,"Beach Hut",
      //       "Starting from 65,000 PKR",
      //       "https://vistavenues.com/wp-content/uploads/2022/04/Artboard-3-3.webp",true
      //   ),
      //
      //   eventCon(context, "City Banquet", "Starting from 199,999 PKR", "https://lh3.googleusercontent.com/p/AF1QipN58xgq9tgCaji7OA83flZUwhPBIWQB7Dib0c3a=s1360-w1360-h1020",true),
      //
      //   eventCon(context,"Neha Grande",
      //       "Photographer",
      //       "https://img.freepik.com/free-photo/cheerful-photographer-giving-instructions-studio_53876-146577.jpg?w=2000&t=st=1694210530~exp=1694211130~hmac=e5769008f9a2be22bda06472d697585c35c62a4b1c0bf4494d3b57e13e0c53e1",
      //     false
      //   ),
      //
      //
      //   eventCon(context,"Mehmil Banquet",
      //       "Starting from 75,000 PKR",
      //       "https://lh3.googleusercontent.com/p/AF1QipNZnM22L2u35UpvbdkwUoz0AjAnqdowyJIVdQkR=s1360-w1360-h1020",true
      //   ),
      //
      // ],
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