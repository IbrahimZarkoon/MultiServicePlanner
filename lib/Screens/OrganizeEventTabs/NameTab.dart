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

  bool _tap = false;
  bool freeEntry = false;
  bool paidEntry = false;
  bool donationTicket = false;

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
                      Container(
                        margin: EdgeInsets.only(left: 15, right: 15, top: 15,bottom: MediaQuery.of(context).size.height*0.12),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.2,
                        decoration: BoxDecoration(
                            color: const Color(0xffe5e5e5),
                            borderRadius: BorderRadius.circular(3),
                            image: const DecorationImage(
                                image: NetworkImage(
                                    "https://img.icons8.com/?size=512&id=bjHuxcHTNosO&format=png"),
                                fit: BoxFit.contain),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  offset: const Offset(0, 0),
                                  spreadRadius: 1,
                                  blurRadius: 1.5)
                            ]),
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
                                          // final imageTemp = File(image.path);
                                          //setState(() => Provider.of<UserClass>(context).profilePicture = imageTemp);
                                        },
                                        child: const Text("Choose Photo")),

                                    CupertinoActionSheetAction(
                                        onPressed: () async {
                                          final XFile? photo = await _BannerPicker.pickImage(source: ImageSource.camera);
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
                                      color: const Color(0xffe5e5e5),
                                      borderRadius: BorderRadius.circular(3),
                                      image: const DecorationImage(
                                          image: NetworkImage(
                                              "https://img.icons8.com/?size=512&id=bjHuxcHTNosO&format=png"),
                                          fit: BoxFit.contain),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black.withOpacity(0.2),
                                            offset: const Offset(0, 0),
                                            spreadRadius: 1,
                                            blurRadius: 1.5)
                                      ]),
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
                                                // final imageTemp = File(image.path);
                                                //setState(() => Provider.of<UserClass>(context).profilePicture = imageTemp);
                                              },
                                              child: const Text("Choose Photo")),

                                          CupertinoActionSheetAction(
                                              onPressed: () async {
                                                final XFile? photo = await _BannerPicker.pickImage(source: ImageSource.camera);
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

                Text("Ticketing / Registration",
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
                      //Free Entry Row
                      InkWell(

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

                      //Paid Ticket Row
                      InkWell(
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

                      //donationTicket Row
                      InkWell(
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
                    ],
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

                const SizedBox(height: 10,),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
