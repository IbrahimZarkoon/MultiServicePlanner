// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_cache_manager/flutter_cache_manager.dart';
// import 'package:percent_indicator/circular_percent_indicator.dart';
// import 'package:provider/provider.dart';
//
// import '../../Enums/Colors.dart';
// import '../../Providers/CacheManager.dart';
// import '../OrgScreens/OrgSingleEvent.dart';
//
// Widget pastEventSlider(BuildContext context)
// {
//   final double height = MediaQuery.of(context).size.height;
//   final double width = MediaQuery.of(context).size.width;
//
//   return Container(
//     margin: EdgeInsets.only(bottom: 15),
//     height: height*0.3,
//     child: ListView(
//       padding: const EdgeInsets.only(top: 2,bottom: 2),
//       scrollDirection: Axis.horizontal,
//       physics: const BouncingScrollPhysics(),
//       shrinkWrap: true,
//
//       children: [
//
//        eventCon(context),
//         eventCon(context),
//         eventCon(context),
//
//         const SizedBox(width: 15,),
//
//
//       ],
//     ),
//   );
// }
//
// Widget eventCon(BuildContext context)
// {
//   final double height = MediaQuery.of(context).size.height;
//   final double width = MediaQuery.of(context).size.width;
//   return InkWell(
//     onTap: () => showModalBottomSheet(
//         isScrollControlled: true,
//         context: context, builder: (BuildContext context) => OrgSingleEvent(title: "Camping Night", image: "https://img.freepik.com/free-photo/young-happy-sportswoman-running-road-morning-copy-space_637285-3758.jpg?w=2000&t=st=1690361531~exp=1690362131~hmac=a044928629265a01e5a6d0a4e12b4c5e81eacae35871ce9fb61eb072c90a0887",
//     past: true,)),
//     child: Container(
//       margin: const EdgeInsets.only(left: 15),
//       width: width*0.8,
//       decoration: BoxDecoration(
//
//           image: const DecorationImage(
//               image: NetworkImage(
//                   "https://img.freepik.com/free-photo/young-happy-sportswoman-running-road-morning-copy-space_637285-3758.jpg?w=2000&t=st=1690361531~exp=1690362131~hmac=a044928629265a01e5a6d0a4e12b4c5e81eacae35871ce9fb61eb072c90a0887"
//               ),
//               fit: BoxFit.cover
//           ),
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(10),
//
//           boxShadow: [
//             BoxShadow(
//                 color: Colors.black.withOpacity(0.15),
//                 blurRadius: 1.5,
//                 spreadRadius: 1,
//                 offset: const Offset(0,0)
//             )
//           ]
//       ),
//
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//
//           Container(
//             padding: const EdgeInsets.all(15),
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 color: Colors.black.withOpacity(0.5)
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//
//               children: [
//
//
//
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//
//                     //Text Column
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//
//                       children: [
//
//                         const Text("Camping Night",
//                           style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
//
//
//                         const SizedBox(height: 5,),
//
//                         const Text("Gunung Pancar, Bogar",
//                           style: TextStyle(color: Colors.white,fontFamily: "",fontWeight: FontWeight.normal,fontSize: 14),),
//
//                         const SizedBox(height: 2,),
//
//                         const Text("Apr 5th, 2023",
//                           style: TextStyle(color: Colors.white,fontFamily: "",fontWeight: FontWeight.normal,fontSize: 12),),
//
//                       ],
//                     ),
//
//                     const SizedBox(width: 10,),
//
//                     Container(
//                       alignment: Alignment.center,
//                       padding: const EdgeInsets.only(top: 5,bottom: 5,left: 20,right: 20),
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.white,width: 1),
//                         borderRadius: BorderRadius.circular(20)
//                       ),
//                       child: const Text("view",
//                       style: TextStyle(color: Colors.white,fontSize: 12),),
//                     )
//                   ],
//                 ),
//
//                 // Column(
//                 //   mainAxisSize: MainAxisSize.min,
//                 //   mainAxisAlignment: MainAxisAlignment.start,
//                 //   crossAxisAlignment: CrossAxisAlignment.center,
//                 //   children: [
//                 //     CircularPercentIndicator(
//                 //       radius: 30,
//                 //       backgroundWidth: 3,
//                 //       lineWidth: 3,
//                 //       percent: 1,
//                 //       progressColor: const Color(0xff95d74f),
//                 //       backgroundColor: const Color(0xffededed),
//                 //       center: const Text("100%",
//                 //         style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 12),),
//                 //       circularStrokeCap: CircularStrokeCap.round,
//                 //     ),
//                 //
//                 //     const SizedBox(height: 5,),
//                 //
//                 //     const Text("Event completion",
//                 //       style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold,color: Colors.black),
//                 //       textAlign: TextAlign.center,
//                 //       overflow: TextOverflow.ellipsis,
//                 //       maxLines: 2,
//                 //     )
//                 //   ],
//                 // ),
//
//               ],
//             ),
//           )
//
//         ],
//       ),
//     ),
//   );
// }
//
// Widget OLDeventCon(BuildContext context)
// {
//   final cacheManager = Provider.of<CacheManagerProvider>(context).cacheManager;
//
//
//   final double height = MediaQuery.of(context).size.height;
//   final double width = MediaQuery.of(context).size.width;
//   return Stack(
//     children: [
//     Container(
//         margin: const EdgeInsets.only(left: 15),
//         width: width * 0.8,
//         decoration: BoxDecoration(
//             // image: DecorationImage(
//             //     image: NetworkImage(
//             //         "https://img.freepik.com/free-photo/glowing-stage-light-illuminates-cheering-rock-fans-generated-by-ai_188544-37983.jpg?w=2000&t=st=1690205809~exp=1690206409~hmac=78ed12e60ac7ff7964ac9445e855a5dc271f9b97693f612d10063f0a5717e8a1"),
//             //     fit: BoxFit.cover),
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(10),
//             boxShadow: [
//               BoxShadow(
//                   color: Colors.black.withOpacity(0.15),
//                   blurRadius: 1.5,
//                   spreadRadius: 1,
//                   offset: const Offset(0, 0))
//             ]),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(10),
//           child: CachedNetworkImage(
//             imageUrl: "https://img.freepik.com/free-photo/glowing-stage-light-illuminates-cheering-rock-fans-generated-by-ai_188544-37983.jpg?w=2000&t=st=1690205809~exp=1690206409~hmac=78ed12e60ac7ff7964ac9445e855a5dc271f9b97693f612d10063f0a5717e8a1",
//             cacheManager: cacheManager,
//             fit: BoxFit.cover,
//             placeholder: (context, url) => const Center(
//               child: CircularProgressIndicator(
//                 color: Color(0xffff1f6f),
//                 value: 5,
//               ),
//             ),
//             errorWidget: (context, url, error) => const Icon(Icons.error,color: Color(0xffff1f6f),),
//           ),
//         ),),
//
//       Positioned(
//         left: 15,bottom: 15,
//         child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//
//           Container(
//             decoration: const BoxDecoration(
//               borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
//               color: Colors.white,
//
//             ),
//             padding: const EdgeInsets.only(left: 15,right: 15,bottom: 15,top: 15),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text("Clinic Health Event for Patients",
//                   maxLines: 1,overflow: TextOverflow.ellipsis,style:
//                   TextStyle(
//                       color: Colors.black.withOpacity(0.8),fontWeight: FontWeight.bold,fontSize: 16
//                   ),),
//
//                 const SizedBox(height: 5,),
//
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//
//                   children: [
//
//                     RichText(
//                         maxLines: 1,overflow: TextOverflow.ellipsis,
//                         text: TextSpan(
//
//                             children: [
//
//                               TextSpan(
//                                 text: "Private",style: TextStyle(
//                                   color: Colors.black.withOpacity(0.6),fontWeight: FontWeight.normal,fontSize: 14
//                               ),
//                               ),
//
//                               TextSpan(text: " • ",style: TextStyle(
//                                   color: Colors.black.withOpacity(0.4),fontWeight: FontWeight.bold,fontSize: 14
//                               ),)
//                             ]
//                         )),
//
//                     // Text("Private • ",
//                     //   maxLines: 1,overflow: TextOverflow.ellipsis,style:
//                     //   TextStyle(
//                     //       color: Colors.black.withOpacity(0.6),fontWeight: FontWeight.normal,fontSize: 14
//                     //   ),),
//
//                     const Text("3 days left",
//                       maxLines: 1,overflow: TextOverflow.ellipsis,style:
//                       TextStyle(
//                           color: Color(0xffff1f6f),fontWeight: FontWeight.normal,fontSize: 14
//                       ),),
//
//
//
//                   ],
//                 ),
//               ],
//             ),
//           ),
//
//           const Spacer(),
//
//           Container(
//             margin: const EdgeInsets.only(left: 5,right: 5,bottom: 5),
//             padding: const EdgeInsets.only(bottom: 10,top: 10,left: 10,right: 10),
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 color: Colors.white.withOpacity(1)
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.end,
//
//               children: [
//
//                 Container(
//                   width: MediaQuery.of(context).size.width * 0.35,
//                   height: 35,
//                   child: Stack(
//                     children: List.generate(
//                       5,
//                           (index) {
//                         return index == 4
//                             ? Positioned(
//                             left: index * 20.0,
//                             child: Container(
//                               width: 35,
//                               height: 35,
//                               decoration: BoxDecoration(
//                                 color: Colors.black,
//                                 image: const DecorationImage(
//                                     image: NetworkImage(
//                                         "https://lh3.googleusercontent.com/a6KTL7w4zgqo4fu_1sOqlrHGwe6QXzM4GriPxaXvcfNST0UshxYlcTa7ASQt0ErzGPOzkefLNfsQ23n6O_nXqA68iqivwF7tCEQpiPS5bekMWQ=s100"),
//                                     fit: BoxFit.cover,
//                                     opacity: 0.4
//                                 ),
//                                 border: Border.all(
//                                     color: Colors.white,
//                                     width: 1),
//
//                                 borderRadius:
//                                 BorderRadius.circular(50),
//                               ),
//                               alignment: Alignment.center,
//                               child: const Text(
//                                 "+3",
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 11,
//                                     fontWeight: FontWeight.bold,
//                                     fontFamily:
//                                     ""),
//                               ),
//                             ))
//                             : Positioned(
//                           left: index * 20.0,
//                           child: Container(
//                             width: 35,
//                             height: 35,
//                             decoration: BoxDecoration(
//                               border: Border.all(
//                                   color: Colors.white,
//                                   width: 1),
//                               color: Colors.white,
//                               borderRadius:
//                               BorderRadius.circular(50),
//                               image: const DecorationImage(
//                                 image: NetworkImage(
//                                     "https://lh3.googleusercontent.com/a6KTL7w4zgqo4fu_1sOqlrHGwe6QXzM4GriPxaXvcfNST0UshxYlcTa7ASQt0ErzGPOzkefLNfsQ23n6O_nXqA68iqivwF7tCEQpiPS5bekMWQ=s100"),
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//
//                     //Text Column
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//
//                       children: [
//
//                         Text("78%",
//                           style: TextStyle(color: Colors.black.withOpacity(0.8),fontFamily: "Helvetica_Bold",fontWeight: FontWeight.bold,fontSize: 18),),
//
//                         const SizedBox(height: 2,),
//
//                         Text("Progress",
//                           style: TextStyle(color: Colors.black.withOpacity(0.6),fontWeight: FontWeight.normal,fontSize: 13),),
//
//                       ],
//                     ),
//
//                     const SizedBox(width: 10,),
//
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         CircularPercentIndicator(
//                           radius: 20,
//                           backgroundWidth: 4,
//                           lineWidth: 4,
//                           percent: .78,
//                           progressColor: const Color(0xff73e019),
//                           backgroundColor: const Color(0xffededed),
//                           // center: const Text("78%",
//                           //   style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 12),),
//                           circularStrokeCap: CircularStrokeCap.round,
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//
//                 // Column(
//                 //   mainAxisSize: MainAxisSize.min,
//                 //   mainAxisAlignment: MainAxisAlignment.start,
//                 //   crossAxisAlignment: CrossAxisAlignment.center,
//                 //   children: [
//                 //     CircularPercentIndicator(
//                 //       radius: 30,
//                 //       backgroundWidth: 3,
//                 //       lineWidth: 3,
//                 //       percent: 1,
//                 //       progressColor: const Color(0xff95d74f),
//                 //       backgroundColor: const Color(0xffededed),
//                 //       center: const Text("100%",
//                 //         style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 12),),
//                 //       circularStrokeCap: CircularStrokeCap.round,
//                 //     ),
//                 //
//                 //     const SizedBox(height: 5,),
//                 //
//                 //     const Text("Event completion",
//                 //       style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold,color: Colors.black),
//                 //       textAlign: TextAlign.center,
//                 //       overflow: TextOverflow.ellipsis,
//                 //       maxLines: 2,
//                 //     )
//                 //   ],
//                 // ),
//
//               ],
//             ),
//           )
//
//         ],
//       ),)
//   ]
//   );
// }
//
// Widget bottomEventsSlider(BuildContext context)
// {
//   final double height = MediaQuery.of(context).size.height;
//   final double width = MediaQuery.of(context).size.width;
//
//   return Column(
//     children: [
//
//       bottomEventCon(context),
//       bottomEventCon(context),
//       bottomEventCon(context),
//
//
//       const SizedBox(width: 15,),
//
//
//     ],
//   );
// }
//
// Widget bottomEventCon(BuildContext context)
// {
//   final cacheManager = Provider.of<CacheManagerProvider>(context).cacheManager;
//
//
//   final double height = MediaQuery.of(context).size.height;
//   final double width = MediaQuery.of(context).size.width;
//   return InkWell(
//     onTap: () => showModalBottomSheet(
//         isScrollControlled: true,
//         context: context, builder: (BuildContext context) => OrgSingleEvent(title: "How to be Announcer", image: "https://img.freepik.com/free-photo/lifestyle-people-living-camping_23-2149733140.jpg?w=1060&t=st=1690361989~exp=1690362589~hmac=30aa77628a0cd37e4227dfa67c2f27434cf732eccb18c9b46523007ae4145694",
//     past: true,)),
//     child: Container(
//       padding: const EdgeInsets.all(10),
//       margin: const EdgeInsets.only(left: 15,right: 15,bottom: 15),
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.2),
//             offset: const Offset(0,0),
//             blurRadius: 1.5
//           )
//         ]
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//
//           //image Con
//           Container(
//             margin: const EdgeInsets.only(right: 10),
//             height: 90,width: 90,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(20),
//               // image: DecorationImage(
//               //   fit: BoxFit.cover,
//               //   image: NetworkImage("")
//               // )
//             ),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(20),
//               child: CachedNetworkImage(
//                 imageUrl: "https://img.freepik.com/free-photo/lifestyle-people-living-camping_23-2149733140.jpg?w=1060&t=st=1690361989~exp=1690362589~hmac=30aa77628a0cd37e4227dfa67c2f27434cf732eccb18c9b46523007ae4145694",
//                 cacheManager: cacheManager,
//                 fit: BoxFit.cover,
//                 placeholder: (context, url) => const Center(
//                   child: CircularProgressIndicator(
//                     color: appPrimary,
//                     value: 5,
//                   ),
//                 ),
//                 errorWidget: (context, url, error) => const Icon(Icons.error,color: appPrimary,),
//               ),
//             ),
//           ),
//
//           //Text Column
//           Flexible(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//
//               children: [
//
//                 const SizedBox(height: 5,),
//
//                 Text("How to be Announcer",
//                   style: TextStyle(color: Colors.black.withOpacity(0.8),fontWeight: FontWeight.bold,fontSize: 16),),
//
//
//                 const SizedBox(height: 5,),
//
//                 Text("Gunung Pancar, Bogar",
//                   style: TextStyle(color: Colors.black.withOpacity(0.6),fontFamily: "",fontWeight: FontWeight.normal,fontSize: 12),),
//
//                 const SizedBox(height: 2,),
//
//                 const Text("Apr 5th, 2023",
//                   style: TextStyle(color: appPrimary,fontFamily: "",fontWeight: FontWeight.normal,fontSize: 12),),
//
//
//                 Container(
//                   margin: const EdgeInsets.only(top: 5),
//                   width: MediaQuery.of(context).size.width * 0.35,
//                   height: 35,
//                   child: Stack(
//                     children: List.generate(
//                       3,
//                           (index) {
//                         return index == 2
//                             ? Positioned(
//                             left: index * 20.0,
//                             child: Container(
//                               width: 25,
//                               height: 25,
//                               decoration: BoxDecoration(
//                                 color: Colors.black,
//                                 image: const DecorationImage(
//                                     image: NetworkImage(
//                                         "https://lh3.googleusercontent.com/a6KTL7w4zgqo4fu_1sOqlrHGwe6QXzM4GriPxaXvcfNST0UshxYlcTa7ASQt0ErzGPOzkefLNfsQ23n6O_nXqA68iqivwF7tCEQpiPS5bekMWQ=s100"),
//                                     fit: BoxFit.cover,
//                                     opacity: 0.4
//                                 ),
//                                 border: Border.all(
//                                     color: Colors.white,
//                                     width: 1),
//
//                                 borderRadius:
//                                 BorderRadius.circular(50),
//                               ),
//                               alignment: Alignment.center,
//                               child: const Text(
//                                 "+3",
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 11,
//                                     fontWeight: FontWeight.bold,
//                                     fontFamily:
//                                     ""),
//                               ),
//                             ))
//                             : Positioned(
//                           left: index * 20.0,
//                           child: Container(
//                             width: 25,
//                             height: 25,
//                             decoration: BoxDecoration(
//                               border: Border.all(
//                                   color: Colors.white,
//                                   width: 1),
//                               color: Colors.white,
//                               borderRadius:
//                               BorderRadius.circular(50),
//                               image: const DecorationImage(
//                                 image: NetworkImage(
//                                     "https://lh3.googleusercontent.com/a6KTL7w4zgqo4fu_1sOqlrHGwe6QXzM4GriPxaXvcfNST0UshxYlcTa7ASQt0ErzGPOzkefLNfsQ23n6O_nXqA68iqivwF7tCEQpiPS5bekMWQ=s100"),
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           const SizedBox(width: 10,),
//
//           Container(
//             alignment: Alignment.center,
//             padding: const EdgeInsets.all(3),
//             decoration: BoxDecoration(
//                 color: appPrimary,
//                 borderRadius: BorderRadius.circular(20)
//             ),
//             child: const Icon(Icons.keyboard_arrow_right,color: Colors.white,size: 20,)
//           )
//         ],
//       ),
//     ),
//   );
// }
