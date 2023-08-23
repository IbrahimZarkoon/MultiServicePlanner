import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Providers/CacheManager.dart';

class AboutTab extends StatefulWidget {
  const AboutTab({Key? key}) : super(key: key);

  @override
  State<AboutTab> createState() => _AboutTabState();
}

class _AboutTabState extends State<AboutTab> with SingleTickerProviderStateMixin{
  FocusNode F1 = FocusNode();
  TextEditingController T1 = TextEditingController();

  bool i1 = false;
  bool i2 = false;
  bool i3 = false;
  bool i4 = false;
  bool i5 = false;
  bool i6 = false;
  bool i7 = false;
  bool i8 = false;
  bool i9 = false;
  bool i10 = false;

  bool _tap = false;

  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 750), // Adjust the duration of the animation.
    );

    _animation = Tween<Offset>(
      begin: Offset(1.0, 0.0),
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
    F1.dispose();
    T1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()
      {
        setState(() {
          _tap = false;
          F1.unfocus();
        });
      },
      child: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(15),
        child: SlideTransition(
          position: _animation,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            scrollDirection:Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Text("What will your event be about?",
                  style: TextStyle(
                      fontFamily: "Helvetica_Bold",
                      color: Colors.black.withOpacity(0.8),
                      fontSize: 32
                  ),),

                const SizedBox(height: 15,),

                RichText(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Select at least 3 topics ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: "Helvetica_Bold",
                            fontSize: 15,
                            color: Colors.black.withOpacity(0.8)),
                      ),
                      TextSpan(
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.8),
                            fontSize: 15),
                        text:
                        'to help us promote your event to the right people.',
                      ),
                    ],
                  ),
                ),

                //Interest Container
                GestureDetector(
                  onTap: ()
                  {
                    setState(() {
                      _tap = true;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 15,bottom: 15),
                    padding: const EdgeInsets.only(left: 15,right: 15,top: 0,bottom: 0),
                    decoration: BoxDecoration(border: Border.all(color: _tap? const Color(0xffff1f6f) : Colors.black.withOpacity(0.5)),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        Icon(CupertinoIcons.search,size: 20,color: _tap? const Color(0xffff1f6f) : Colors.black.withOpacity(0.5),),

                        const SizedBox(width: 15,),

                        Expanded(
                            child: TextField(
                              onTap: ()
                              {
                                setState(() {
                                  _tap = true;
                                });
                              },
                              focusNode: F1,
                              controller: T1,
                              cursorColor: const Color(0xffff1f6f),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Search for topics",
                                  hintStyle: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: 13)
                              ),
                            )
                        ),

                        _tap?
                        InkWell(
                            onTap: ()
                            {
                              setState(() {
                                T1.text = "";
                                _tap = false;
                                F1.unfocus();

                              });
                            },
                            child: Icon(CupertinoIcons.xmark_circle_fill,color: Colors.black.withOpacity(0.5),size: 20,))
                            :
                        const SizedBox(),
                      ],
                    ),
                  ),
                ),

                // Container(
                //   padding: const EdgeInsets.only(left: 0,right: 0,bottom: 15),
                //   child: Wrap(
                //     spacing: 15, // spacing between the interest containers
                //     runSpacing: 15, // spacing between lines
                //
                //     children: <Widget>[
                //
                //       interestCon(context, "Dance and Movement",true),
                //
                //       interestCon(context, "Painting",i2),
                //
                //       interestCon(context, "Line Dancing",true),
                //
                //       interestCon(context, "Belly Dance",i4),
                //
                //       interestCon(context, "Argentine Tango",i5),
                //
                //       interestCon(context, "Painting",i6),
                //
                //       interestCon(context, "Dance and Movement",i7),
                //
                //       interestCon(context, "Line Dancing",i8),
                //
                //       interestCon(context, "Belly Dance",i9),
                //
                //       interestCon(context, "Argentine Tango",i10),
                //
                //
                //
                //
                //
                //
                //     ],
                //   ),
                // ),


                // Text("Sport",
                //   style: TextStyle(fontFamily: "Helvetica_Bold",color: Colors.black.withOpacity(0.8),fontSize: 22),),

                Container(
                  margin: const EdgeInsets.only(bottom: 15),

                  padding: const EdgeInsets.only(left: 0,right: 0,bottom: 15,top: 15),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 15, // spacing between the interest containers
                    runSpacing: 15, // spacing between lines

                    children: <Widget>[

                      interestCon(context, "Dance and Movement",true),

                      interestCon(context, "Painting",i2),

                      interestCon(context, "Line Dancing",true),

                      interestCon(context, "Belly Dance",i4),

                      interestCon(context, "Argentine Tango",i5),

                      interestCon(context, "Painting",i6),

                      interestCon(context, "Dance and Movement",i7),

                      interestCon(context, "Line Dancing",i8),

                      interestCon(context, "Belly Dance",i9),

                      interestCon(context, "Argentine Tango",i10),






                    ],
                  ),
                ),


                // GridView(
                //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                //     crossAxisCount: 3,
                //     mainAxisSpacing: 20,
                //     crossAxisSpacing: 20,
                //     childAspectRatio: 0.9,
                //   ),
                //   scrollDirection: Axis.vertical,
                //   physics: const NeverScrollableScrollPhysics(),
                //   padding: const EdgeInsets.only(left: 0,right: 0,top: 10,bottom: 10),
                //   shrinkWrap: true,
                //   children: [
                //
                //     interestCon(context,"https://img.icons8.com/?size=512&id=1938&format=png","Technology"),
                //
                //     interestCon(context,"https://img.icons8.com/?size=512&id=40569&format=png","Education"),
                //
                //     interestCon(context,"https://img.icons8.com/?size=512&id=aanJRSdBR4ug&format=png","Music"),
                //
                //     interestCon(context,"https://img.icons8.com/?size=512&id=59&format=png","Sports"),
                //
                //     interestCon(context,"https://img.icons8.com/?size=512&id=68463&format=png","Cinema"),
                //
                //     interestCon(context,"https://img.icons8.com/?size=512&id=HzPzzQ84vzT3&format=png","Art"),
                //
                //     interestCon(context,"https://img.icons8.com/?size=512&id=40569&format=png","Education"),
                //
                //     interestCon(context,"https://img.icons8.com/?size=512&id=aanJRSdBR4ug&format=png","Music"),
                //
                //     interestCon(context,"https://img.icons8.com/?size=512&id=59&format=png","Sports"),
                //
                //     interestCon(context,"https://img.icons8.com/?size=512&id=68463&format=png","Cinema"),
                //
                //     interestCon(context,"https://img.icons8.com/?size=512&id=HzPzzQ84vzT3&format=png","Art"),
                //
                //
                //
                //   ],
                // ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget interestCon(BuildContext context,String txt,bool T)
  {
    return InkWell(
        onTap: ()
        {

        },
        child: Container(

          //alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: T?  const Color(0xffff1f6f) : Colors.white,
              border: Border.all(color:const Color(0xffff1f6f),width: 0.5)
          ),
          padding: const EdgeInsets.only(top: 8,bottom: 8,left: 15,right: 15),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(txt,style: TextStyle(
                  color: T? Colors.white : const Color(0xffff1f6f),fontSize: 12
              ),),
            ],
          ),
        )
    );
  }

  Widget interestCon1(BuildContext context,String image,String name)
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

  Widget oldInterestCon(BuildContext context,String txt,bool T)
  {
    return InkWell(
      onTap: ()
      {
        setState(() {
          T = !T;
        });
        if(T1.text.isEmpty) {
          T1.text += txt;
        }
        else
        {
          T1.text += ", $txt";
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: T? const Color(0xffff1f6f) : Colors.black.withOpacity(0.2),width: 0.5),
          color: T? const Color(0xffff1f6f) :  const Color(0xFFFFFFFF),
        ),
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              txt,
              style: TextStyle(
                color: T? Colors.white : Colors.black.withOpacity(0.6),
                fontSize: 12,
                fontFamily: "Helvetica_Bold",
              ),
            ),
            
            const SizedBox(width: 10,),
            
            T ?
            const Icon(CupertinoIcons.minus,size: 20,color: Colors.white,)
                :
            Icon(CupertinoIcons.add,size: 20,color: Colors.black.withOpacity(0.5),)
          ],
        ),
      ),
    );
  }
}
