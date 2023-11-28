import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../CustomWidgets/Headings.dart';
import 'Dashboard.dart';
import 'Login.dart';
import 'Register.dart';


class LoginLetter extends StatefulWidget {
  const LoginLetter({Key? key}) : super(key: key);

  @override
  State<LoginLetter> createState() => _LoginLetterState();
}

class _LoginLetterState extends State<LoginLetter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Column(
                children: [
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                          onTap: () => Navigator.push(context, FadeRoute( page: DashboardPage(userTabIndex: 0),)),

                          child: Icon(CupertinoIcons.xmark,color: Colors.black.withOpacity(0.8),size: 30,)),
                    ],
                  ),

                  Container(
                    margin: const EdgeInsets.only(bottom: 0),
                    //color: Colors.red,
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width*0.45
                    ),
                    child: Image.asset("assets/images/8f4940ab2b110be46a20fe7efd88e9826c801ce7-3840x2160.png", fit: BoxFit.cover,color: const Color(0xffff1f6f),),
                  ),

                  Text("WELCOME TO TWITTER",
                  style: TextStyle(color: Colors.black.withOpacity(0.8),fontFamily: "Helvetica_Bold",fontSize: 22),),

                  const SizedBox(height: 20,),

                  Text("The trusted community of buyers and organizers",maxLines: 2,textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black.withOpacity(0.8),fontFamily: "",fontWeight: FontWeight.normal,fontSize: 22),),

                  const SizedBox(height: 20,),

                  InkWell(
                      onTap: () => Navigator.push(context, CupertinoPageRoute(builder: (BuildContext context) => const Login())),
                      child: loginRegisterCon(context, "Login")),

                  InkWell(
                      onTap: () => Navigator.push(context, CupertinoPageRoute(builder: (BuildContext context) => const Register())),
                      child: loginRegisterCon(context, "Create a new account")),


                  continueCon(context, "Continue with Facebook", "https://www.edigitalagency.com.au/wp-content/uploads/Facebook-logo-blue-circle-large-transparent-png.png"),


                  continueCon(context, "Continue with Google", "https://static-00.iconduck.com/assets.00/google-icon-2048x2048-czn3g8x8.png"),
                ],
              ),



              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: RichText(
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    //style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(
                        text: 'If you continue, you are accepting ',
                        style: TextStyle(color: Colors.black.withOpacity(0.8),fontFamily: "",fontWeight: FontWeight.normal,fontSize: 14),
                      ),
                      TextSpan(
                        style: TextStyle(color: Colors.black.withOpacity(0.8),fontFamily: "",fontWeight: FontWeight.normal,fontSize: 14,decoration: TextDecoration.underline),
                        text:
                        'Twitter Terms and Conditions',
                      ),
                      TextSpan(
                        style: TextStyle(color: Colors.black.withOpacity(0.8),fontFamily: "",fontWeight: FontWeight.normal,fontSize: 14),
                        text:
                        ' and ',
                      ),
                      TextSpan(
                        style: TextStyle(color: Colors.black.withOpacity(0.8),fontFamily: "",fontWeight: FontWeight.normal,fontSize: 14,decoration: TextDecoration.underline),
                        text:
                        'Privacy Policy',
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget continueCon(BuildContext context,String title, String image)
  {
    return Container(
      constraints: const BoxConstraints(
          minHeight: 40,
          maxHeight: 50
      ),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black.withOpacity(0.8),width: 1.5),
          borderRadius: BorderRadius.circular(3)
      ),
      padding: const EdgeInsets.only(top: 5,bottom: 5,left: 15,right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 30,
            height: 30,
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        image
                    )
                )
            ),
          ),

          Text(title,textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 14,fontFamily: "Helvetica_Bold"),),
        ],
      ),
    );
  }

  Widget loginRegisterCon(BuildContext context,String title)
  {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 42,
        maxHeight: 50
      ),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black.withOpacity(0.8),width: 1.5),
          borderRadius: BorderRadius.circular(3)
      ),
      padding: const EdgeInsets.only(top: 5,bottom: 5,left: 15,right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Container(
          //   width: 30,
          //   height: 30,
          //   margin: EdgeInsets.only(right: 10),
          //   decoration: BoxDecoration(
          //       image: DecorationImage(
          //           image: NetworkImage(
          //               image
          //           )
          //       )
          //   ),
          // ),

          Text(title,textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 14,fontFamily: "Helvetica_Bold"),),
        ],
      ),
    );
  }
}
