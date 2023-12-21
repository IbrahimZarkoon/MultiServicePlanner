import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_service_planner/modals/UserProvider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../CustomWidgets/Headings.dart';
import '../../Organizer/OrgScreens/EditOrgProfile.dart';
import '../../Organizer/OrgScreens/OrgEvents.dart';
import '../../Organizer/OrganizerLogin.dart';
import '../../Providers/CacheManager.dart';
import '../EditProfile.dart';
import '../Login.dart';
import '../OrganizeEvent.dart';
import 'EditPreferences.dart';

Widget userDrawer(BuildContext context) {
  final cacheManager = Provider.of<CacheManagerProvider>(context).cacheManager;

  return Container(
    color: const Color(0xfffafafa),
    //color: Color(0xfff1f1f1),
    //margin: EdgeInsets.only(left: kToolbarHeight),
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        //Top Container
        Container(
          padding:
              const EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 15),
          color: const Color(0xff09426d),
          child: Row(
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
                            color: Color(0xff09426d),
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

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            Provider.of<UserProvider>(context, listen: false)
                                .email,
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
                      const Text(
                        "",
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
              InkWell(
                onTap: () => Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (BuildContext context) =>
                            const EditProfile())),
                child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: const Color(0xffffffff),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.white, width: 2)),
                    child: const Icon(
                      Icons.edit_outlined,
                      color: Color(0xff09426d),
                      size: 20,
                    )),
              ),
            ],
          ),
        ),

        Expanded(
          child: Container(
            decoration: BoxDecoration(
                color: const Color(0xfffafafa),

                ///borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 1.5,
                      spreadRadius: 0,
                      offset: const Offset(0, -3))
                ]),
            //margin: EdgeInsets.only(left: kToolbarHeight),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(top: 15),
              scrollDirection: Axis.vertical,
              //controller: profileScrollController,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  firstHeading(context, "My Profile"),

                  InkWell(
                      onTap: () => Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (BuildContext context) =>
                                  const EditPreferences())),
                      child: profileCon(context, "Edit Preferences",
                          Icons.room_preferences_outlined)),

                  // InkWell(
                  //     onTap: () {
                  //       showDialog(
                  //           barrierColor: Colors.black54,
                  //           context: context, builder: (_)
                  //       {
                  //         return Center(
                  //
                  //           child: Container(
                  //             padding: const EdgeInsets.all(15),
                  //             decoration: BoxDecoration(
                  //                 color: Colors.white,
                  //               borderRadius: BorderRadius.circular(5)
                  //             ),
                  //             width: MediaQuery.of(context).size.width,
                  //             margin: const EdgeInsets.only(left: 15,right: 15),
                  //             child: Material(
                  //               child: Container(
                  //                 color: Colors.white,
                  //                 child: Column(
                  //                   mainAxisSize: MainAxisSize.min,
                  //                   mainAxisAlignment: MainAxisAlignment.start,
                  //
                  //                   children: [
                  //
                  //                     InkWell(
                  //                       onTap: () => Navigator.pop(context),
                  //                       child: Row(
                  //                         mainAxisAlignment: MainAxisAlignment.end,
                  //
                  //                         children: [
                  //
                  //                           Icon(Icons.close,color: Colors.black.withOpacity(0.8),size: 20,)
                  //
                  //                         ],
                  //
                  //                       ),
                  //                     ),
                  //
                  //                     const SizedBox(height: 0,),
                  //
                  //                     Row(
                  //                       mainAxisAlignment: MainAxisAlignment.center,
                  //
                  //                       children: [
                  //
                  //                         Container(
                  //                           height: 250,
                  //                           width: 250,
                  //                           decoration: const BoxDecoration(
                  //                             image: DecorationImage(
                  //                               image: NetworkImage(
                  //                                 "https://img.freepik.com/free-vector/user-verification-unauthorized-access-prevention-private-account-authentication-cyber-security-people-entering-login-password-safety-measures_335657-8.jpg?w=1480&t=st=1692264507~exp=1692265107~hmac=57a22d9d2d291020b7e389ea99de7e4ca9a09b095c77785604ad2f6982363ee9"
                  //                               ),
                  //                               fit: BoxFit.contain
                  //                             )
                  //                           ),
                  //                         ),
                  //
                  //                       ],
                  //                     ),
                  //
                  //                     Text(
                  //                       maxLines: 2,
                  //                       "Please sign up as an organizer first!",
                  //                       textAlign: TextAlign.center,
                  //                       style: TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 20,fontFamily: "Helvetica_Bold"),
                  //                     ),
                  //
                  //                     InkWell(
                  //                       onTap: () => Navigator.push(
                  //                           context,
                  //                           CupertinoPageRoute(
                  //                               builder: (BuildContext context) =>
                  //                               const OrganizerLogin())),
                  //                       child: Container(
                  //                         margin: const EdgeInsets.only(top: 15,bottom: 0),
                  //                         padding: const EdgeInsets.only(top: 10, bottom: 10),
                  //                         decoration: BoxDecoration(
                  //                             color: const Color(0xff09426d),
                  //                             // boxShadow: [
                  //                             //   BoxShadow(
                  //                             //       color: Colors.black.withOpacity(0.15),
                  //                             //       blurRadius: 1.5,
                  //                             //       spreadRadius: 1,
                  //                             //       offset: const Offset(0, 0))
                  //                             // ],
                  //                             borderRadius: BorderRadius.circular(5)),
                  //                         alignment: Alignment.center,
                  //                         child: const Text(
                  //                           "Continue",
                  //                           style: TextStyle(
                  //                               color: Colors.white,
                  //                               fontWeight: FontWeight.bold,
                  //                               fontSize: 12),
                  //                         ),
                  //                       ),
                  //                     ),
                  //
                  //                   ],
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //         );
                  //       });
                  //     },
                  //     child:
                  //     profileCon(context, "Organize a new event", Icons.event)),

                  InkWell(
                      onTap: () => Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (BuildContext context) =>
                                  const OrgVenues())),
                      child: profileCon(context, "My venues",
                          Icons.manage_accounts_outlined)),

                  // InkWell(
                  //     onTap: () => Navigator.push(
                  //         context,
                  //         CupertinoPageRoute(
                  //             builder: (BuildContext context) =>
                  //             const EditOrgProfile())),
                  //     child:
                  //     profileCon(context, "Edit profile", Icons.person_outline)),

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

        InkWell(
          onTap: () => Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (BuildContext context) => const Login())),
          child: Container(
            margin: const EdgeInsets.all(15),
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            decoration: BoxDecoration(
                color: const Color(0xff09426d),
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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 18,
          color: Colors.black.withOpacity(0.6),
        ),
        const SizedBox(
          width: 15,
        ),
        Text(
          title,
          style: TextStyle(
              color: Colors.black.withOpacity(0.8),
              fontSize: 12,
              fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        Icon(
          Icons.arrow_forward_ios_outlined,
          size: 18,
          color: Colors.black.withOpacity(0.4),
        )
      ],
    ),
  );
}
