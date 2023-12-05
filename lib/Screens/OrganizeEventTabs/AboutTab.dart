import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_service_planner/Enums/Colors.dart';
import 'package:multi_service_planner/Response/TagsResponse.dart';
import 'package:multi_service_planner/modals/OrganizeEventProvider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../Providers/CacheManager.dart';

class AboutTab extends StatefulWidget {
  const AboutTab({Key? key}) : super(key: key);

  @override
  State<AboutTab> createState() => _AboutTabState();
}

class _AboutTabState extends State<AboutTab> with SingleTickerProviderStateMixin{
  FocusNode F1 = FocusNode();
  TextEditingController T1 = TextEditingController();

  List<TagsResponse>? TagsList = [];

  List<String> tags = [];

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

  //Get Request for All Tags Data
  Future<TagsResponse?> getAllTags() async {

    var url = Uri.parse(
      'https://everythingforpageants.com/msp/api/getTags.php',);

    var response = await http.get(url);

    if (response.statusCode == 200) {
      print(response.body);
      var json = jsonDecode(response.body);
      List<dynamic> dataArray = json;
      TagsList = dataArray.map((item) => new TagsResponse.fromJson(item)).toList();
      print(TagsList?[0]);
    } else {
      throw Exception('Failed to retrieve All Tags');
    }
  }

  @override
  Widget build(BuildContext context) {

    getAllTags();

    var OrgEventProv = Provider.of<OrganizeEventProvider>(context,listen: false);

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
                    decoration: BoxDecoration(border: Border.all(color: _tap? appPrimary : Colors.black.withOpacity(0.5)),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        Icon(CupertinoIcons.search,size: 20,color: _tap? appPrimary : Colors.black.withOpacity(0.5),),

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
                              cursorColor: appPrimary,
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

                GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // or the number of columns you want
                    crossAxisSpacing: 15.0,
                    mainAxisSpacing: 15.0,
                  ),
                  itemBuilder: (context, index) {
                    final tag = TagsList![index];
                    return InkWell(
                      onTap: () {
                        setState(() {
                          OrgEventProv.tags.add("${tag.id}");
                        });
                      },
                      child: interestCon(context, "${tag.tag}", false /* Add other parameters as needed */),
                    );
                  },
                  itemCount: TagsList!.length,
                ),

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
              color: T?  appPrimary : Colors.white,
              border: Border.all(color: appPrimary,width: 0.5)
          ),
          padding: const EdgeInsets.only(top: 8,bottom: 8,left: 15,right: 15),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(txt,style: TextStyle(
                  color: T? Colors.white : appPrimary,fontSize: 12
              ),),
            ],
          ),
        )
    );
  }
}
