import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Enums/Colors.dart';
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
        height: kToolbarHeight,
        width: MediaQuery.sizeOf(context).width * 0.25,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              "assets/images/logos/LOGO.png",
              fit: BoxFit.scaleDown,
              color: Colors.white,
            )),
      ),
      backgroundColor: appPrimary,

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
            child: const Icon(Icons.menu,size: 22,color: appPrimary,),
          ),
        ),

      ],
    );
  }
}
