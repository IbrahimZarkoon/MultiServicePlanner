
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialapp/CustomWidgets/TicketingDialog.dart';

class AdditionalInfo extends StatefulWidget {
  const AdditionalInfo({Key? key}) : super(key: key);

  @override
  State<AdditionalInfo> createState() => _AdditionalInfoState();
}

class _AdditionalInfoState extends State<AdditionalInfo> with SingleTickerProviderStateMixin{

  FocusNode F1 = FocusNode();
  TextEditingController T1 = TextEditingController();

  bool _tap = false;
  bool freeEntry = false;
  bool paidEntry = false;
  bool donationTicket = false;

  var selectedValue;

  final ImagePicker _BannerPicker = ImagePicker();
  final ImagePicker _ThumbPicker = ImagePicker();

  File? bannerIMG;
  File? thumbIMG;

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


  // final ImagePicker _picker = ImagePicker();
  // Future pickImage() async {
  //   try{
  //     final image = await _picker.pickImage(source: ImageSource.gallery);
  //     if(image == null) return;
  //
  //     final imageTemp = File(image.path);
  //     setState(() {
  //       this.UserImage = imageTemp;
  //     });
  //   } on PlatformException catch (e){
  //     print("Failed to pick image: $e");
  //   }
  // }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: SlideTransition(
        position: _animation,
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
                    color: const Color(0xffe5e5e5),
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
                child: bannerIMG != null ? Image.file(bannerIMG!) : Image.network("https://img.icons8.com/?size=512&id=bjHuxcHTNosO&format=png",fit: BoxFit.contain,),

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
                        decoration: const BoxDecoration(
                          color: Colors.white,
                            borderRadius: BorderRadius.only(topRight: Radius.circular(3),bottomLeft: Radius.circular(3))

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
                    bottom: 0,left: MediaQuery.of(context).size.width/3,
                    child: InkWell(

                      child: Column(

                        children: [

                          //ImageCon
                          Container(
                            width: 125,
                            height: 125,
                            decoration: BoxDecoration(
                                color: const Color(0xffe5e5e5),
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
                            child: thumbIMG != null ? Image.file(thumbIMG!) : Image.network("https://img.icons8.com/?size=512&id=bjHuxcHTNosO&format=png",fit: BoxFit.contain,),

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

            Padding(
              padding: const EdgeInsets.only(left: 15,right: 15),
              child: Text("Event video",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.8),
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
            ),

            GestureDetector(
              onTap: ()
              {
                setState(() {
                  _tap = true;
                });
              },
              child: Container(
                margin: const EdgeInsets.only(top: 10,bottom: 15,left: 15,right: 15),
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

            Padding(
              padding: const EdgeInsets.only(left: 15,right: 15),
              child: Text("Ticketing / Registration",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.8),
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //Free Entry Row
                  GestureDetector(

                    onTap: () {

                      showDialog(
                        useSafeArea: true,
                          context: context,

                          builder: (BuildContext context)
                          {
                            return TicketingDialog(tName: "Free Ticket",tNumber: "100",tPrice: "Price of ticket",);
                          }
                      );

                      setState(() {
                        freeEntry = !freeEntry;
                        paidEntry = false;
                        donationTicket = false;
                      });


                    },
                    child: Padding(
                      padding:
                      const EdgeInsets.only(bottom: 10, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            freeEntry
                                ? Icons.check_circle
                                : Icons.circle_outlined,
                            size: 22,
                            color: Colors.black.withOpacity(0.6),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Free Entry",
                            style: TextStyle(
                              fontSize: 12,
                                fontWeight: freeEntry
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: Colors.black.withOpacity(0.8)),
                          )
                        ],
                      ),
                    ),
                  ),

                  //Paid Ticket Row
                  GestureDetector(
                    onTap: () {

                      showDialog(
                          useSafeArea: true,
                          context: context,

                          builder: (BuildContext context)
                          {
                            return TicketingDialog(tName: "Standard Ticket",tNumber: "100",tPrice: "Price of ticket",);
                          }
                      );

                      setState(() {
                        paidEntry = !paidEntry;
                        freeEntry = false;
                        donationTicket = false;
                      });
                    },
                    child: Padding(
                      padding:
                      const EdgeInsets.only(bottom: 10, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            paidEntry
                                ? Icons.check_circle
                                : Icons.circle_outlined,
                            size: 22,
                            color: Colors.black.withOpacity(0.6),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Paid Entry",
                            style: TextStyle(
                                fontSize: 12,

                                fontWeight: paidEntry
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: Colors.black.withOpacity(0.8)),
                          )
                        ],
                      ),
                    ),
                  ),

                  //donationTicket Row
                  GestureDetector(
                    onTap: () {

                      showDialog(
                          useSafeArea: true,
                          context: context,

                          builder: (BuildContext context)
                          {
                            return TicketingDialog(tName: "Donation Ticket",tNumber: "100",tPrice: "Price of ticket",);
                          }
                      );

                      setState(() {
                        donationTicket = !donationTicket;
                        paidEntry = false;
                        freeEntry = false;
                      });
                    },
                    child: Padding(
                      padding:
                      const EdgeInsets.only(bottom: 10, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            donationTicket
                                ? Icons.check_circle
                                : Icons.circle_outlined,
                            size: 22,
                            color: Colors.black.withOpacity(0.6),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Donation Ticket",
                            style: TextStyle(
                                fontSize: 12,

                                fontWeight: donationTicket
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: Colors.black.withOpacity(0.8)),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 15,right: 15,bottom: 15),
              child: Row(
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
            )

          ],
        ),
      ),
    );
  }
}
