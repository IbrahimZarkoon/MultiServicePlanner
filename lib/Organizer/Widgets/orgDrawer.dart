import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_service_planner/modals/OrgProvider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../CustomWidgets/Headings.dart';
import '../../Enums/Colors.dart';
import '../../Providers/CacheManager.dart';
import '../../Screens/OrganizeEvent.dart';
import '../OrgScreens/EditOrgProfile.dart';
import '../OrgScreens/OrgEvents.dart';
import '../OrganizerLogin.dart';

Widget orgDrawer(BuildContext context) {
  final cacheManager = Provider.of<CacheManagerProvider>(context).cacheManager;

  return Container(
    color: Color(0xfff9f9f9),
    margin: EdgeInsets.only(left: kToolbarHeight),
    width: MediaQuery.of(context).size.width,
    child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        //Top Container
        Container(
          padding:
              const EdgeInsets.only(left: 15, right: 15, bottom: 30, top: 15),
          color: appPrimary,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      //Profile Image
                      Container(
                        margin: const EdgeInsets.only(right: 15),
                        width: 65,
                        height: 65,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: CachedNetworkImage(
                            imageUrl:
                                "https://www.sainly.com/cdn/shop/products/MenSuitsOnionPink3PieceSlimFitSuitElegantFormalFashionSuitsSainly-2023-04-19T133324.316_800x.png?v=1681891795",
                            cacheManager: cacheManager,
                            fit: BoxFit.scaleDown,
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(
                                color: appPrimary,
                                value: 5,
                              ),
                            ),
                            errorWidget: (context, url, error) => const Icon(
                              Icons.error,
                              color: appPrimary,
                            ),
                          ),
                        ),
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text(
                                '${Provider.of<OrgProvider>(context, listen: true).ee}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Helvetica_Bold"),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.verified,
                                color: Colors.white,
                                size: 15,
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${Provider.of<OrgProvider>(context, listen: true).serviceID == "1" ? "Photographer Provider" : Provider.of<OrgProvider>(context, listen: true).serviceID == "2" ? "Decor Provider" : Provider.of<OrgProvider>(context, listen: true).serviceID == "3" ? "Venue Provider" : "Cater Provider"}',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                fontFamily: ""),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: const Color(0xffffffff),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.white, width: 2)),
                      child: const Icon(
                        Icons.notifications_none_outlined,
                        color: appPrimary,
                        size: 22,
                      )),
                ],
              ),
            ],
          ),
        ),

        //Drawer Items
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xfff9f9f9),

              ///borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10)),
              // boxShadow: [
              //   BoxShadow(
              //       color: Colors.black.withOpacity(0.15),
              //       blurRadius: 1.5,
              //       spreadRadius: 1,
              //       offset: Offset(0,0)
              //   )
              // ]
            ),
            //margin: EdgeInsets.only(left: kToolbarHeight),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(top: 15),
              scrollDirection: Axis.vertical,
              //controller: profileScrollController,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  firstHeading(context, "Events"),

                  InkWell(
                      onTap: () => Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (BuildContext context) =>
                                  const OrganizeEvent())),
                      child: profileCon(
                          context, "Organize a new event", Icons.event)),

                  InkWell(
                      onTap: () => Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (BuildContext context) =>
                                  const OrgVenues())),
                      child: profileCon(context, "My events",
                          Icons.manage_accounts_outlined)),

                  InkWell(
                      onTap: () => Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (BuildContext context) =>
                                  const EditOrgProfile())),
                      child: profileCon(
                          context, "Edit profile", Icons.person_outline)),

                  InkWell(
                      onTap: () {
                        Share.share("Share Profile ");
                      },
                      child: profileCon(
                          context, "Share profile", CupertinoIcons.share)),

                  //profileCon(context, "Manage events", Icons.manage_accounts_outlined),
                  //profileCon(context, "Availability", Icons.event_available),

                  InkWell(
                      onTap: () {
                        Share.share("Invite Friends");
                      },
                      child:
                          profileCon(context, "Invite friends", Icons.share)),

                  Headings(context, "Settings"),

                  profileCon(context, "Support", Icons.support_outlined),
                  profileCon(context, "Community and legal",
                      Icons.indeterminate_check_box_outlined),

                  Headings(context, "About"),

                  profileCon(context, "Terms of service", Icons.book_outlined),
                  profileCon(context, "Cookie policy", Icons.cookie_outlined),
                ],
              ),
            ),
          ),
        ),

        //Logout
        InkWell(
          onTap: () => Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (BuildContext context) => const OrganizerLogin())),
          child: Container(
            margin: const EdgeInsets.all(15),
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            decoration: BoxDecoration(
                color: appPrimary,
                // boxShadow: [
                //   BoxShadow(
                //       color: Colors.black.withOpacity(0.15),
                //       blurRadius: 1.5,
                //       spreadRadius: 1,
                //       offset: const Offset(0, 0))
                // ],
                borderRadius: BorderRadius.circular(5)),
            alignment: Alignment.center,
            child: const Text(
              "Logout",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            ),
          ),
        ),

        //Version
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(children: [
                  TextSpan(
                      text: "Version ",
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.8),
                          fontWeight: FontWeight.normal,
                          fontSize: 11)),
                  TextSpan(
                      text: "1.0.0 (15003)",
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                          fontWeight: FontWeight.normal,
                          fontSize: 11)),
                ]))
          ],
        ),

        const SizedBox(
          height: 15,
        ),
      ],
    ),
  );
}

Widget profileCon(BuildContext context, String title, IconData icon) {
  return Container(
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
            bottom:
                BorderSide(color: Colors.black.withOpacity(0.2), width: 0.5))),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 20,
          color: Colors.black.withOpacity(0.6),
        ),
        const SizedBox(
          width: 15,
        ),
        Text(
          title,
          style: TextStyle(
              color: Colors.black.withOpacity(0.8),
              fontSize: 14,
              fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        Icon(
          Icons.arrow_forward_ios_outlined,
          size: 20,
          color: Colors.black.withOpacity(0.4),
        )
      ],
    ),
  );
}
