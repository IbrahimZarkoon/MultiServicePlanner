import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialapp/Screens/SingleEvent.dart';
import 'package:socialapp/Screens/SingleOrganizer.dart';

import '../Providers/CacheManager.dart';

Widget OrgSlider(BuildContext context)
{
  return Container(
    constraints: const BoxConstraints(
        maxHeight: 180,
    ),
    child: ListView(
      padding: const EdgeInsets.only(left: 20,right: 20),
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      children: [

        orgCon(context,
            "https://www.edigitalagency.com.au/wp-content/uploads/Facebook-logo-blue-circle-large-transparent-png.png",
          "Facebook",
          "Popular",
          true
        ),

        orgCon(context,
            "https://pbs.twimg.com/media/FY0CAnOXgAYINm3.jpg:large",
            "Urvashi",
            "Recommended",
            true
        ),

        orgCon(context,
            "https://img.freepik.com/premium-vector/purple-gradiend-social-media-logo_197792-1883.jpg?w=2000",
            "Instagram",
            "Popular",
            true
        ),

        orgCon(context,
            "https://www.edigitalagency.com.au/wp-content/uploads/Facebook-logo-blue-circle-large-transparent-png.png",
            "Instagram",
            "Popular",
            true
        ),


      ],
    ),
  );
}

Widget discoverOrgGrid(BuildContext context)
{
  return GridView(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: 20,
      crossAxisSpacing: 20,
      childAspectRatio: 1
    ),
    padding: const EdgeInsets.only(left: 20,right: 20),
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    physics: const BouncingScrollPhysics(),
    children: [

      orgCon(context,
          "https://img.freepik.com/free-photo/handsome-african-guy-with-stylish-haircut-taking-photo-digital-camera_171337-1345.jpg?w=2000&t=st=1694217855~exp=1694218455~hmac=284011734ce2c9f335e4295039fb3d9957163bdec4784ae193076a83754348c4",
          "Harry",
          "Photographer",
          true
      ),

      orgCon(context,
          "https://img.freepik.com/free-photo/teammates-working-together_1098-342.jpg?w=2000&t=st=1694219959~exp=1694220559~hmac=285c9ea3ea9e020667ec25884d5f2b577476a19b63555218dfa7171431256ae0",
          "EnchantingSpaces Decor",
          "Decorator",
          true
      ),

      orgCon(context,
          "https://img.freepik.com/free-photo/happy-young-waiter-holding-glass-champagne-towel_171337-5290.jpg?w=2000&t=st=1694219751~exp=1694220351~hmac=657837dd691241a6effb2c82a3870ce1b2f0ca4925d6c54deb577c25eb975670",
          "Gourmet Delights",
          "Caterer",
          true
      ),

      orgCon(context,
          "https://img.freepik.com/free-photo/handsome-african-guy-with-stylish-haircut-taking-photo-digital-camera_171337-1345.jpg?w=2000&t=st=1694217855~exp=1694218455~hmac=284011734ce2c9f335e4295039fb3d9957163bdec4784ae193076a83754348c4",
          "Harry",
          "Photographer",
          true
      ),

      orgCon(context,
          "https://img.freepik.com/free-photo/teammates-working-together_1098-342.jpg?w=2000&t=st=1694219959~exp=1694220559~hmac=285c9ea3ea9e020667ec25884d5f2b577476a19b63555218dfa7171431256ae0",
          "EnchantingSpaces Decor",
          "Decorator",
          true
      ),

      orgCon(context,
          "https://img.freepik.com/free-photo/happy-young-waiter-holding-glass-champagne-towel_171337-5290.jpg?w=2000&t=st=1694219751~exp=1694220351~hmac=657837dd691241a6effb2c82a3870ce1b2f0ca4925d6c54deb577c25eb975670",
          "Gourmet Delights",
          "Caterer",
          true
      ),


    ],
  );
}

Widget OrgGrid(BuildContext context)
{
  return GridView(
    shrinkWrap: true,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: 0.7
    ),
    padding: const EdgeInsets.only(left: 15,right: 15),
    physics: const BouncingScrollPhysics(),
    scrollDirection: Axis.vertical,

    children: [

      gridCon(context,
          "https://www.edigitalagency.com.au/wp-content/uploads/Facebook-logo-blue-circle-large-transparent-png.png",
          "Facebook",
          "Popular",
          true
      ),

      gridCon(context,
          "https://pbs.twimg.com/media/FY0CAnOXgAYINm3.jpg:large",
          "Urvashi",
          "Recommended",
          true
      ),

      gridCon(context,
          "https://img.freepik.com/premium-vector/purple-gradiend-social-media-logo_197792-1883.jpg?w=2000",
          "Instagram",
          "Popular",
          true
      ),

      gridCon(context,
          "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/Logo_of_Twitter.svg/512px-Logo_of_Twitter.svg.png?20220821125553",
          "Twitter",
          "Popular",
          true
      ),

      gridCon(context,
          "https://www.edigitalagency.com.au/wp-content/uploads/Facebook-logo-blue-circle-large-transparent-png.png",
          "Facebook",
          "Popular",
          true
      ),

      gridCon(context,
          "https://pbs.twimg.com/media/FY0CAnOXgAYINm3.jpg:large",
          "Urvashi",
          "Recommended",
          true
      ),

      gridCon(context,
          "https://img.freepik.com/premium-vector/purple-gradiend-social-media-logo_197792-1883.jpg?w=2000",
          "Instagram",
          "Popular",
          true
      ),

      gridCon(context,
          "https://www.edigitalagency.com.au/wp-content/uploads/Facebook-logo-blue-circle-large-transparent-png.png",
          "Instagram",
          "Popular",
          true
      ),

    ],
  );
}

Widget orgCon(BuildContext context,String img,String title,String status,bool verified)
{
  final cacheManager = Provider.of<CacheManagerProvider>(context).cacheManager;


  return GestureDetector(
    onTap: ()
    {
      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SingleServiceProvider(name: title, image: img)));
    },
    child: Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(bottom: 0,top: 0,right: 0),
      width: MediaQuery.of(context).size.width/2.75,
      decoration: BoxDecoration(

          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 0,
                blurRadius: 1.5,
                offset: const Offset(0,0)
            )
          ]
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.end,

            children: [

              Icon(CupertinoIcons.xmark,color: Colors.black.withOpacity(0.6),size: 14,)

            ],
          ),

          //image
          Container(
            margin: const EdgeInsets.only(bottom: 5),
            constraints: const BoxConstraints(
              maxHeight: 70,maxWidth: 70,
            ),
            decoration: BoxDecoration(
                // image: DecorationImage(
                //     image: NetworkImage(img),
                //     fit: BoxFit.scaleDown
                // ),
                borderRadius: BorderRadius.circular(100),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 0,
                      blurRadius: 1.5,
                      offset: const Offset(0,0)
                  )
                ]
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: CachedNetworkImage(
                imageUrl: img,
                cacheManager: cacheManager,
                fit: BoxFit.scaleDown,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(
                    color: Color(0xff09426d),
                    value: 2,
                    strokeWidth: 1,
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error,color: Color(0xff09426d),),
              ),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title,
                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black.withOpacity(0.8),fontSize: 12),),

              const SizedBox(width: 3,),

              verified? const Icon(Icons.verified,size: 13,color: Color(0xffffc107),) : const SizedBox()
            ],
          ),

          const SizedBox(height: 3,),

          Text(status,
            style: TextStyle(fontWeight: FontWeight.normal,color: Colors.black.withOpacity(0.6),fontSize: 10),),

          const Spacer(),

          Container(
            padding: const EdgeInsets.only(top: 5,bottom: 5),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: const Color(0xff09426d)
            ),
            child: const Text("Visit",
              style: TextStyle(color: Colors.white,fontSize: 11,fontWeight: FontWeight.bold),),
          )


        ],
      ),
    ),
  );
}

Widget gridCon(BuildContext context,String img,String title,String status,bool verified)
{
  return Container(
    padding: const EdgeInsets.all(5),
    //margin: EdgeInsets.only(bottom: 2,top: 2,right: 10),
    //width: MediaQuery.of(context).size.width/2.75,
    decoration: BoxDecoration(

        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 0,
              blurRadius: 1.5,
              offset: const Offset(0,0)
          )
        ]
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        Row(
          mainAxisAlignment: MainAxisAlignment.end,

          children: [

            Icon(CupertinoIcons.xmark,color: Colors.black.withOpacity(0.6),size: 14,)

          ],
        ),

        //image
        Container(
          margin: const EdgeInsets.only(bottom: 5),
          constraints: const BoxConstraints(
            maxHeight: 70,maxWidth: 70,
          ),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(img),
                  fit: BoxFit.scaleDown
              ),
              borderRadius: BorderRadius.circular(100),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 0,
                    blurRadius: 1.5,
                    offset: const Offset(0,0)
                )
              ]
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title,
              style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black.withOpacity(0.8),fontSize: 12),),

            const SizedBox(width: 3,),

            verified? const Icon(Icons.verified,size: 13,color: Color(0xff09426d),) : const SizedBox()
          ],
        ),

        const SizedBox(height: 3,),

        Text(status,
          style: TextStyle(fontWeight: FontWeight.normal,color: Colors.black.withOpacity(0.6),fontSize: 10),),

        const Spacer(),

        Container(
          padding: const EdgeInsets.only(top: 2,bottom: 2),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: const Color(0xff09426d)
          ),
          child: const Text("Visit",
            style: TextStyle(color: Colors.white,fontSize: 11,fontWeight: FontWeight.bold),),
        )


      ],
    ),
  );
}

