import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../CustomWidgets/TicketingDialog.dart';

class NameTab extends StatefulWidget {
  const NameTab({Key? key}) : super(key: key);

  @override
  State<NameTab> createState() => _NameTabState();
}

class _NameTabState extends State<NameTab> with SingleTickerProviderStateMixin {
  FocusNode F1 = FocusNode();
  TextEditingController T1 = TextEditingController();

  late AnimationController _controller;
  late Animation<Offset> _animation;

  final ImagePicker _BannerPicker = ImagePicker();
  File? bannerIMG;
  File? thumbIMG;

  bool _tap = false;
  bool capacity1 = false;
  bool capacity2 = false;
  bool capacity3 = false;

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

  List<PickedFile> images = [];

  Future<void> _pickImage() async {
    final pickedImage = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      setState(() {
        images.add(pickedImage);
      });
    }
  }

  //bool _tap = false;

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
        F1.unfocus();
        _tap = false;
      },
      child: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(left: 15,right: 15),
        child: SlideTransition(
          position: _animation,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Stack(
                    children: [

                      //Banner IMAGE

                      Container(
                        margin: EdgeInsets.only(left: 15, right: 15, top: 15,bottom: MediaQuery.of(context).size.height*0.12),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.2,
                        decoration: BoxDecoration(
                            color: const Color(0xfff8f7f7),
                            borderRadius: BorderRadius.circular(3),
                            // image: const DecorationImage(
                            //     image: NetworkImage(
                            //         "https://img.icons8.com/?size=512&id=bjHuxcHTNosO&format=png"),
                            //     fit: BoxFit.contain),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  offset: const Offset(0, 0),
                                  spreadRadius: 1,
                                  blurRadius: 1.5)
                            ]),
                        child: bannerIMG != null ? Image.file(bannerIMG!,fit: BoxFit.cover,) : Image.network("https://img.icons8.com/?size=512&id=bjHuxcHTNosO&format=png",fit: BoxFit.contain,),

                      ),

                      Positioned(
                          top: 15,right: 15,
                          child: InkWell(
                            onTap: ()
                            {
                              showCupertinoModalPopup(
                                  context: context, builder: (BuildContext context)
                              {
                                return CupertinoActionSheet(
                                  title: const Text("Edit Photo"),
                                  cancelButton: CupertinoActionSheetAction(
                                    onPressed: ()
                                    {
                                      Navigator.pop(context);
                                    }, child: const Text("Cancel"),
                                  ),
                                  actions: [
                                    CupertinoActionSheetAction(
                                        onPressed: () async {
                                          final XFile? image = await _BannerPicker.pickImage(source: ImageSource.gallery);
                                          if (image == null) return;

                                          // Convert XFile to File
                                          final imageTemp = File(image.path);

                                          setState(() {
                                            bannerIMG = imageTemp; // Assign to the File variable
                                          });
                                          Navigator.pop(context);

                                        },
                                        child: const Text("Choose Photo")),

                                    CupertinoActionSheetAction(
                                        onPressed: () async {
                                          final XFile? image = await _BannerPicker.pickImage(source: ImageSource.camera);
                                          if (image == null) return;

                                          // Convert XFile to File
                                          final imageTemp = File(image.path);

                                          setState(() {
                                            bannerIMG = imageTemp; // Assign to the File variable
                                          });
                                          Navigator.pop(context);

                                        },
                                        child: const Text("Take Photo")),

                                  ],
                                );
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration:  BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(topRight: Radius.circular(3),bottomLeft: Radius.circular(3)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.15),
                                    blurRadius: 1.5,
                                    spreadRadius: 0,
                                    offset: Offset(-1,2)
                                  )
                                ]

                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [

                                  Icon(CupertinoIcons.camera,size: 20,color: Colors.black.withOpacity(0.6),),

                                  const SizedBox(width: 10,),

                                  Text("Update Banner",style: TextStyle(
                                      color: Colors.black.withOpacity(0.8),fontSize: 12,fontFamily: "Helvetica_Bold"
                                  ),)
                                ],
                              ),
                            ),
                          )),

                      //Thumb IMAGE
                      Positioned(
                          bottom: 0,left: MediaQuery.of(context).size.width/3.3,
                          child: InkWell(

                            child: Column(

                              children: [

                                //ImageCon
                                Container(
                                  width: 125,
                                  height: 125,
                                  decoration: BoxDecoration(
                                      color: const Color(0xfff8f7f7),
                                      borderRadius: BorderRadius.circular(3),
                                      // image: const DecorationImage(
                                      //     image: NetworkImage(
                                      //         "https://img.icons8.com/?size=512&id=bjHuxcHTNosO&format=png"),
                                      //     fit: BoxFit.contain),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black.withOpacity(0.2),
                                            offset: const Offset(0, 0),
                                            spreadRadius: 1,
                                            blurRadius: 1.5)
                                      ]),
                                  child: thumbIMG != null ? Image.file(thumbIMG!,fit: BoxFit.cover,) : Image.network("https://img.icons8.com/?size=512&id=bjHuxcHTNosO&format=png",fit: BoxFit.contain,),

                                ),

                                //Update Con
                                InkWell(
                                  onTap: ()
                                  {
                                    showCupertinoModalPopup(
                                        context: context, builder: (BuildContext context)
                                    {
                                      return CupertinoActionSheet(
                                        title: const Text("Edit Photo"),
                                        cancelButton: CupertinoActionSheetAction(
                                          onPressed: ()
                                          {
                                            Navigator.pop(context);
                                          }, child: const Text("Cancel"),
                                        ),
                                        actions: [
                                          CupertinoActionSheetAction(
                                              onPressed: () async {
                                                final XFile? image = await _BannerPicker.pickImage(source: ImageSource.gallery);
                                                if (image == null) return;

                                                // Convert XFile to File
                                                final imageTemp = File(image.path);

                                                setState(() {
                                                  thumbIMG = imageTemp; // Assign to the File variable
                                                });
                                                Navigator.pop(context);

                                              },
                                              child: const Text("Choose Photo")),

                                          CupertinoActionSheetAction(
                                              onPressed: () async {
                                                final XFile? image = await _BannerPicker.pickImage(source: ImageSource.camera);
                                                if (image == null) return;

                                                // Convert XFile to File
                                                final imageTemp = File(image.path);

                                                setState(() {
                                                  thumbIMG = imageTemp; // Assign to the File variable
                                                });
                                                Navigator.pop(context);

                                              },
                                              child: const Text("Take Photo")),

                                        ],
                                      );
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.2),
                                            offset: const Offset(0,0),
                                            blurRadius: 1.5,
                                            spreadRadius: 1,
                                          )
                                        ],
                                        color: Colors.white,
                                        borderRadius: const BorderRadius.only(bottomRight: Radius.circular(3),bottomLeft: Radius.circular(3))

                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [

                                        Icon(CupertinoIcons.camera,size: 20,color: Colors.black.withOpacity(0.6),),

                                        const SizedBox(width: 10,),

                                        Text("Update Thumb",style: TextStyle(
                                            color: Colors.black.withOpacity(0.8),fontSize: 12,fontFamily: "Helvetica_Bold"
                                        ),)
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ]
                ),

                const SizedBox(height: 15,),

                Text("What's the name of your event?",
                  style: TextStyle(
                      fontFamily: "Helvetica_Bold",
                      color: Colors.black.withOpacity(0.8),
                      fontSize: 28
                  ),),

                const SizedBox(height: 15,),

                Text("Choose a name that will give people a clear idea of what the group is about. You can edit this later if you change your mind.",
                  style: TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 15),),

                //Name Container
                GestureDetector(
                  onTap: ()
                  {
                    setState(() {

                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 15,bottom: 15),
                    padding: const EdgeInsets.only(left: 15,right: 15,top: 0,bottom: 0),
                    decoration: BoxDecoration(border: Border.all(color: _tap? const Color(0xff009ed9) : Colors.black.withOpacity(0.5)),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

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
                              cursorColor: const Color(0xff009ed9),
                              style: TextStyle(fontSize: 16,color: Colors.black.withOpacity(0.8)),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Event name",
                                hintStyle: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: 13),

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


                //Desc
                Text("How would you describe your group?",
                  style: TextStyle(
                      fontFamily: "Helvetica_Bold",
                      color: Colors.black.withOpacity(0.8),
                      fontSize: 28
                  ),),

                const SizedBox(height: 15,),

                RichText(text: TextSpan(
                    children: <TextSpan>[

                      TextSpan(
                          text: "People will see this when we promote your group, but you'll be able to update it later. Your description must meet our ",
                          style: TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 15)
                      ),
                      const TextSpan(
                          text: "community guidelines.",
                          style: TextStyle(color: Color(0xffff1f6f),fontSize: 15)
                      ),
                    ]
                )),
                // Text("People will see this when we promote your group, but you'll be able to update it later. Your description must meet our ",
                //   style: TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 15),),

                //Description Container
                GestureDetector(
                  onTap: ()
                  {
                    setState(() {

                    });
                  },
                  child: Container(
                    constraints: const BoxConstraints(
                        minHeight: 200
                    ),
                    margin: const EdgeInsets.only(top: 15,bottom: 15),
                    padding: const EdgeInsets.only(left: 15,right: 15,top: 0,bottom: 0),
                    decoration: BoxDecoration(border: Border.all(color: _tap? const Color(0xffff1f6f) : Colors.black.withOpacity(0.5)),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

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
                              style: TextStyle(fontSize: 16,color: Colors.black.withOpacity(0.8)),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Write at least 50 characters",
                                hintStyle: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: 13),

                              ),
                            )
                        ),

                      ],
                    ),
                  ),
                ),

                Text("• What's the event goal?",
                  style: TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 15),),

                const SizedBox(height: 15,),

                Text("• Who are you hoping to meet?",
                  style: TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 15),),

                const SizedBox(height: 15,),

                Text("• What will you do at your events?",
                  style: TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 15),),

                const SizedBox(height: 15,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,

                  children: const [

                    Icon(CupertinoIcons.light_max,color: Color(0xffff1f6f)),

                    SizedBox(width: 10,),

                    Text("See examples of event descriptions",
                        style: TextStyle(color: Color(0xffff1f6f),fontSize: 15))



                  ],
                ),

                const SizedBox(height: 15,),

                Text("Capacity",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.8),
                        fontWeight: FontWeight.bold,
                        fontSize: 16)),

                Padding(
                  padding: const EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //1st Capacity Row
                      InkWell(

                        onTap: () {

                          setState(() {
                            capacity1 = !capacity1;
                            capacity2 = false;
                            capacity3 = false;
                          });


                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              capacity1
                                  ? Icons.check_circle
                                  : Icons.circle_outlined,
                              size: 22,
                              color: Colors.black.withOpacity(0.6),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "250",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: capacity1
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: Colors.black.withOpacity(0.8)),
                            )
                          ],
                        ),
                      ),

                      //2nd Capacity Row
                      InkWell(
                        onTap: () {

                          setState(() {
                            capacity2 = !capacity2;
                            capacity1 = false;
                            capacity3 = false;
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              capacity2
                                  ? Icons.check_circle
                                  : Icons.circle_outlined,
                              size: 22,
                              color: Colors.black.withOpacity(0.6),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "500",
                              style: TextStyle(
                                  fontSize: 12,

                                  fontWeight: capacity2
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: Colors.black.withOpacity(0.8)),
                            )
                          ],
                        ),
                      ),

                      //3rd Capacity Row
                      InkWell(
                        onTap: () {

                          setState(() {
                            capacity3 = !capacity3;
                            capacity2 = false;
                            capacity1 = false;
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              capacity3
                                  ? Icons.check_circle
                                  : Icons.circle_outlined,
                              size: 22,
                              color: Colors.black.withOpacity(0.6),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "1000",
                              style: TextStyle(
                                  fontSize: 12,

                                  fontWeight: capacity3
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: Colors.black.withOpacity(0.8)),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Text("Event video",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.8),
                        fontWeight: FontWeight.bold,
                        fontSize: 16)),

                GestureDetector(
                  onTap: ()
                  {
                    setState(() {
                      _tap = true;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 10,bottom: 15,left: 0,right: 0),
                    padding: const EdgeInsets.only(left: 15,right: 15,top: 0,bottom: 0),
                    decoration: BoxDecoration(border: Border.all(color: _tap? const Color(0xff009ed9) : Colors.black.withOpacity(0.5)),
                        borderRadius: BorderRadius.circular(8)
                    ),
                    child: Column(
                      children: [


                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

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
                                  cursorColor: const Color(0xff009ed9),
                                  style: TextStyle(fontSize: 13,color: Colors.black.withOpacity(0.8)),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "ex. http://youtube.com/yourvideo",
                                    hintStyle: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: 13),

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
                      ],
                    ),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    Icon(CupertinoIcons.info_circle_fill,color: Colors.black.withOpacity(0.5),size: 18,),

                    const SizedBox(width: 5,),

                    Flexible(
                      child: Text("When a customer registers for your event, they become part of your subscribers - which means we will notify them everytime you publish a new event.",
                        style: TextStyle(fontSize: 12,color: Colors.black.withOpacity(0.5)),),
                    )

                  ],
                ),

                InkWell(
                  onTap: _pickImage,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 15,top: 15,left: 2,right: 2),
                    padding: const EdgeInsets.all(10),
                    decoration:  BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(3)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 1.5,
                              spreadRadius: 0,
                              offset: Offset(0,0)
                          )
                        ]

                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        Icon(CupertinoIcons.camera,size: 20,color: Colors.black.withOpacity(0.6),),

                        const SizedBox(width: 10,),

                        Text("Add more photos",style: TextStyle(
                            color: Colors.black.withOpacity(0.8),fontSize: 12,fontFamily: "Helvetica_Bold"
                        ),)
                      ],
                    ),
                  )
                ),
                GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  shrinkWrap: true,
                  children: List.generate(images.length>=3? 3 : images.length, (index) {
                    return index == 2? Stack(children: [ClipRRect(
                        borderRadius: BorderRadius.circular(3),
                        child: Image.file(File(images[index].path))),
                    Positioned(
                        left: 20,bottom: 0,top: 0,
                        child: Center(child: Text("+${images.length-2}",style: TextStyle(color: Colors.white,fontSize: 22),),))
                    
                    ]) : Stack(
                      children: [ClipRRect(
                          borderRadius: BorderRadius.circular(3),
                          child: Image.file(File(images[index].path))),]
                    );
                  }),
                ),

                const SizedBox(height: 10,),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
