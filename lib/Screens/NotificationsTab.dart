import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_service_planner/CustomWidgets/NotifBottomModal.dart';
import 'package:multi_service_planner/Response/NotificationModal.dart';
import 'package:multi_service_planner/constants.dart';
import 'package:multi_service_planner/modals/UserProvider.dart';
import 'package:provider/provider.dart';

import '../CustomWidgets/Headings.dart';
import '../Enums/Colors.dart';
import '../Providers/CacheManager.dart';
import 'MyProfile.dart';

class NotificationsTab extends StatefulWidget {
  const NotificationsTab({Key? key}) : super(key: key);

  @override
  State<NotificationsTab> createState() => _NotificationsTabState();
}

class _NotificationsTabState extends State<NotificationsTab> {
  double _top = 0;

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,

      endDrawer: Drawer(
        elevation: 10,
        shadowColor: Colors.black.withOpacity(0.5),
        child: const MyProfile(),
      ),

      // appBar: const PreferredSize(
      //   preferredSize: Size.fromHeight(kToolbarHeight*2),
      //   child: CustomAppBar(),
      // ),

      body: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(Duration(seconds: 2));
        },
        color: const Color(0xff09426d),
        backgroundColor: Colors.white,
        child: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 15, bottom: 15),
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15, bottom: 15, right: 15),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Notifications",
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.8),
                            fontSize: 22,
                            fontFamily: "",
                            fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        "Mark all as read",
                        style: TextStyle(
                            color: Color(0xff09426d),
                            fontSize: 11,
                            fontFamily: "",
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),

                ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: userProvider.notifications?.length ?? 0,
                  itemBuilder: (context, index) {
                    return newNotifCon(
                        context,
                        "https://images.pexels.com/photos/2114703/pexels-photo-2114703.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                        "Deposit your order amount in any of the following Bank Accounts.",
                        DateTime.now().toString(),
                        "khan",
                        "Events World",
                        userProvider.notifications?[index]);
                  },
                ),

                // Headings(context, "Earlier"),
                //
                // ListView(
                //   shrinkWrap: true,
                //   scrollDirection: Axis.vertical,
                //   physics: const NeverScrollableScrollPhysics(),
                //
                //   children: [
                //     oldNotifCon(context, "https://e0.pxfuel.com/wallpapers/37/903/desktop-wallpaper-always-on-display-thumbnail.jpg",
                //         "Good 5k with friends. Whole crew hit our sub-20 min goal, but that before and after photo shows we had to push!",
                //         "1h"),
                //
                //     oldNotifCon(context, "https://images.pexels.com/photos/2114703/pexels-photo-2114703.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                //         "Good 5k with friends. Whole crew hit our sub-20 min goal, but that before and after photo shows we had to push!",
                //         "3h"),
                //
                //     oldNotifCon(context, "https://images.pexels.com/photos/1004014/pexels-photo-1004014.jpeg?cs=srgb&dl=pexels-min-an-1004014.jpg&fm=jpg",
                //         "Good 5k with friends. Whole crew hit our sub-20 min goal, but that before and after photo shows we had to push!",
                //         "5h"),
                //
                //     oldNotifCon(context, "https://st3.depositphotos.com/1039187/17860/i/600/depositphotos_178608154-stock-photo-couple-in-love.jpg",
                //         "Good 5k with friends. Whole crew hit our sub-20 min goal, but that before and after photo shows we had to push!",
                //         "9h"),
                //
                //     oldNotifCon(context, "https://e0.pxfuel.com/wallpapers/37/903/desktop-wallpaper-always-on-display-thumbnail.jpg",
                //         "Good 5k with friends. Whole crew hit our sub-20 min goal, but that before and after photo shows we had to push!",
                //         "1h"),
                //
                //     oldNotifCon(context, "https://images.pexels.com/photos/2114703/pexels-photo-2114703.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                //         "Good 5k with friends. Whole crew hit our sub-20 min goal, but that before and after photo shows we had to push!",
                //         "3h"),
                //
                //     oldNotifCon(context, "https://images.pexels.com/photos/1004014/pexels-photo-1004014.jpeg?cs=srgb&dl=pexels-min-an-1004014.jpg&fm=jpg",
                //         "Good 5k with friends. Whole crew hit our sub-20 min goal, but that before and after photo shows we had to push!",
                //         "5h"),
                //
                //     oldNotifCon(context, "https://st3.depositphotos.com/1039187/17860/i/600/depositphotos_178608154-stock-photo-couple-in-love.jpg",
                //         "Good 5k with friends. Whole crew hit our sub-20 min goal, but that before and after photo shows we had to push!",
                //         "9h"),
                //   ],
                // ),
              ],
            )),
      ),
    );
  }

  Widget newNotifCon(BuildContext context, String image, String content,
      String time, String name, String title, NotificationModal? data) {
    final cacheManager =
        Provider.of<CacheManagerProvider>(context).cacheManager;

    return InkWell(
      onTap: () {
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            builder: (BuildContext context) {
              return NotifBottomModal(
                image: image,
                content: content,
              );
            });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 5),
        padding:
            const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
        decoration: const BoxDecoration(color: Color(0xfff9f9f9)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Image Container
            Container(
              width: 60,
              height: 60,
              margin: const EdgeInsets.only(right: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.white,
                // image: DecorationImage(
                //     image: NetworkImage(image),
                //     fit: BoxFit.cover
                // )
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Icon(
                  CupertinoIcons.bell_fill,
                  color: primaryColor,
                  size: MediaQuery.sizeOf(context).height * 0.035,
                ),
              ),
            ),

            //Text Container
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    time,
                    style: const TextStyle(
                      color: Color(0xff09426d),
                      fontSize: 10,
                    ),
                  ),

                  const SizedBox(
                    height: 5,
                  ),

                  RichText(
                      text: TextSpan(children: <TextSpan>[
                    TextSpan(
                      text:
                          "Great news! Your booking of ${data?.date} has been confirmed .",
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.7), fontSize: 11),
                    ),
                    //
                    // TextSpan(
                    //   text: "@$name",
                    //   style: const TextStyle(color: Color(0xff09426d),fontWeight: FontWeight.normal,fontSize: 11)
                    // ),
                  ])),

                  const SizedBox(
                    height: 5,
                  ),

                  Text(title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.8),
                          fontWeight: FontWeight.normal,
                          fontFamily: "",
                          fontSize: 16)),

                  const SizedBox(
                    height: 5,
                  ),

                  Text(
                    content,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.7),
                      fontWeight: FontWeight.normal,
                      fontStyle: FontStyle.italic,
                      fontSize: 11,
                    ),
                  ),

                  //const SizedBox(height: 5,),

                  // Text("Digital Marketing Event",
                  //     style: TextStyle(color: Colors.black.withOpacity(0.7),fontWeight: FontWeight.bold,fontSize: 13))
                ],
              ),
            ),

            const SizedBox(
              width: 5,
            ),

            //More Icon
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.more_horiz,
                  color: Colors.black.withOpacity(0.8),
                  size: 25,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget oldNotifCon(BuildContext context, String image, String content,
      String time, String name, String title) {
    final cacheManager =
        Provider.of<CacheManagerProvider>(context).cacheManager;

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(color: Color(0xffffffff)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Image Container
          Container(
            width: 60,
            height: 60,
            margin: const EdgeInsets.only(right: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.white,
              // image: DecorationImage(
              //     image: NetworkImage(image),
              //     fit: BoxFit.cover
              // )
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
                    value: 2,
                    strokeWidth: 1,
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(
                  Icons.error,
                  color: Color(0xff09426d),
                ),
              ),
            ),
          ),

          //Text Container
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  time,
                  style: const TextStyle(
                    color: Color(0xff09426d),
                    fontSize: 10,
                  ),
                ),

                const SizedBox(
                  height: 5,
                ),

                RichText(
                    text: TextSpan(children: <TextSpan>[
                  TextSpan(
                    text: "Great news! A new event has been added by ",
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.7), fontSize: 11),
                  ),
                  TextSpan(
                      text: "@$name",
                      style: const TextStyle(
                          color: Color(0xff09426d),
                          fontWeight: FontWeight.normal,
                          fontSize: 11)),
                ])),

                const SizedBox(
                  height: 5,
                ),

                Text(title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.8),
                        fontWeight: FontWeight.normal,
                        fontFamily: "",
                        fontSize: 16)),

                const SizedBox(
                  height: 5,
                ),

                Text(
                  content,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.7),
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.italic,
                    fontSize: 11,
                  ),
                ),

                //const SizedBox(height: 5,),

                // Text("Digital Marketing Event",
                //     style: TextStyle(color: Colors.black.withOpacity(0.7),fontWeight: FontWeight.bold,fontSize: 13))
              ],
            ),
          ),

          const SizedBox(
            width: 5,
          ),

          //More Icon
          InkWell(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  builder: (BuildContext context) {
                    return NotifBottomModal(
                      image: image,
                      content: content,
                    );
                  });
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.more_horiz,
                  color: Colors.black.withOpacity(0.8),
                  size: 25,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
