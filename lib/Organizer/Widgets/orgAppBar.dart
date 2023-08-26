import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Providers/CacheManager.dart';

class orgAppBar extends StatefulWidget {
   orgAppBar({Key? key,required this.scaffoldKey}) : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  State<orgAppBar> createState() => _orgAppBarState();
}

class _orgAppBarState extends State<orgAppBar> {



  @override
  Widget build(BuildContext context) {

    final cacheManager = Provider.of<CacheManagerProvider>(context).cacheManager;


    return AppBar(

      automaticallyImplyLeading: false,
      elevation: 0.0,
      centerTitle: false,
      title: Container(
        alignment: Alignment.centerLeft,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            color: Colors.white,
            height: kToolbarHeight-10,
            imageUrl: "https://www.nexarce.com/wp-content/uploads/2023/04/NexarceLogo.png",
            cacheManager: cacheManager,
            fit: BoxFit.cover,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(
                color: Color(0xffff1f6f),
                value: 5,
              ),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error,color: Color(0xffff1f6f),),
          ),
        ),
      ),
      backgroundColor: const Color(0xffff1f6f),

      actions: [

        //Profile Image Container
        InkWell(
          onTap: () {
            widget.scaffoldKey.currentState?.openEndDrawer();

          },
          child: Container(
            margin: const EdgeInsets.only(right: 15,bottom: 10,top: 10),
            padding: const EdgeInsets.all(5),
            constraints: const BoxConstraints(
                maxHeight: 40
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              //color: Color(0xffffffff),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white,width: 2)
            ),
            child: const Icon(Icons.menu,size: 22,color: Color(0xffff1f6f),),
          ),
        ),

      ],
    );
  }
}
