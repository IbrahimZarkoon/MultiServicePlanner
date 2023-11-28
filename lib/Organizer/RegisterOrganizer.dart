import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'OrganizerLogin.dart';
import 'RegisterOrgTabs/DocVerification.dart';
import 'RegisterOrgTabs/additionalInfo.dart';
import 'RegisterOrgTabs/docUploaded.dart';
import 'RegisterOrgTabs/passwordTab.dart';
import 'RegisterOrgTabs/selfieImageTab.dart';
import 'RegisterOrgTabs/firstTab.dart';
import 'RegisterOrgTabs/imageTab.dart';

class RegisterOrganizer extends StatefulWidget {
  const RegisterOrganizer({Key? key}) : super(key: key);
  @override
  State<RegisterOrganizer> createState() => _RegisterOrganizerState();
}

class _RegisterOrganizerState extends State<RegisterOrganizer> {

  int _selectedTab = 1;

  final tabs = [
    const firstTab(),
    const passwordTab(),
    const additionalInfo(),
    const DocVerification(),
    const imageTab(),
    const selfieImageTab(),
    const DocUploaded()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 100,
        leading: InkWell(
          onTap: ()
          {
            if(_selectedTab != 1)
              {
                setState(() {
                  _selectedTab -= 1;
                });
              }else
                {
                  Navigator.pop(context);
                }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [

              const SizedBox(width: 5,),

              Transform.rotate(
                  angle: 3.142,
                  child: const Icon(Icons.arrow_right_alt,size: 25,color: Color(0xff09426d),)),

              const SizedBox(width: 2,),

              const Text("Back",style: TextStyle(
                color: Color(0xff09426d),fontSize: 14,
              ),)
            ],
          ),
        ),
      ),

      body: GestureDetector(
        onTap: ()
        {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,

          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: kToolbarHeight-20),
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width*0.6
                  ),
                  child: Image.asset("assets/images/logos/LOGO.png",
                    color: const Color(0xff09426d),fit: BoxFit.cover,),
                ),
              ],
            ),

            Expanded(child: tabs[_selectedTab-1]),

            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Container(
                  padding: const EdgeInsets.only(top: 15,bottom: 15),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(top: BorderSide(color: Colors.black.withOpacity(0.15),width: 0.5))
                  ),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: ()
                        {
                          setState(() {
                            if(_selectedTab<7) {
                              _selectedTab += 1;
                            }else
                              {
                                Navigator.push(context, CupertinoPageRoute(builder: (BuildContext context) => const OrganizerLogin()));
                              }
                          });
                        },
                        child: Container(
                          //margin: const EdgeInsets.only(top: 20,bottom: 20),
                          padding: const EdgeInsets.only(top: 15,bottom: 15),
                          constraints: const BoxConstraints(
                            minWidth: 220,
                          ),
                          decoration: BoxDecoration(
                              color: const Color(0xff09426d),
                              borderRadius: BorderRadius.circular(30)
                          ),
                          alignment: Alignment.center,
                          child:  Text(_selectedTab ==6? "Create account" : "Continue",
                            style: const TextStyle(color: Colors.white,fontFamily: "Helvetica_Bold"),),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )

          ],
        ),
      ),

    );
  }
}
