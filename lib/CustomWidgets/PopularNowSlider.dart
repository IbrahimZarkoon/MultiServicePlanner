import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:socialapp/Screens/SingleEvent.dart';

import '../Providers/CacheManager.dart';

Widget popNowSlider(BuildContext context)
{
  return Container(
    height: MediaQuery.of(context).size.height*0.38,
    child: ListView(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(top: 15,bottom: 15),
      children: [

        eventCon(context,
            "https://secure.meetupstatic.com/photos/event/9/8/2/6/event_513578950.jpeg",
            "Creating a Print On Demand Business & Integrating AI (zero Start up \$)",
            "New York Small Business Online Marketing Meetup Group",
            "THU, JUL 22 · 6:00 AM PKT"
        ),

        eventCon(context,
            "https://secure.meetupstatic.com/photos/event/c/9/7/a/600_513651578.webp?w=750",
            "Polkadot Decoded Viewing Party - Bogotá",
            "Polkadot Decoded comes to Bogotá!\nAt the Polkadot Decoded View Party in Bogotá, we will broadcast the most important talks from Polkadot's flagship event for all attendees, as well as have networking spaces to delve into the topics discussed during the event, with the aim of making it an interactive experience. , which allows everyone to share their perspectives, ideas and points of view. By meeting, we can collectively deepen our understanding of Polkadot and its role in shaping the future of decentralized applications.",
            "THU, JUN 29 · 4:00 AM PKT"
        ),

        eventCon(context,
            "https://secure.meetupstatic.com/photos/event/a/b/5/a/event_513463866.jpeg",
            "Creating a Print On Demand Business & Integrating AI (Zee Course sadasda",
            "We invite you to an afternoon with Jakub Pilimon as part of the meetings of our Tri-City DDD community. Jakub will lead a lecture and discussion.",
            "THU, JUN 22 - 12:00 AM"
        ),





        const SizedBox(width: 15,),

      ],
    ),
  );
}

Widget similarEventsSlider(BuildContext context)
{
  return Container(
    height: MediaQuery.of(context).size.height*0.38,
    child: ListView(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(top: 15,bottom: 15),
      children: [

        eventCon(context,
            "https://secure.meetupstatic.com/photos/event/4/4/c/b/event_513497611.jpeg",
            "Revolutionizing Value Delivery: Product Ops and VRO",
            "New York Small Business Online Marketing Meetup Group",
            "THU, JUL 22 · 6:00 AM PKT"
        ),

        eventCon(context,
            "https://secure.meetupstatic.com/photos/event/c/9/7/a/600_513651578.webp?w=750",
            "Polkadot Decoded Viewing Party - Bogotá",
            "Polkadot Decoded comes to Bogotá!\nAt the Polkadot Decoded View Party in Bogotá, we will broadcast the most important talks from Polkadot's flagship event for all attendees, as well as have networking spaces to delve into the topics discussed during the event, with the aim of making it an interactive experience. , which allows everyone to share their perspectives, ideas and points of view. By meeting, we can collectively deepen our understanding of Polkadot and its role in shaping the future of decentralized applications.",
            "THU, JUN 29 · 4:00 AM PKT"
        ),

        eventCon(context,
            "https://secure.meetupstatic.com/photos/event/a/b/5/a/event_513463866.jpeg",
            "Creating a Print On Demand Business & Integrating AI (Zee Course sadasda",
            "We invite you to an afternoon with Jakub Pilimon as part of the meetings of our Tri-City DDD community. Jakub will lead a lecture and discussion.",
            "THU, JUN 22 - 12:00 AM"
        ),





        const SizedBox(width: 15,),

      ],
    ),
  );
}

Widget outDoorSlider(BuildContext context)
{
  return Container(
    height: MediaQuery.of(context).size.height*0.38,
    child: ListView(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(top: 15,bottom: 15),
      children: [

        eventCon(context,
            "https://secure.meetupstatic.com/photos/event/1/a/8/d/600_513306797.webp?w=750",
            "Creating High Precision AI: The Power of Data Labeling and Custom Model Training",
            "The increasing use of large language models, such as ChatGPT and GPT-4, can be attributed to their exceptional text generation capabilities. However, these models often encounter issues with low accuracy and 'hallucinations' when applied to domain-specific document comprehension. This presents a substantial challenge to mission-critical sectors such as healthcare, government, and finance that require precise, domain-specific knowledge.",
            "THU, JUN 22 · 6:00 AM PKT"
        ),

        eventCon(context,
            "https://secure.meetupstatic.com/photos/event/c/9/7/a/600_513651578.webp?w=750",
            "Polkadot Decoded Viewing Party - Bogotá",
            "Polkadot Decoded comes to Bogotá!\nAt the Polkadot Decoded View Party in Bogotá, we will broadcast the most important talks from Polkadot's flagship event for all attendees, as well as have networking spaces to delve into the topics discussed during the event, with the aim of making it an interactive experience. , which allows everyone to share their perspectives, ideas and points of view. By meeting, we can collectively deepen our understanding of Polkadot and its role in shaping the future of decentralized applications.",
            "THU, JUN 29 · 4:00 AM PKT"
        ),

        eventCon(context,
            "https://secure.meetupstatic.com/photos/event/a/b/5/a/event_513463866.jpeg",
            "Creating a Print On Demand Business & Integrating AI (Zee Course sadasda",
            "We invite you to an afternoon with Jakub Pilimon as part of the meetings of our Tri-City DDD community. Jakub will lead a lecture and discussion.",
            "THU, JUN 22 - 12:00 AM"
        ),





        const SizedBox(width: 15,),

      ],
    ),
  );
}

Widget learningSlider(BuildContext context)
{
  return Container(
    height: MediaQuery.of(context).size.height*0.38,
    child: ListView(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(top: 15,bottom: 15),
      children: [

        eventCon(context,
            "https://secure.meetupstatic.com/photos/event/1/a/8/d/600_513306797.webp?w=750",
            "Creating High Precision AI: The Power of Data Labeling and Custom Model Training",
            "The increasing use of large language models, such as ChatGPT and GPT-4, can be attributed to their exceptional text generation capabilities. However, these models often encounter issues with low accuracy and 'hallucinations' when applied to domain-specific document comprehension. This presents a substantial challenge to mission-critical sectors such as healthcare, government, and finance that require precise, domain-specific knowledge.",
            "THU, JUN 22 · 6:00 AM PKT"
        ),

        eventCon(context,
            "https://secure.meetupstatic.com/photos/event/c/9/7/a/600_513651578.webp?w=750",
            "Polkadot Decoded Viewing Party - Bogotá",
            "Polkadot Decoded comes to Bogotá!\nAt the Polkadot Decoded View Party in Bogotá, we will broadcast the most important talks from Polkadot's flagship event for all attendees, as well as have networking spaces to delve into the topics discussed during the event, with the aim of making it an interactive experience. , which allows everyone to share their perspectives, ideas and points of view. By meeting, we can collectively deepen our understanding of Polkadot and its role in shaping the future of decentralized applications.",
            "THU, JUN 29 · 4:00 AM PKT"
        ),

        eventCon(context,
            "https://secure.meetupstatic.com/photos/event/a/b/5/a/event_513463866.jpeg",
            "Creating a Print On Demand Business & Integrating AI (Zee Course sadasda",
            "We invite you to an afternoon with Jakub Pilimon as part of the meetings of our Tri-City DDD community. Jakub will lead a lecture and discussion.",
            "THU, JUN 22 - 12:00 AM"
        ),





        const SizedBox(width: 15,),

      ],
    ),
  );
}

Widget healthSlider(BuildContext context)
{
  return Container(
    height: MediaQuery.of(context).size.height*0.38,
    child: ListView(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(top: 15,bottom: 15),
      children: [

        eventCon(context,
            "https://secure.meetupstatic.com/photos/event/1/a/8/d/600_513306797.webp?w=750",
            "Creating High Precision AI: The Power of Data Labeling and Custom Model Training",
            "The increasing use of large language models, such as ChatGPT and GPT-4, can be attributed to their exceptional text generation capabilities. However, these models often encounter issues with low accuracy and 'hallucinations' when applied to domain-specific document comprehension. This presents a substantial challenge to mission-critical sectors such as healthcare, government, and finance that require precise, domain-specific knowledge.",
            "THU, JUN 22 · 6:00 AM PKT"
        ),

        eventCon(context,
            "https://secure.meetupstatic.com/photos/event/c/9/7/a/600_513651578.webp?w=750",
            "Polkadot Decoded Viewing Party - Bogotá",
            "Polkadot Decoded comes to Bogotá!\nAt the Polkadot Decoded View Party in Bogotá, we will broadcast the most important talks from Polkadot's flagship event for all attendees, as well as have networking spaces to delve into the topics discussed during the event, with the aim of making it an interactive experience. , which allows everyone to share their perspectives, ideas and points of view. By meeting, we can collectively deepen our understanding of Polkadot and its role in shaping the future of decentralized applications.",
            "THU, JUN 29 · 4:00 AM PKT"
        ),

        eventCon(context,
            "https://secure.meetupstatic.com/photos/event/a/b/5/a/event_513463866.jpeg",
            "Creating a Print On Demand Business & Integrating AI (Zee Course sadasda",
            "We invite you to an afternoon with Jakub Pilimon as part of the meetings of our Tri-City DDD community. Jakub will lead a lecture and discussion.",
            "THU, JUN 22 - 12:00 AM"
        ),





        const SizedBox(width: 15,),

      ],
    ),
  );
}

Widget eventCon(BuildContext context,String image, String title, String desc, String date)
{
  final cacheManager = Provider.of<CacheManagerProvider>(context).cacheManager;


  return GestureDetector(
    onTap: ()
    {
      showModalBottomSheet(
        isScrollControlled: true,
          context: context,
          builder: (BuildContext context)
      {
        return SingleEvent(title: title,image: image, repeat: false,past: false,);
      });
    },
    child: Container(
      padding: const EdgeInsets.only(bottom: 0,top: 0),
      margin: const EdgeInsets.only(left: 15,top: 0),
      //width: MediaQuery.of(context).size.width/1.5,
      constraints: const BoxConstraints(
        minWidth: 150, maxWidth: 250,
      ),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: const Offset(0,0),
                blurRadius: 1,
                spreadRadius: 1
            )
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(8)
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          //Image Container
          Container(
            height: MediaQuery.of(context).size.height*0.175,
            decoration: const BoxDecoration(
                color: Color(0xfff1f1f1),
                // image: DecorationImage(
                //     image: NetworkImage(
                //         image
                //     ),
                //     fit: BoxFit.cover
                // )
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(topRight: Radius.circular(8),topLeft: Radius.circular(8)),
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

          const SizedBox(height: 10,),

          //Details Column
          Padding(
            padding: const EdgeInsets.only(left: 15,right: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(date,
                  style: TextStyle(fontSize: 12,color: Colors.black.withOpacity(0.4),fontFamily: "Helvetica_Bold"),),

                const SizedBox(height: 10,),

                //Title
                Text(title,
                  maxLines: 2,overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14,color: Colors.black.withOpacity(0.8),fontFamily: "Helvetica_Bold"),),

                const SizedBox(height: 10,),

                //Description
                Text(desc,

                  maxLines: 1,overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12,color: Colors.black.withOpacity(0.8),fontWeight: FontWeight.normal),),

                const SizedBox(height: 10,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: [

                    InkWell(
                        onTap: () => Share.share(title),
                        child: Icon(CupertinoIcons.share,color: Colors.black.withOpacity(0.3),)),

                    const SizedBox(width: 10,),

                    Icon(CupertinoIcons.bookmark,color: Colors.black.withOpacity(0.3),),
                  ],
                )
              ],
            ),
          )

        ],
      ),
    ),
  );
}

