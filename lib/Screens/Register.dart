import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../CustomWidgets/Headings.dart';
import '../Enums/Colors.dart';
import 'Dashboard.dart';
import 'Login.dart';
import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController _emailCtrl = TextEditingController();
  TextEditingController _nameCtrl = TextEditingController();
  TextEditingController _passCtrl = TextEditingController();

  FocusNode _emailNode = FocusNode();
  FocusNode _passNode = FocusNode();

  bool obPass = true;

  double positionedTop = -350;

  bool rememberMe = false;

  void SignUpButton(context) async {
    try {
      Uri url =
          Uri.parse('https://everythingforpageants.com/msp/api/signup.php');

      var formData = http.MultipartRequest('POST', url);
      formData.fields.addAll({
        "fullName": _nameCtrl.text,
        "email": _emailCtrl.text,
        "password": _passCtrl.text,
        "role": "1",
      });

      var response = await formData.send();

      var responseBody = await response.stream.bytesToString();
      print(responseBody);

      var decodedJson = jsonDecode(responseBody) as Map<String, dynamic>;
      if (decodedJson["Status"] == "200") {
        Navigator.push(context,
            CupertinoPageRoute(builder: (BuildContext context) => Login()));
      }
    } catch (e) {
      print("An error occurred: $e");
      final snackBar = SnackBar(
        content: Text("SignUp Failed"),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Stack(children: [
          GestureDetector(
            onTap: () {
              _emailNode.unfocus();
              _passNode.unfocus();
            },
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              foregroundDecoration: BoxDecoration(
                gradient: LinearGradient(
                    stops: const [0.0, 0.5],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.55)
                    ]),
              ),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/userLogin.jpg"),
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
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
                          top: 20, bottom: 0, left: 15, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text("Create your account",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontFamily: "",
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30)),
                        ],
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.only(
                          top: 20, bottom: 20, left: 15, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text("Let's get started",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontFamily: "",
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20)),
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

                    //Name Container
                    Container(
                      //height: MediaQuery.of(context).size.height*0.075,
                      constraints: const BoxConstraints(maxHeight: 55),
                      margin: const EdgeInsets.only(
                          left: 15, right: 15, bottom: 15),
                      width: MediaQuery.of(context).size.width,
                      padding:
                          const EdgeInsets.only(left: 15, top: 0, bottom: 0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          border:
                              Border.all(color: Colors.white.withOpacity(1))),

                      child: TextField(
                        controller: _nameCtrl,
                        focusNode: _emailNode,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(left: 5),

                          border: InputBorder.none,
                          hintText: "Full Name",
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

                    //Email Container
                    Container(
                      //height: MediaQuery.of(context).size.height*0.075,
                      constraints: const BoxConstraints(maxHeight: 55),
                      margin: const EdgeInsets.only(
                          left: 15, right: 15, bottom: 15),
                      width: MediaQuery.of(context).size.width,
                      padding:
                          const EdgeInsets.only(left: 15, top: 0, bottom: 0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          border:
                              Border.all(color: Colors.white.withOpacity(1))),

                      child: TextField(
                        controller: _emailCtrl,
                        focusNode: _emailNode,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(left: 5),

                          border: InputBorder.none,
                          hintText: "Email Address",
                          hintStyle: TextStyle(
                              color: Colors.black.withOpacity(0.8),
                              fontSize: 12),
                          icon: Icon(
                            CupertinoIcons.mail,
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
                          border:
                              Border.all(color: Colors.white.withOpacity(1))),

                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _passCtrl,
                              focusNode: _passNode,
                              obscureText: obPass,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(left: 5),

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

                    //Confirm Password Container
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
                          border:
                              Border.all(color: Colors.white.withOpacity(1))),

                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _passCtrl,
                              focusNode: _passNode,
                              obscureText: obPass,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(left: 5),

                                border: InputBorder.none,
                                hintText: "Confirm Password",
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

                    //Register Container
                    GestureDetector(
                      onTap: () {
                        SignUpButton(context);
                        // Navigator.push(
                        //     context,
                        //     CupertinoPageRoute(
                        //         builder: (BuildContext context) =>
                        //             DashboardPage(
                        //               userTabIndex: 0,
                        //             )));
                      },
                      child: Container(
                        margin: const EdgeInsets.only(
                            left: 15, right: 15, top: 15, bottom: 15),
                        padding: const EdgeInsets.only(top: 15, bottom: 15),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: appPrimary),
                        child: const Text(
                          "Register",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),

                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const Login()));
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 15),
                        child: RichText(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          text: const TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Already registered? ',
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
                                text: 'Login',
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
