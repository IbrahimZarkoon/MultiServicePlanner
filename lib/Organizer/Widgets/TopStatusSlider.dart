import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

Widget topStatusSlider(BuildContext context)
{
  return Container(
    width: MediaQuery.of(context).size.width,
    constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height*0.1
    ),
    child: ListView(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(top: 10,bottom: 10,right: 10),

      children: [



        //Guest Con
        Container(
          constraints: const BoxConstraints(
              minWidth: 150
          ),
          margin: const EdgeInsets.only(left: 10),
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    spreadRadius: 1,
                    blurRadius: 1.5,
                    offset: const Offset(0,0)
                )
              ]
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              RichText(
                  maxLines: 1,
                  text: TextSpan(

                      children: [

                        TextSpan(
                            text: "7",
                            style: TextStyle(color: Colors.black.withOpacity(0.8),fontWeight: FontWeight.bold)
                        ),

                        TextSpan(
                            text: "",
                            style: TextStyle(color: Colors.black.withOpacity(0.6),)

                        )

                      ]
                  )

              ),

              const SizedBox(height: 2,),

              Text("Guests today so far",
                style: TextStyle(
                    color: Colors.black.withOpacity(0.6),fontSize: 12
                ),)

            ],
          ),
        ),


        //Tickets Con
        Container(
          constraints: const BoxConstraints(
              minWidth: 150
          ),
          margin: const EdgeInsets.only(left: 10),
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),

              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    spreadRadius: 1,
                    blurRadius: 1.5,
                    offset: const Offset(0,0)
                )
              ]
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              RichText(
                  maxLines: 1,
                  text: TextSpan(

                      children: [

                        TextSpan(
                            text: "3 ",
                            style: TextStyle(color: Colors.black.withOpacity(0.8),fontWeight: FontWeight.bold)
                        ),

                        TextSpan(
                            text: "",
                            style: TextStyle(color: Colors.black.withOpacity(0.6),)

                        )

                      ]
                  )

              ),

              const SizedBox(height: 2,),

              Text("Tickets today so far",
                style: TextStyle(
                    color: Colors.black.withOpacity(0.6),fontSize: 12
                ),)

            ],
          ),
        ),

        //Next Event Con
        Container(
          constraints: const BoxConstraints(
              minWidth: 150
          ),
          margin: const EdgeInsets.only(left: 10),
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),

              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    spreadRadius: 1,
                    blurRadius: 1.5,
                    offset: const Offset(0,0)
                )
              ]
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              RichText(
                  maxLines: 1,
                  text: TextSpan(

                      children: [

                        TextSpan(
                            text: "Aug 3, 2023",
                            style: TextStyle(color: Colors.black.withOpacity(0.8),fontWeight: FontWeight.bold)
                        ),

                        TextSpan(
                            text: "",
                            style: TextStyle(color: Colors.black.withOpacity(0.6),)

                        )

                      ]
                  )

              ),

              const SizedBox(height: 2,),

              Text("Next event",
                style: TextStyle(
                    color: Colors.black.withOpacity(0.6),fontSize: 12
                ),)

            ],
          ),
        ),

        Container(
          constraints: const BoxConstraints(
              minWidth: 150
          ),
          margin: const EdgeInsets.only(left: 10),
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),

              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    spreadRadius: 1,
                    blurRadius: 1.5,
                    offset: const Offset(0,0)
                )
              ]
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Padding(
                padding: const EdgeInsets.only(bottom: 2.0),
                child: AbsorbPointer(
                  absorbing: true,
                  child: RatingBar(
                    initialRating: double.parse("4.4"),
                    allowHalfRating: true,
                    itemSize: 16,
                    ratingWidget: RatingWidget(
                        full: const Icon(
                          Icons.star,
                          color: Color(0xffffc107),
                        ),
                        half: const Icon(
                          Icons.star_half,
                          color: Color(0xffffc107),
                        ),
                        empty: const Icon(
                          Icons.star_border,
                          color: Color(0xffffc107),
                        )),
                    onRatingUpdate: (ratings) => print(ratings),
                  ),
                ),
              ),

              const SizedBox(height: 2,),

              Text("Guest feedback",
                style: TextStyle(
                    color: Colors.black.withOpacity(0.6),fontSize: 12
                ),)

            ],
          ),
        ),


      ],
    ),
  );
}