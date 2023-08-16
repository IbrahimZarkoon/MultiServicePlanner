import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Providers/CacheManager.dart';

class preferencesTab extends StatefulWidget {
  const preferencesTab({Key? key}) : super(key: key);

  @override
  State<preferencesTab> createState() => _preferencesTabState();
}

class _preferencesTabState extends State<preferencesTab> {

  bool tech = false;
  bool edu = false;
  bool music = false;
  bool cinema = false;
  bool sport = false;
  bool art = false;



  @override
  Widget build(BuildContext context) {


    return Container(
      padding: const EdgeInsets.only(top: 15,bottom: 0),
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Text("WHAT DO YOU LIKE?",
              style: TextStyle(fontFamily: "Helvetica_Bold",color: Colors.black.withOpacity(0.8),fontSize: 24),),

            const SizedBox(height: 15,),

            Text("Choose at least three categories.\nThis will help us find recommendations\nspecifically for you",
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: "",color: Colors.black.withOpacity(0.6),fontSize: 14),),

            const SizedBox(height: 15,),

            GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 1,
                ),
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.only(left: 20,right: 20),
              shrinkWrap: true,
              children: [

                interestCon(context,"https://img.icons8.com/?size=512&id=1938&format=png","Technology"),

                interestCon(context,"https://img.icons8.com/?size=512&id=40569&format=png","Education"),

                interestCon(context,"https://img.icons8.com/?size=512&id=aanJRSdBR4ug&format=png","Music"),

                interestCon(context,"https://img.icons8.com/?size=512&id=59&format=png","Sports"),

                interestCon(context,"https://img.icons8.com/?size=512&id=68463&format=png","Cinema"),

                interestCon(context,"https://img.icons8.com/?size=512&id=HzPzzQ84vzT3&format=png","Art"),

                interestCon(context,"https://img.icons8.com/?size=512&id=40569&format=png","Education"),

                interestCon(context,"https://img.icons8.com/?size=512&id=aanJRSdBR4ug&format=png","Music"),

                interestCon(context,"https://img.icons8.com/?size=512&id=59&format=png","Sports"),

                interestCon(context,"https://img.icons8.com/?size=512&id=68463&format=png","Cinema"),

                interestCon(context,"https://img.icons8.com/?size=512&id=HzPzzQ84vzT3&format=png","Art"),



              ],
            )
          ],
        ),
      ),
    );
  }

  Widget interestCon(BuildContext context,String image,String name)
  {
    final cacheManager = Provider.of<CacheManagerProvider>(context).cacheManager;


    return InkWell(
      onTap: (){

      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            constraints: const BoxConstraints(
                maxWidth: 85,maxHeight: 85,
                minWidth: 75,minHeight: 75
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  spreadRadius: 0,
                  blurRadius: 1.5,
                  offset: const Offset(0,0)
                )
              ]
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
                child: CachedNetworkImage(
                  imageUrl: image,
                  cacheManager: cacheManager,
                  fit: BoxFit.cover,
                  color: const Color(0xffff1f6f),
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xffff1f6f),
                      value: 1,
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error,color: Color(0xffff1f6f),),
                ),
            ),
          ),

          const SizedBox(height: 5,),

          Text(name,
            style: TextStyle(color: Colors.black.withOpacity(0.8),fontFamily: "Helvetica_Bold",fontSize: 12),)
        ],
      ),
    );
  }
}
