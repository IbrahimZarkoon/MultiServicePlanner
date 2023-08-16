import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Providers/CacheManager.dart';

class DocUploaded extends StatefulWidget {
  const DocUploaded({Key? key}) : super(key: key);

  @override
  State<DocUploaded> createState() => _DocUploadedState();
}

class _DocUploadedState extends State<DocUploaded> {

  double _opacity = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(const Duration(milliseconds: 10),(){
      setState(() {
        _opacity = 1;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cacheManager = Provider.of<CacheManagerProvider>(context).cacheManager;


    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,

      children: [

        AnimatedOpacity(
          duration: const Duration(milliseconds: 1000),
          opacity: _opacity,
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: 150,maxHeight: 150,
              minWidth: 50,minHeight: 50
            ),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/Icons/check.png"),

              )
            ),

          ),
        ),

        Text("Document uploaded",
        style: TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 20,fontWeight: FontWeight.bold),),

        const SizedBox(height: 10,),

        Text("Click continue to proceed to the login",
        style: TextStyle(color: Colors.black.withOpacity(0.6),fontWeight: FontWeight.bold,fontSize: 14),)

      ],
    );
  }
}
