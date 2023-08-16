import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../CustomWidgets/Headings.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff1f3f6),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 18,horizontal: 18),
            child: Text("Back",style: TextStyle(color: Color(0xff009ed9),fontSize: 14),),
          ),
        ),
        leadingWidth: 0,
        title: Text("Settings",
          style: TextStyle(color: Colors.black.withOpacity(0.8),fontFamily: "Helvetica_Bold",fontSize: 14),),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () => Navigator.pop(context),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 18,horizontal: 18),
              child: Text("Save",style: TextStyle(color: Color(0xff009ed9),fontSize: 14),),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [


            //Preferences
            Container(
              margin: const EdgeInsets.only(top: 30),
              //color: Colors.red,
              width: MediaQuery.of(context).size.width,
              //height: MediaQuery.of(context).size.height*0.4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  //Headings
                  Padding(
                    padding: const EdgeInsets.only(left: 15,bottom: 15),
                    child: Text("PREFERENCES",
                      style: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: 11,fontFamily: "Helvetica_Bold"),),
                  ),

                  shadowLine(context),

                  Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [


                        //Push notifications
                        Container(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Text("Push notifications",
                                style: TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 14,fontFamily: ""),),


                              CupertinoSwitch(
                                  value: true,
                                  thumbColor: Colors.white,
                                  trackColor: Colors.black.withOpacity(0.25),
                                  activeColor: const Color(0xff009ed9),
                                  onChanged: (value){

                                  })
                            ],
                          ),
                        ),

                        //Shadow Line
                        Padding(
                          padding: const EdgeInsets.only(left: 15,right: 15),
                          child: shadowLine(context),
                        ),

                        Container(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Text("Email updates",
                                style: TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 14,fontFamily: ""),),


                              CupertinoSwitch(
                                  value: true,
                                  thumbColor: Colors.white,
                                  trackColor: Colors.black.withOpacity(0.25),
                                  activeColor: const Color(0xff009ed9),
                                  onChanged: (value){

                                  })
                            ],
                          ),
                        ),

                        shadowLine(context)


                      ],
                    ),
                  ),

                ],
              ),
            ),

            //Organizing
            Container(
              margin: const EdgeInsets.only(top: 30),
              //color: Colors.red,
              width: MediaQuery.of(context).size.width,
              //height: MediaQuery.of(context).size.height*0.4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  //Headings
                  Padding(
                    padding: const EdgeInsets.only(left: 15,bottom: 15),
                    child: Text("ORGANIZING",
                      style: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: 11,fontFamily: "Helvetica_Bold"),),
                  ),

                  shadowLine(context),

                  Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [


                        //Organizer subscription
                        Container(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Text("Organizer subscription",
                                style: TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 14,fontFamily: ""),),


                              Icon(Icons.arrow_forward_ios,color: Colors.black.withOpacity(0.4),size: 18,)

                            ],
                          ),
                        ),

                        //Shadow Line
                        Padding(
                          padding: const EdgeInsets.only(left: 15,right: 15),
                          child: shadowLine(context),
                        ),

                        Container(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Text("Start a new group",
                                style: TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 14,fontFamily: ""),),



                            ],
                          ),
                        ),

                        shadowLine(context)


                      ],
                    ),
                  ),

                ],
              ),
            ),

            //SUPPORT
            Container(
              margin: const EdgeInsets.only(top: 30),
              //color: Colors.red,
              width: MediaQuery.of(context).size.width,
              //height: MediaQuery.of(context).size.height*0.4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  //Headings
                  Padding(
                    padding: const EdgeInsets.only(left: 15,bottom: 15),
                    child: Text("SUPPORT",
                      style: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: 11,fontFamily: "Helvetica_Bold"),),
                  ),

                  shadowLine(context),

                  Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [


                        //About us
                        Container(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Text("About Us",
                                style: TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 14,fontFamily: ""),),


                              Icon(Icons.arrow_forward_ios,color: Colors.black.withOpacity(0.4),size: 18,)

                            ],
                          ),
                        ),

                        //Shadow Line
                        Padding(
                          padding: const EdgeInsets.only(left: 15,right: 15),
                          child: shadowLine(context),
                        ),

                        Container(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Text("Get help",
                                style: TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 14,fontFamily: ""),),



                            ],
                          ),
                        ),

                        //Shadow Line
                        Padding(
                          padding: const EdgeInsets.only(left: 15,right: 15),
                          child: shadowLine(context),
                        ),

                        Container(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Text("Give us feedback",
                                style: TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 14,fontFamily: ""),),



                            ],
                          ),
                        ),

                        //Shadow Line
                        Padding(
                          padding: const EdgeInsets.only(left: 15,right: 15),
                          child: shadowLine(context),
                        ),

                        Container(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Text("Rate us",
                                style: TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 14,fontFamily: ""),),



                            ],
                          ),
                        ),

                        shadowLine(context)


                      ],
                    ),
                  ),

                ],
              ),
            ),

            const SizedBox(height: 30,),

            shadowLine(context),

            //Logout Con
            Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [

                  Text("Log out",
                    style: TextStyle(color: Color(0xff009ed9),fontSize: 14,fontFamily: ""),),



                ],
              ),
            ),

            shadowLine(context),

            const SizedBox(height: 30,),

            shadowLine(context),
            
            //Deactivate your Acc Con
            Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Text("Deactivate your account",
                    style: TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 14,fontFamily: ""),),



                ],
              ),
            ),

            shadowLine(context),

            Padding(
              padding: const EdgeInsets.only(left: 15,right: 15,bottom: 0,top: 5),
              child: Text("This will close your account, but keep your information. Groups will not be deleted and ownership will change. You can reactivate your account by signing in.",
                style: TextStyle(color: Colors.black.withOpacity(0.6),fontSize: 12),),
            ),

            const SizedBox(height: 30,),

            shadowLine(context),

            //Delete acc Con
            Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [

                  Text("Delete account and personal information",
                    style: TextStyle(color: Color(0xffdc4141),fontSize: 14,fontFamily: ""),),



                ],
              ),
            ),

            shadowLine(context),

            Padding(
              padding: const EdgeInsets.only(left: 15,right: 15,bottom: 0,top: 5),
              child: Text("This will permanently close your account and erase all of your personal information.",
                style: TextStyle(color: Colors.black.withOpacity(0.6),fontSize: 12),),
            ),


            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 30,bottom: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Text("Techonza v.2023.0.1 (74700)",style:
                  TextStyle(color: Colors.black.withOpacity(0.6),fontSize: 12),),

                  Text("©2023 Techonza LLC",style:
                    TextStyle(color: Colors.black.withOpacity(0.6),fontSize: 12),),
                ],
              ),
            )


          ],
        ),
      ),

    );
  }
}
