
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../Screens/Dashboard.dart';

Widget serviceProviders(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.3
        ),
        padding: const EdgeInsets.only(top: 0,left: 15,right: 15,bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //1st Column
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //1st Category
                  Expanded(
                      flex: 2,
                      child: Stack(
                        children: [



                          Container(
                            padding: const EdgeInsets.only(
                                top: 10, left: 10, right: 10),
                            margin:
                            const EdgeInsets.only(right: 10, bottom: 0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 1,
                                      spreadRadius: 1,
                                      offset: const Offset(0, 0))
                                ]),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Photographers",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  "Capturing Moments, Creating Memories.",
                                  style: TextStyle(fontSize: 10),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            ),
                          ),

                          Positioned(
                              bottom: 10,
                              left: 10,
                              right: 12,
                              child: Hero(
                                tag: "TC1",
                                child: Container(
                                  width: 75,
                                  constraints: BoxConstraints(
                                    maxHeight: 150
                                  ),
                                  decoration: const BoxDecoration(
                                      color: Colors.transparent,
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              "https://img.freepik.com/free-photo/photographer-his-studio-with-his-arms-crossed_1368-3518.jpg?w=1480&t=st=1694204993~exp=1694205593~hmac=2b9f93fc864b7850a87b6b8ec8b620513eb1ee619ccbe84498b7b5de93a4364e"),
                                          colorFilter: ColorFilter.mode(
                                              Colors.white, BlendMode.dstIn),
                                          fit: BoxFit.scaleDown)),
                                ),
                              )),
                        ],
                      )),

                ],
              ),
            ),

            //2nd Column
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //4th Category
                  Expanded(
                      flex: 2,
                      child: Stack(children: [
                        Container(
                          padding: const EdgeInsets.only(
                              top: 10, left: 10, right: 10),
                          margin: const EdgeInsets.only(right: 10, bottom: 10,left: 2),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 1,
                                  spreadRadius: 1,
                                  offset: const Offset(0, 0))
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Text(
                                "Decors",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                "Transforming Spaces, Elevating Events.",
                                style: TextStyle(fontSize: 10),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                        Positioned(
                            bottom: 17,
                            left: 13,
                            child: Hero(
                              tag: "TC4",
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Container(
                                  constraints: BoxConstraints(
                                    maxHeight: 60,
                                    maxWidth: MediaQuery.sizeOf(context).width/3
                                  ),
                                  decoration: const BoxDecoration(
                                      color: Colors.transparent,
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            "https://img.freepik.com/free-photo/bouquet-red-roses-peonies-green-decorative-flowers-with-leaves_114579-1427.jpg?w=1480&t=st=1694205530~exp=1694206130~hmac=8ad2dfabd8c57836ea1a26bf0a38f68160f1d90e1bfe6e7a86286a4f8aa22583"),
                                        fit: BoxFit.cover,
                                      )),
                                ),
                              ),
                            ))
                      ])),

                  //5th Category
                  Stack(children: [
                    Container(
                      padding: const EdgeInsets.only(
                          top: 10, left: 10, right: 10,bottom: 10),
                      margin: const EdgeInsets.only(right: 10, bottom: 2,top: 2,left: 2),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 1,
                                spreadRadius: 1,
                                offset: const Offset(0, 0))
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            "Catering",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            "Serving Flavor,\nSavoring Moments",
                            style: TextStyle(fontSize: 10),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ),
                    Positioned(
                        top: 10,
                        bottom: 10,
                        right: 15,
                        child: Hero(
                          tag: "TC5",
                          child: Container(
                            width: 55,
                            height: 75,
                            decoration:  BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                                color: Colors.transparent,
                                image: DecorationImage(
                                  image: NetworkImage(
                                      "https://img.freepik.com/free-photo/brunch-choice-crowd-dining-food-options-eating-concept_53876-42807.jpg?w=1480&t=st=1694205897~exp=1694206497~hmac=8e902172b4b882453245921512d653919f3f79319f0af17357d81d5f78cb6c41"),
                                  fit: BoxFit.cover,
                                )),
                          ),
                        ))
                  ]),

                ],
              ),
            )
          ],
        ),
      ),

      InkWell(
        onTap: ()
        {
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => DashboardPage(userTabIndex: 3)));
        },
        child: Stack(
            children: [Shimmer.fromColors(period: Duration(milliseconds: 3000),highlightColor: Color(0xff23a2dc).withOpacity(0.0), baseColor: Color(0xff23a2dc),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(10),
                margin: const EdgeInsets.only(left:15,right: 23, bottom: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: Color(0xff23a2dc).withOpacity(0.75)
                ),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    Text("",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),

                    const SizedBox(height: 5,),

                    Text("",style: TextStyle(color: Colors.white,fontSize: 12
                    ),)

                  ],
                ),
              ),),

              Positioned(
                top: 5,
                  right: 5,left: 5,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(left:15,right: 23, bottom: 10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      //color: Color(0xfffcc817)
                    ),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: [



                        //const SizedBox(height: 5,),

                        Text("Discover a World of Services,\nYour One-Stop Solution",style: TextStyle(color: Colors.white,fontSize: 12
                        ),),

                        Text("View all",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,),),

                      ],
                    ),
                  ))

            ]
        ),
      ),

      // Stack(children: [
      //   Container(
      //     padding:
      //     const EdgeInsets.all(10),
      //     margin: const EdgeInsets.only(left:15,right: 23, bottom: 10),
      //     decoration: BoxDecoration(
      //         color: Colors.white,
      //         borderRadius: BorderRadius.circular(5),
      //         boxShadow: [
      //           BoxShadow(
      //               color: Colors.black.withOpacity(0.1),
      //               blurRadius: 1,
      //               spreadRadius: 1,
      //               offset: const Offset(0, 0))
      //         ]),
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.start,
      //       crossAxisAlignment: CrossAxisAlignment.stretch,
      //       children: [
      //         const Text(
      //           "Furniture",
      //           style: TextStyle(
      //               fontWeight: FontWeight.bold, fontSize: 18),
      //         ),
      //         const SizedBox(
      //           height: 5,
      //         ),
      //         const Text(
      //           "Everyday\nessentials",
      //           style: TextStyle(fontSize: 12),
      //           maxLines: 2,
      //           overflow: TextOverflow.ellipsis,
      //         )
      //       ],
      //     ),
      //   ),
      //   Positioned(
      //       bottom: 10,
      //       right: 13,
      //       child: Hero(
      //         tag: "TC5",
      //         child: Container(
      //           width: 100,
      //           height: 75,
      //           decoration: const BoxDecoration(
      //               color: Colors.transparent,
      //               image: DecorationImage(
      //                 image: AssetImage(
      //                     "assets/images/Italy_pasta-removebg-preview.png"),
      //                 fit: BoxFit.cover,
      //               )),
      //         ),
      //       ))
      // ]),
    ],
  );
}