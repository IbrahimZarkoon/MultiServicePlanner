import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_service_planner/modals/UserProvider.dart';
import 'package:provider/provider.dart';

import '../Routes/customRoute.dart';
import 'EditProfile.dart';
import 'OrganizeEvent.dart';
import 'ProfileDrawer/EditPreferences.dart';
import 'ProfileDrawer/MyEvents.dart';
import 'SettingsPage.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xffffffff),
          // image: DecorationImage(
          //   image: NetworkImage("https://img.freepik.com/premium-vector/dubai-city-skyscrapers-flat-cartoon-style-illustration-web-background_198565-53.jpg?w=2000"),
          //   fit: BoxFit.cover
          // ),

          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.25),
                offset: const Offset(-20, 0),
                blurRadius: 15,
                spreadRadius: 0)
          ]),
      width: MediaQuery.of(context).size.width * 0.75,
      //height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //Top Container
          Container(
            width: MediaQuery.of(context).size.width,
            //height: MediaQuery.of(context).size.height*0.35,
            padding:
                const EdgeInsets.only(left: 15, right: 15, bottom: 20, top: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),

              //color: Color(0xff009ed9)
            ),
            child: Column(
              children: [
                //Image Container
                Container(
                  width: 100,
                  height: 100,
                  margin: const EdgeInsets.only(bottom: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      image: const DecorationImage(
                          image: NetworkImage(
                              "https://w0.peakpx.com/wallpaper/794/29/HD-wallpaper-best-whatsapp-dp-boy-walking-alone-birds.jpg"),
                          fit: BoxFit.cover),
                      border: Border.all(
                          color: const Color(0xffff1f6f), width: 2.5)),
                ),

                // Positioned(
                //     right: 5,
                //     bottom: 15,
                //     child: InkWell(
                //       onTap: () => Navigator.push(context, customRoute(const EditProfile())),
                //       child: Container(
                //         padding: EdgeInsets.all(5),
                //         decoration: BoxDecoration(
                //             color: Color(0xffff1f6f),
                //             borderRadius: BorderRadius.circular(50)
                //         ),
                //         child: Icon(Icons.edit_outlined,size: 17,color: Colors.white,),
                //       ),
                //     )),

                Column(
                  children: [
                    Text(
                      Provider.of<UserProvider>(context, listen: false).email,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.8),
                          fontFamily: "Helvetica_Bold",
                          fontSize: 17),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () => Navigator.push(
                          context, customRoute(const EditProfile())),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.15),
                                  spreadRadius: 1,
                                  blurRadius: 1.5)
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(0),
                              margin: const EdgeInsets.only(right: 5),
                              child: const Icon(
                                Icons.edit_outlined,
                                size: 15,
                                color: Color(0xffff1f6f),
                              ),
                            ),
                            const Text(
                              "Edit Profile",
                              style: TextStyle(
                                  color: Color(0xffff1f6f),
                                  fontFamily: "",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 20,
          ),

          InkWell(
              onTap: () => Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (BuildContext context) =>
                          const EditPreferences())),
              child: profileCon(context, "Edit Preferences", true)),

          InkWell(
              onTap: () => Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (BuildContext context) => const MyEvents())),
              child: profileCon(context, "My Events", false)),

          InkWell(
              onTap: () => Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (BuildContext context) =>
                          const OrganizeEvent())),
              child: profileCon(context, "Start a new event", false)),

          profileCon(context, "Purchase History", false),

          InkWell(
              onTap: () =>
                  Navigator.push(context, customRoute(const SettingsPage())),
              child: profileCon(context, "Settings", false)),

          InkWell(child: profileCon(context, "Support", false)),

          const Spacer(),

          InkWell(
            onTap: () {
              SystemNavigator.pop();
            },
            child: Container(
              margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: const Color(0xffff1f6f),
                  borderRadius: BorderRadius.circular(7)),
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Transform.rotate(
                      angle: 3.1415,
                      child: const Icon(
                        Icons.login_rounded,
                        color: Colors.white,
                      )),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text(
                    "Logout",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget profileCon(BuildContext context, String txt, bool isFirst) {
    return Container(
      padding: const EdgeInsets.all(15),
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        //border: isFirst? Border() : Border(top: BorderSide(color: Colors.black.withOpacity(0.15),width: 1)),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.15),
              offset: const Offset(0, 0),
              blurRadius: 1.5,
              spreadRadius: 1)
        ],
        color: Colors.white,
      ),
      child: Text(
        txt,
        style: TextStyle(
            fontFamily: "Helvetica_Bold",
            fontSize: 14,
            color: Colors.black.withOpacity(0.5)),
      ),
    );
  }

  Widget interestCon(BuildContext context, String txt) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: const Color(0xFFF1F1F1),
      ),
      child: Text(
        txt,
        style: TextStyle(
          color: Colors.black.withOpacity(0.6),
          fontSize: 12,
          fontFamily: "Helvetica_Bold",
        ),
      ),
    );
  }

  Widget memberCon(
      BuildContext context, String title, String image, String desc) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //Image Con
          Container(
            width: 50,
            height: 50,
            margin: const EdgeInsets.only(right: 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                image: DecorationImage(
                    image: NetworkImage(image), fit: BoxFit.cover)),
          ),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    fontFamily: "Helvetica_Bold",
                    color: Colors.black.withOpacity(0.8),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  desc,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    fontFamily: "",
                    color: Colors.black.withOpacity(0.6),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
