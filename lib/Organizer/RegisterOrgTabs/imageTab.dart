
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../modals/RegisterOrgProvider.dart';

class imageTab extends StatefulWidget {
  const imageTab({Key? key}) : super(key: key);

  @override
  State<imageTab> createState() => _imageTabState();
}

class _imageTabState extends State<imageTab> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<Offset> _animation;

  final ImagePicker _BannerPicker = ImagePicker();

  File? frontIMGFile;
  File? backIMGFile;




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
    var regOrgProv = Provider.of<RegisterOrgProvider>(context,listen: false);


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

              Text("Confirm Front side",
                style: TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 24,fontFamily: "Helvetica_Bold"),),

              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  //Front Side
                  Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 0, right: 0, top: 15,bottom: 15),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.2,
                          decoration: BoxDecoration(
                              color: const Color(0xffffffff),
                              borderRadius: BorderRadius.circular(3),
                              // image: const  DecorationImage(
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
                          child: frontIMGFile != null ? Image.file(frontIMGFile!) : Image.network("https://img.icons8.com/?size=512&id=bjHuxcHTNosO&format=png",fit: BoxFit.contain,),
                        ),

                        Positioned(
                            top: 15,right: 0,
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
                                              frontIMGFile = imageTemp;// Assign to the File variable
                                              regOrgProv.nicFront = imageTemp;
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
                                              frontIMGFile = imageTemp; // Assign to the File variable
                                              regOrgProv.nicFront = imageTemp;

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
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 1,
                                        blurRadius: 1.5,
                                        offset: const Offset(-1,1)
                                      )
                                    ],
                                    borderRadius: const BorderRadius.only(topRight: Radius.circular(3),bottomLeft: Radius.circular(3))

                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [

                                    Icon(CupertinoIcons.camera,size: 20,color: Colors.black.withOpacity(0.6),),

                                    const SizedBox(width: 10,),

                                    Text("Upload photo",style: TextStyle(
                                        color: Colors.black.withOpacity(0.8),fontSize: 12,fontFamily: "Helvetica_Bold"
                                    ),)
                                  ],
                                ),
                              ),
                            )),

                      ]
                  ),




                ],
              ),

              const SizedBox(height: 10,),

              Text("Confirm Back side",
                style: TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 24,fontFamily: "Helvetica_Bold"),),

              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  //Front Side
                  Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 0, right: 0, top: 15,bottom: 15),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.2,
                          decoration: BoxDecoration(
                              color: const Color(0xffffffff),
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
                          child: backIMGFile != null ? Image.file(backIMGFile!) : Image.network("https://img.icons8.com/?size=512&id=bjHuxcHTNosO&format=png",fit: BoxFit.contain,),

                        ),

                        Positioned(
                            top: 15,right: 0,
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
                                              backIMGFile = imageTemp; // Assign to the File variable
                                              regOrgProv.nicBack = imageTemp;

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
                                              backIMGFile = imageTemp; // Assign to the File variable
                                              regOrgProv.nicBack = imageTemp;

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
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          spreadRadius: 1,
                                          blurRadius: 1.5,
                                          offset: const Offset(-1,1)
                                      )
                                    ],
                                    borderRadius: const BorderRadius.only(topRight: Radius.circular(3),bottomLeft: Radius.circular(3))

                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [

                                    Icon(CupertinoIcons.camera,size: 20,color: Colors.black.withOpacity(0.6),),

                                    const SizedBox(width: 10,),

                                    Text("Upload photo",style: TextStyle(
                                        color: Colors.black.withOpacity(0.8),fontSize: 12,fontFamily: "Helvetica_Bold"
                                    ),)
                                  ],
                                ),
                              ),
                            )),

                      ]
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
