import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socialapp/Organizer/OrgScreens/Dashboard.dart';
import 'package:socialapp/Organizer/RegisterOrganizer.dart';
import 'package:socialapp/Screens/Login.dart';

import '../CustomWidgets/Headings.dart';
import '../Screens/Dashboard.dart';
import '../Screens/Register.dart';

class OrganizerLogin extends StatefulWidget {
  const OrganizerLogin({Key? key}) : super(key: key);

  @override
  State<OrganizerLogin> createState() => _OrganizerLoginState();
}

class _OrganizerLoginState extends State<OrganizerLogin> {
  TextEditingController _emailCtrl = TextEditingController();
  TextEditingController _passCtrl = TextEditingController();

  FocusNode _emailNode = FocusNode();
  FocusNode _passNode = FocusNode();

  bool obPass = true;


  double positionedTop = -350;

  bool rememberMe = false;

  @override
  void initState() {
    // TODO: implement initState

    Timer(const Duration(milliseconds: 400), () { setState(() {
      positionedTop = 0;
    }); });


    super.initState();

  }

  Future<void> _preloadImage(BuildContext context) async {
    var _var = await precacheImage(
      const AssetImage('assets/images/colorful-light-show-is-lit-up-club.jpg'),
      context,
    );


  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Stack(
          //fit: StackFit.expand,
            children:[ GestureDetector(
              onTap: ()
              {
                _emailNode.unfocus();
                _passNode.unfocus();
              },
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                foregroundDecoration:  BoxDecoration(
                  gradient: LinearGradient(
                      stops: [0.0,1],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.75)
                      ]),
                ),
                decoration: const BoxDecoration(

                    image: DecorationImage(
                        image: AssetImage("assets/images/OrgLogin2.jpg"),
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                        filterQuality: FilterQuality.high
                    )
                ),
              ),
            ),

              AnimatedPositioned(

                  curve: Curves.easeInOut,
                  left: 0,right: 0,bottom: positionedTop,
                  duration: const Duration(milliseconds: 1000),
                  child: AnimatedContainer(
                    curve: Curves.easeInOut,
                    width: MediaQuery.of(context).size.width,
                    //height: MediaQuery.of(context).size.height*0.4,
                    decoration: const BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30))
                    ),
                    duration: const Duration(milliseconds: 1000),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      //crossAxisAlignment: CrossAxisAlignment.start,

                      children: [

                        Container(
                          padding: const EdgeInsets.only(top: 20,bottom: kToolbarHeight , left:15 , right:15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:  [

                              const Text("Welcome Organizer!",overflow: TextOverflow.ellipsis,
                                  style:
                                  TextStyle(fontFamily: "",color: Colors.white,fontWeight: FontWeight.bold, fontSize: 35)),
                            ],
                          ),
                        ),

                        // Padding(
                        //   padding: const EdgeInsets.only(left: 15,right: 15,bottom: 15),
                        //   child: Text("Sign in to your account",style: TextStyle(
                        //       color: Colors.black.withOpacity(0.6),
                        //       fontSize: 12
                        //   ),),
                        // ),

                        //Email Container
                        Container(
                          //height: MediaQuery.of(context).size.height*0.075,
                          constraints: const BoxConstraints(
                              maxHeight: 55
                          ),
                          margin: const EdgeInsets.only(left: 15,right: 15,bottom: 15),
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(left: 15,top: 0,bottom: 0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.white.withOpacity(1))
                          ),

                          child:  TextField(
                            focusNode: _emailNode,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(left: 5),

                              border: InputBorder.none,
                              hintText: "Email Address",
                              hintStyle: TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 12),
                              icon: Icon(CupertinoIcons.person,color: Colors.black.withOpacity(0.8),),
                              //suffixIcon: Icon(CupertinoIcons.eye,color: Colors.black.withOpacity(0.5),)
                              //helperText: "Email Address"
                              //labelText: "Email Address"
                            ),
                          ),
                        ),

                        //Password Container
                        Container(
                          //height: MediaQuery.of(context).size.height*0.075,
                          constraints: const BoxConstraints(
                              maxHeight: 55
                          ),
                          margin: const EdgeInsets.only(left: 15,right: 15,bottom: 15),
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(left: 15,top: 0,bottom: 0,right: 15),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.white.withOpacity(1))
                          ),

                          child:  Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  focusNode: _passNode,
                                  obscureText: obPass,

                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.only(left: 5),

                                    border: InputBorder.none,
                                    hintText: "Password",
                                    hintStyle: TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 12),
                                    icon: Icon(CupertinoIcons.lock,color: Colors.black.withOpacity(0.8),),

                                    //suffixIcon: Icon(CupertinoIcons.eye,color: Colors.black.withOpacity(0.5),)
                                    //helperText: "Email Address"
                                    //labelText: "Email Address"
                                  ),
                                ),


                              ),

                              InkWell(
                                  onTap: ()
                                  {
                                    setState(() {
                                      obPass = !obPass;
                                    });
                                  },
                                  child: Icon(obPass? CupertinoIcons.eye : CupertinoIcons.eye_fill,color: Colors.black.withOpacity(0.5),)),
                            ],
                          ),
                        ),
                        // Container(
                        //   constraints: BoxConstraints(
                        //       maxHeight: 55
                        //   ),
                        //   margin: const EdgeInsets.only(left: 15,right: 15,bottom: 15),
                        //   width: MediaQuery.of(context).size.width,
                        //   padding: const EdgeInsets.only(left: 15,top: 0,bottom: 0,right: 15),
                        //   decoration: BoxDecoration(
                        //       color: Colors.white,
                        //       borderRadius: BorderRadius.circular(30),
                        //       border: Border.all(color: Colors.white.withOpacity(1))
                        //   ),
                        //
                        //   child: TextField(
                        //     obscureText: obPass,
                        //     focusNode: _passNode,
                        //     decoration: InputDecoration(
                        //         contentPadding: EdgeInsets.only(left: 5),
                        //         border: InputBorder.none,
                        //         hintText: "Password",
                        //         hintStyle: TextStyle(
                        //
                        //         ),
                        //         icon: const Icon(CupertinoIcons.lock),
                        //
                        //       //helperText: "Email Address"
                        //       //labelText: "Email Address"
                        //     ),
                        //   ),
                        // ),

                        //Remember me / Forget pass Row
                        Container(
                          padding: const EdgeInsets.only(left: 15,right: 15),

                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,

                            children: [

                              // CupertinoSwitch(
                              //     activeColor: Color(0xff84ce41),
                              //     value: rememberMe, onChanged: (value){
                              //
                              //   setState(() {
                              //     rememberMe = value;
                              //   });
                              // } ),

                              const Spacer(),

                              Text("Forgot password",style: TextStyle(color: Colors.white.withOpacity(1),fontWeight: FontWeight.bold),)
                            ],
                          ),
                        ),

                        //Login Container
                        GestureDetector(
                          onTap: ()
                          {
                            Navigator.push(context, CupertinoPageRoute(builder: (BuildContext context) => OrgDashboard(orgTabIndex: 0,)));
                          },
                          child: Container(
                            margin: const EdgeInsets.only(left: 15,right: 15,top: 15,bottom: 15),
                            padding: const EdgeInsets.only(top: 15,bottom: 15),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(

                                borderRadius: BorderRadius.circular(30),

                                // gradient: LinearGradient(
                                //     begin: Alignment.centerLeft,
                                //     end: Alignment.centerRight,
                                //     stops: [0.01,0.2],
                                //     colors: [
                                //   Colors.white,
                                //   Color(0xffda291c)
                                // ]),
                                color: const Color(0xffff1f6f)
                            ),
                            child: const Text("Login",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                          ),
                        ),

                        //Login as Org Container
                        GestureDetector(
                          onTap: ()
                          {
                            Navigator.push(context, CupertinoPageRoute(builder: (BuildContext context) => const Login()));
                          },
                          child: Container(
                            margin: const EdgeInsets.only(left: 15,right: 15,top: 0,bottom: 15),
                            padding: const EdgeInsets.only(top: 15,bottom: 15),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(

                              borderRadius: BorderRadius.circular(30),

                              // gradient: LinearGradient(
                              //     begin: Alignment.centerLeft,
                              //     end: Alignment.centerRight,
                              //     stops: [0.01,0.2],
                              //     colors: [
                              //   Colors.white,
                              //   Color(0xffda291c)
                              // ]),
                              color: Colors.white,
                            ),
                            child: const Text("Continue as a user",style: TextStyle(color: Color(0xffff1f6f),fontWeight: FontWeight.bold),),
                          ),
                        ),

                        //Signup Container
                        Padding(
                          padding: const EdgeInsets.only(left: 15,right: 15),
                          child: Row(
                            children: [

                              Expanded(child: shadowLine(context)),

                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(top: 15,bottom: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,

                                    children: [

                                      Text("or continue with",style: TextStyle(color: Colors.white.withOpacity(1),fontSize: 12),),
                                    ],
                                  ),
                                ),
                              ),

                              Expanded(child: shadowLine(context))
                            ],
                          ),
                        ),

                        //Google,Facebook,Twitter Row
                        Container(
                          margin: const EdgeInsets.only(top: 5,bottom: 5),
                          child: Row(

                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.max,

                            children: [

                              //Google Row
                              Container(
                                constraints: const BoxConstraints(
                                  minWidth: 100,
                                ),
                                padding: const EdgeInsets.only(left: 10,right: 10,top: 8,bottom: 8),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 25,
                                      height: 25,
                                      margin: const EdgeInsets.only(right: 10),
                                      decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  "https://static-00.iconduck.com/assets.00/google-icon-2048x2048-czn3g8x8.png"
                                              )
                                          )
                                      ),
                                    ),

                                    Text("Google",
                                      style: TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 12,fontFamily: "",fontWeight: FontWeight.bold),),
                                  ],
                                ),
                              ),

                              //Facebook Row
                              Container(
                                constraints: const BoxConstraints(
                                  minWidth: 100,
                                ),
                                padding: const EdgeInsets.only(left: 10,right: 10,top: 8,bottom: 8),

                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 25,
                                      height: 25,
                                      margin: const EdgeInsets.only(right: 10),
                                      decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  "https://www.edigitalagency.com.au/wp-content/uploads/Facebook-logo-blue-circle-large-transparent-png.png"
                                              )
                                          )
                                      ),
                                    ),

                                    Text("Facebook",
                                      style: TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 12,fontFamily: "",fontWeight: FontWeight.bold),),
                                  ],
                                ),
                              ),

                              //Twitter Row
                              Container(
                                constraints: const BoxConstraints(
                                  minWidth: 100,
                                ),
                                padding: const EdgeInsets.only(left: 10,right: 10,top: 8,bottom: 8),

                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 25,
                                      height: 25,
                                      margin: const EdgeInsets.only(right: 10),
                                      decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/Logo_of_Twitter.svg/512px-Logo_of_Twitter.svg.png?20220821125553"
                                              )
                                          )
                                      ),
                                    ),

                                    Text("Twitter",
                                      style: TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 12,fontFamily: "",fontWeight: FontWeight.bold),),
                                  ],
                                ),
                              ),


                            ],
                          ),
                        ),

                        const SizedBox(height: 15,),

                        InkWell(
                          onTap: ()
                          {
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>  const RegisterOrganizer()));
                          },
                          child: RichText(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            text: const TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Not registered yet ? ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontFamily: "",
                                      color: Colors.white),
                                ),
                                TextSpan(
                                  style: TextStyle(
                                      color: Color(0xffff1f6f),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                  text:
                                  'Register Organizer',
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 30,),


                      ],
                    ),
                  ))

            ]
        ),
      ),
    );
  }
}
