import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socialapp/CustomWidgets/Headings.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
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
            child: Text("Cancel",style: TextStyle(color: Color(0xff009ed9),fontSize: 14),),
          ),
        ),
        leadingWidth: 100,
        title: Text("Edit profile",
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
            
            //Top Container
            Container(
              padding: const EdgeInsets.only(top: 20,bottom: 20),
              width: MediaQuery.of(context).size.width,
              //height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                
                children: [
                  
                  //Image Container
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: const Color(0xfff1f1f1),
                      borderRadius: BorderRadius.circular(100),
                      image: const DecorationImage(image: NetworkImage(
                        "https://w0.peakpx.com/wallpaper/794/29/HD-wallpaper-best-whatsapp-dp-boy-walking-alone-birds.jpg"
                      ),
                      fit: BoxFit.cover)
                    ),
                  ),

                  const Text("Change photo",style: TextStyle(
                    color: Color(0xff009ed9),
                    fontFamily: "Helvetica_Bold",fontSize: 13
                  ),)

                ],
              ),
            ),

            //Account Info
            Container(
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
                    child: Text("ACCOUNT INFO",
                    style: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: 13,fontFamily: "Helvetica_Bold"),),
                  ),

                  shadowLine(context),

                  Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [


                        //Name Container
                        Container(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Text("Name",
                                style: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: 12,fontFamily: "Helvetica_Bold"),),

                              const SizedBox(height: 10,),

                              Text("Ibrahim Khan Zarkoon",
                                style: TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 14,fontFamily: ""),),

                            ],
                          ),
                        ),

                        //Shadow Line
                        Padding(
                          padding: const EdgeInsets.only(left: 15,right: 15),
                          child: shadowLine(context),
                        ),

                        //Location Container
                        Container(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Text("Location",
                                    style: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: 12,fontFamily: "Helvetica_Bold"),),

                                  const SizedBox(height: 10,),

                                  Text("APO",
                                    style: TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 14,fontFamily: ""),),

                                ],
                              ),
                              
                              Icon(Icons.arrow_forward_ios,color: Colors.black.withOpacity(0.4),size: 18,)
                            ],
                          ),
                        ),

                        //Shadow Line
                        Padding(
                          padding: const EdgeInsets.only(left: 15,right: 15),
                          child: shadowLine(context),
                        ),

                        //Email Container
                        Container(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Text("Email",
                                    style: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: 12,fontFamily: "Helvetica_Bold"),),

                                  const SizedBox(height: 10,),

                                  Text("ibrahimkhanzarkoon@techonza.com",
                                    style: TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 14,fontFamily: ""),),

                                ],
                              ),

                              Icon(Icons.arrow_forward_ios,color: Colors.black.withOpacity(0.4),size: 18,)
                            ],
                          ),
                        ),
                        
                        shadowLine(context)


                      ],
                    ),
                  )
                ],
              ),
            ),

            //Additional info
            Container(
              margin: const EdgeInsets.only(top: 50),
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
                    child: Text("ADDITIONAL INFO",
                      style: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: 13,fontFamily: "Helvetica_Bold"),),
                  ),

                  shadowLine(context),

                  Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [


                        //Birthdate Container
                        Container(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Text("Birthdate",
                                style: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: 12,fontFamily: "Helvetica_Bold"),),

                              const SizedBox(height: 10,),

                              Text("MM/DD/YYYY",
                                style: TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 14,fontFamily: ""),),

                            ],
                          ),
                        ),

                        //Shadow Line
                        Padding(
                          padding: const EdgeInsets.only(left: 15,right: 15),
                          child: shadowLine(context),
                        ),

                        //Gender Container
                        Container(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Text("Gender",
                                style: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: 12,fontFamily: "Helvetica_Bold"),),

                              const SizedBox(height: 10,),

                              Text("Male",
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
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Text("What you're looking for",
                                    style: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: 12,fontFamily: "Helvetica_Bold"),),

                                  const SizedBox(height: 10,),

                                  Text("Select options",
                                    style: TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 14,fontFamily: ""),),

                                ],
                              ),

                              Icon(Icons.arrow_forward_ios,color: Colors.black.withOpacity(0.4),size: 18,)

                            ],
                          ),
                        ),

                        //Shadow Line
                        Padding(
                          padding: const EdgeInsets.only(left: 15,right: 15),
                          child: shadowLine(context),
                        ),

                        //Interest Container
                        Container(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Text("Edit Interests",
                                style: TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 14,fontFamily: ""),),

                              Icon(Icons.arrow_forward_ios,color: Colors.black.withOpacity(0.4),size: 18,)
                            ],
                          ),
                        ),

                        shadowLine(context)


                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 15,right: 15,bottom: 0,top: 5),
                    child: Text("This helps improve your recommendations, and unlocks event and group insights.",
                    style: TextStyle(color: Colors.black.withOpacity(0.6),fontSize: 12),),
                  )
                ],
              ),
            ),

            //Privacy Con
            Container(
              margin: const EdgeInsets.only(top: 50),
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
                    child: Text("PRIVACY",
                      style: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: 13,fontFamily: "Helvetica_Bold"),),
                  ),

                  shadowLine(context),

                  Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [


                        //Show groups on profile Container
                        Container(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Text("Show groups on profile",
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

                        //Show interests on profile Container
                        Container(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Show interests on profile",
                                      style: TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 14,fontFamily: ""),),

                                    const SizedBox(height: 10,),

                                    Text("Making your interests public allows you to view shared interests in event and group insights",
                                      style: TextStyle(color: Colors.black.withOpacity(0.6),fontSize: 12),),
                                  ],
                                ),
                              ),

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
          ],
        ),
      ),
    );
  }
}
