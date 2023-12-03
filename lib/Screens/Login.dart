import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Enums/Colors.dart';
import '../Organizer/OrganizerLogin.dart';
import 'Dashboard.dart';
import 'Register.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailCtrl = TextEditingController();
  TextEditingController _passCtrl = TextEditingController();

  FocusNode _emailNode = FocusNode();
  FocusNode _passNode = FocusNode();

  bool obPass = true;

  double positionedTop = -350;

  bool rememberMe = false;
  void SignInButton(context) async {
    print("SIGIN FUNC");
    try {
      var url = await Uri.parse(
          'https://everythingforpageants.com/msp/api/login.php');
      var response = await http.post(url,
          body: json.encode({
            "email": _emailCtrl.text,
            "password": _passCtrl.text,
            "role": "1"
          }));
      print(response.body);
      var decodedJson = jsonDecode(response.body) as Map<String, dynamic>;
      // _signInApiResponse = SignInResp.fromJson(decodedJson);

      if (decodedJson["Status"] == "200") {
        Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (BuildContext context) => DashboardPage(
                      userTabIndex: 0,
                    )));
      }
    } catch (e) {
      print("An error occurred: $e");
      final snackBar = SnackBar(
        content: Text("Invalid email or password"),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.symmetric(
            horizontal: 30, vertical: 0), // Adjust margin as needed
        duration: Duration(seconds: 3), // Adjust the duration as needed
      );

      // Show the custom Snackbar
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    Timer(const Duration(milliseconds: 400), () {
      setState(() {
        positionedTop = 0;
      });
    });

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
            children: [
              GestureDetector(
                onTap: () {
                  _emailNode.unfocus();
                  _passNode.unfocus();
                },
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  foregroundDecoration: BoxDecoration(
                    color: Colors.white,
                    gradient: LinearGradient(
                        stops: const [0.0, 0.7],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.5)
                        ]),
                  ),
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/userLogin.jpg"),
                          fit: BoxFit.fitHeight,
                          //alignment: Alignment.topCenter,
                          filterQuality: FilterQuality.high)),
                ),
              ),
              AnimatedPositioned(
                  curve: Curves.easeInOut,
                  left: 0,
                  right: 0,
                  bottom: positionedTop,
                  duration: const Duration(milliseconds: 1000),
                  child: AnimatedContainer(
                    curve: Curves.easeInOut,
                    width: MediaQuery.of(context).size.width,
                    //height: MediaQuery.of(context).size.height*0.4,
                    decoration: const BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30))),
                    duration: const Duration(milliseconds: 1000),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      //crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              top: 20, bottom: 40, left: 15, right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text("Welcome Back!",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontFamily: "",
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 35)),
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
                          constraints: const BoxConstraints(maxHeight: 55),
                          margin: const EdgeInsets.only(
                              left: 15, right: 15, bottom: 15),
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(
                              left: 15, top: 0, bottom: 0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                  color: Colors.white.withOpacity(1))),

                          child: TextField(
                            controller: _emailCtrl,
                            focusNode: _emailNode,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(left: 5),

                              border: InputBorder.none,
                              hintText: "Username / Email",
                              hintStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.8),
                                  fontSize: 12),
                              icon: Icon(
                                CupertinoIcons.person,
                                color: Colors.black.withOpacity(0.8),
                              ),
                              //suffixIcon: Icon(CupertinoIcons.eye,color: Colors.black.withOpacity(0.5),)
                              //helperText: "Email Address"
                              //labelText: "Email Address"
                            ),
                          ),
                        ),

                        //Password Container
                        Container(
                          //height: MediaQuery.of(context).size.height*0.075,
                          constraints: const BoxConstraints(maxHeight: 55),
                          margin: const EdgeInsets.only(
                              left: 15, right: 15, bottom: 15),
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(
                              left: 15, top: 0, bottom: 0, right: 15),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                  color: Colors.white.withOpacity(1))),

                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _passCtrl,
                                  focusNode: _passNode,
                                  obscureText: obPass,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        const EdgeInsets.only(left: 5),

                                    border: InputBorder.none,
                                    hintText: "Password",
                                    hintStyle: TextStyle(
                                        color: Colors.black.withOpacity(0.8),
                                        fontSize: 12),
                                    icon: Icon(
                                      CupertinoIcons.lock,
                                      color: Colors.black.withOpacity(0.8),
                                    ),

                                    //suffixIcon: Icon(CupertinoIcons.eye,color: Colors.black.withOpacity(0.5),)
                                    //helperText: "Email Address"
                                    //labelText: "Email Address"
                                  ),
                                ),
                              ),
                              InkWell(
                                  onTap: () {
                                    setState(() {
                                      obPass = !obPass;
                                    });
                                  },
                                  child: Icon(
                                    obPass
                                        ? CupertinoIcons.eye
                                        : CupertinoIcons.eye_fill,
                                    color: Colors.black.withOpacity(0.5),
                                  )),
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
                          padding: const EdgeInsets.only(left: 15, right: 15),
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

                              Text(
                                "Forgot password",
                                style: TextStyle(
                                    color: appPrimary,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),

                        //Login Container
                        GestureDetector(
                          onTap: () {
                            SignInButton(context);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                                left: 15, right: 15, top: 15, bottom: 15),
                            padding: const EdgeInsets.only(top: 15, bottom: 15),
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
                              color: appPrimary,
                            ),
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),

                        //Login as Org Container
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const OrganizerLogin()));
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                                left: 15, right: 15, top: 0, bottom: 15),
                            padding: const EdgeInsets.only(top: 15, bottom: 15),
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
                            child: const Text(
                              "Continue as a vendor",
                              style: TextStyle(
                                  color: appPrimary,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),

                        //const SizedBox(height: 15,),

                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const Register()));
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 15),
                            child: RichText(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              text: const TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Not register yet? ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontFamily: "",
                                        color: Colors.white),
                                  ),
                                  TextSpan(
                                    style: TextStyle(
                                        color: appPrimary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                    text: 'Create Account',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ))
            ]),
      ),
    );
  }
}
