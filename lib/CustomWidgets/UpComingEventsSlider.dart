import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:provider/provider.dart';
import '../Enums/Colors.dart';
import '../Providers/CacheManager.dart';
import '../Response/ServiceResponse.dart';
import '../Screens/SingleEvent.dart';
import '../Screens/SingleOrganizer.dart';

Widget featuredSlider(BuildContext context, List<ServiceResponse> data) {
  return Container(
    height: MediaQuery.of(context).size.height * 0.22 + 20,
    child: ListView.builder(
      itemCount: data.length ?? 0,
      padding: const EdgeInsets.only(left: 15, right: 15),
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return eventCon(
            context,
            "${data[index].venueName ?? ""}",
            "Starting from ${data[index].priceRangeStart ?? ""} PKR",
            "https://everythingforpageants.com/msp${data[index].bannerImg ?? ""}",
            true,
            data?[index]);
      },
    ),
  );
}

Widget decorSlider(BuildContext context, List<ServiceResponse> data) {
  return Container(
    height: MediaQuery.of(context).size.height * 0.22 + 20,
    child: ListView.builder(
      itemCount: data.length ?? 0,
      padding: const EdgeInsets.only(left: 15, right: 15),
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return eventCon(
            context,
            "${data[index].venueName ?? ""}",
            "",
            "https://everythingforpageants.com/msp${data[index].bannerImg ?? ""}",
            true,
            data?[index]);
      },
    ),
  );
}

Widget CatererSlider(BuildContext context, List<ServiceResponse> data) {
  return Container(
    height: MediaQuery.of(context).size.height * 0.22 + 20,
    child: ListView.builder(
      itemCount: data.length ?? 0,
      padding: const EdgeInsets.only(left: 15, right: 15),
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return eventCon(
            context,
            "${data[index].venueName ?? ""}",
            "",
            "https://everythingforpageants.com/msp${data[index].bannerImg ?? ""}",
            false,
            data?[index]);
      },
    ),
  );
}

Widget eventCon(BuildContext context, String title, String date, String image,
    bool venue, ServiceResponse? data) {
  final cacheManager = Provider.of<CacheManagerProvider>(context).cacheManager;

  return InkWell(
    onTap: () {
      venue
          ? showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) => SingleEvent(
                  title: title,
                  image: image,
                  repeat: false,
                  past: false,
                  data: data),
            )
          : Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (BuildContext context) =>
                      SingleServiceProvider(name: title, image: image)));
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
                color: const Color(0xfff9f9f9)),
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
                errorWidget: (context, url, error) => const Icon(
                  Icons.error,
                  color: Color(0xff09426d),
                ),
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
