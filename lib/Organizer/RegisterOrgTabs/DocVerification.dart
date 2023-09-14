import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Providers/CacheManager.dart';

class DocVerification extends StatefulWidget {
  const DocVerification({Key? key}) : super(key: key);

  @override
  State<DocVerification> createState() => _DocVerificationState();
}

class _DocVerificationState extends State<DocVerification> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<Offset> _animation;

  FocusNode _dobNode = FocusNode();
  FocusNode _confirmNode = FocusNode();


  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750), // Adjust the duration of the animation.
    );

    _animation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut, // Adjust the animation curve.
    ));

    // Start the animation when the screen is loaded.
    _controller.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cacheManager = Provider.of<CacheManagerProvider>(context).cacheManager;


    return SlideTransition(
      position: _animation,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              Text("Document Verification",
                style: TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 28,fontFamily: "Helvetica_Bold"),),

              const SizedBox(height: 10,),

              Text("Take pictures of both sides of your government issued ID card.",
                style: TextStyle(fontFamily: "",color: Colors.black.withOpacity(0.6),fontSize: 14),),

              //const SizedBox(height: kToolbarHeight,),

              Stack(
                children: [


                  Positioned(
                      bottom: 0,right: -50,left: 0,
                      child: Container(
                        constraints: BoxConstraints(

                            maxHeight: MediaQuery.of(context).size.height * 0.15),
                        margin: const EdgeInsets.all(20),
                        child: CachedNetworkImage(
                          imageUrl: "https://img.icons8.com/?size=512&id=EKeYRe0-QCY9&format=png",
                          cacheManager: cacheManager,
                          fit: BoxFit.scaleDown,
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(
                              color: Color(0xff09426d),
                              value: 5,
                            ),
                          ),
                          errorWidget: (context, url, error) => const Icon(Icons.error,color: Color(0xff09426d),),
                        ),
                      )),
                Container(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width,
                      maxHeight: MediaQuery.of(context).size.height * 0.25),
                  margin: const EdgeInsets.only(left: 0,right:20,bottom: 20),
                  decoration: const BoxDecoration(

                      image: DecorationImage(
                          image: NetworkImage(
                              "https://img.icons8.com/?size=512&id=EKeYRe0-QCY9&format=png"),
                          fit: BoxFit.contain,alignment: Alignment.centerLeft)),
                ),

              ]
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.circle,size: 10,color: Colors.black.withOpacity(0.8),),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text('Upload a complete image of your ID document',maxLines: 2,
                        style: TextStyle(color: Colors.black.withOpacity(0.8),fontWeight: FontWeight.bold),),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      Icon(Icons.circle,size: 10,color: Colors.black.withOpacity(0.8),),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text('Ensure all details are readable in the image you upload.',maxLines: 2,
                        style: TextStyle(color: Colors.black.withOpacity(0.8),fontWeight: FontWeight.bold),),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),

                  Row(
                    children: [
                      Icon(Icons.circle,size: 10,color: Colors.black.withOpacity(0.8),),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text('Ensure the document is the original and has not expired.',maxLines: 2,
                        style: TextStyle(color: Colors.black.withOpacity(0.8),fontWeight: FontWeight.bold),),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),

                  Row(
                    children: [
                      Icon(Icons.circle,size: 10,color: Colors.black.withOpacity(0.8),),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text('Place documents against a solid-colored background.',maxLines: 2,
                        style: TextStyle(color: Colors.black.withOpacity(0.8),fontWeight: FontWeight.bold),),
                      ),
                    ],
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
