import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Headings.dart';

Widget CommentCon(BuildContext context,Widget replies)
{
  return Container(
    color: Colors.black.withOpacity(0.0),
    padding: const EdgeInsets.only(left: 15,right: 15),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [

        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            //Image
            Container(
              width: 40,
              height: 40,
              margin: const EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  image: const DecorationImage(image:
                  NetworkImage("https://lh3.googleusercontent.com/Ns1cmuogrYYnzEElT5FWWtORnFkCnJPmGP1HtcBdbjamzDn9HTkaEdwDmxMUFEtfMcOhM6Nu1Lk_LRpaqbhlDahE6YxshQML=s100"),fit: BoxFit.cover)
              ),
            ),

            Expanded(
              child: Column(
                children: [

                  const SizedBox(height: 12,),

                  //Title Row
                  Row(
                    children: [

                      //Title
                      const Text("Jamiel Sheikh ",
                        style: TextStyle(fontSize: 12,fontFamily: "Helvetica_Bold"),),

                      Padding(
                        padding: const EdgeInsets.only(bottom: 2),
                        child: Text("· 3 weeks ago",
                          style: TextStyle(fontFamily: "",fontSize: 11,color: Colors.black.withOpacity(0.6)),),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15,),

                  //Comment
                  RichText(
                    maxLines: 100,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(style: TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 12),
                          text: 'AI, or Artificial Intelligence, refers to the simulation of human intelligence in machines that are programmed to mimic cognitive processes such as learning, reasoning, problem-solving, and decision-making. AI systems are designed to perform tasks that typically require human intelligence, such as understanding natural language, recognizing images, and making predictions.',
                        ),

                      ],
                    ),
                  ),

                  const SizedBox(height: 15,),

                  //Like Reply Share Row
                  likeShareRow(context),

                  const SizedBox(height: 15,),


                  shadowLine(context),

                  //Reply Column
                  replies
                ],
              ),
            )
          ],
        ),
      ],
    ),
  );
}

Widget replyCon(BuildContext context)
{
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,

    children: [

      //Reply Image
      Container(
        width: 30,
        height: 30,
        margin: const EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            image: const DecorationImage(image:
            NetworkImage("https://lh3.googleusercontent.com/a6KTL7w4zgqo4fu_1sOqlrHGwe6QXzM4GriPxaXvcfNST0UshxYlcTa7ASQt0ErzGPOzkefLNfsQ23n6O_nXqA68iqivwF7tCEQpiPS5bekMWQ=s100"),fit: BoxFit.cover)
        ),
      ),

      Expanded(
        child: Column(
          children: [

            const SizedBox(height: 9,),

            //Title Row
            Row(
              children: [

                //Reply Title
                const Text("Sharif Tarver ",
                  style: TextStyle(fontSize: 12,fontFamily: "Helvetica_Bold"),),

                Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Text("· last week",
                    style: TextStyle(fontFamily: "",fontSize: 11,color: Colors.black.withOpacity(0.6)),),
                ),
              ],
            ),

            const SizedBox(height: 15,),

            //Comment
            RichText(
              maxLines: 100,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(style: TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 12),
                    text: 'AI, or Artificial Intelligence, refers to the simulation of human intelligence in machines that are programmed to mimic cognitive processes such as learning, reasoning, problem-solving, and decision-making. AI systems are designed to perform tasks that typically require human intelligence, such as understanding natural language, recognizing images, and making predictions.',
                  ),

                ],
              ),
            ),

            const SizedBox(height: 15,),

            likeShareRow(context),

            const SizedBox(height: 15,),

            shadowLine(context),

            const SizedBox(height: 15,),



          ],
        ),
      )
    ],
  );
}

Widget replyColumn(BuildContext context,int totalReplies)
{
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,

    children: [

      ListView.builder(
        shrinkWrap: true,
          itemCount: totalReplies,
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.only(top: 15),
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context,index)
          {
            return replyCon(context);
          }
      )

    ],
  );
}

Widget likeShareRow(BuildContext context)
{
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [

      //Like
      Icon(Icons.favorite,size: 20,color: Colors.black.withOpacity(0.3),),
      const SizedBox(width: 5,),
      Text("3 likes",
        style: TextStyle(color: Colors.black.withOpacity(0.6),fontSize: 12,),),

      const SizedBox(width: 10,),

      //Reply
      Icon(Icons.reply,size: 25,color: Colors.black.withOpacity(0.3),),

      const SizedBox(width: 10,),

      Icon(Icons.more_horiz,size: 25,color: Colors.black.withOpacity(0.3),)

    ],
  );
}