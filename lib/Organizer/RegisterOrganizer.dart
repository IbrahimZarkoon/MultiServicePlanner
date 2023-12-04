import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../modals/RegisterOrgProvider.dart';
import 'OrganizerLogin.dart';
import 'RegisterOrgTabs/DocVerification.dart';
import 'RegisterOrgTabs/additionalInfo.dart';
import 'RegisterOrgTabs/docUploaded.dart';
import 'RegisterOrgTabs/passwordTab.dart';
import 'RegisterOrgTabs/selfieImageTab.dart';
import 'RegisterOrgTabs/firstTab.dart';
import 'RegisterOrgTabs/imageTab.dart';
import 'package:http/http.dart' as http;


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

  //Post Request for Org Register
  regOrgRequest(String fn, String email, String pass, String ph, String dob,XFile nicF,XFile nicB,XFile selfie, String role, String serviceID) async {
    final String url = "https://everythingforpageants.com/msp/api/signup.php";

    Map<String, dynamic> requestData = {
      "fullName": fn,
      "email": email,
      "password": pass,
      "phone": ph,
      "dob": dob,
      "nicFront": nicF,
      "nicBack": nicB,
      "profilePic": selfie,
      "role": role,
      "service_id": serviceID,
    };

    var request =
    http.MultipartRequest('POST', Uri.parse("https://everythingforpageants.com/msp/api/signup.php"));

    // Add the file to the request as form data
    request.fields['fullName'] = fn;
    request.fields['email'] = email;
    request.fields['password'] = pass;
    request.fields['phone'] = ph;
    request.fields['dob'] = dob;
    request.fields['role'] = role;
    request.fields['service_id'] = serviceID;


    if (nicF != null) {
      request.files.add(
        await http.MultipartFile.fromPath('nicFront', nicF!.path),
      );
    }

    if (nicB != null) {
      request.files.add(
        await http.MultipartFile.fromPath('nicBack', nicB!.path),
      );
    }
    if (selfie != null) {
      request.files.add(
        await http.MultipartFile.fromPath('profilePic', selfie!.path),
      );
    }
    var response = await request.send();

    // final response = await http.post(
    //   Uri.parse(url),
    //   body: jsonEncode(requestData),
    // );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Registration successful!");
      print("Response: $response");

      await ScaffoldMessenger.of(context).showSnackBar(SnackBar(duration: Duration(milliseconds: 1500),content: Text("Vendor registered successfully.")));

      Navigator.push(context, CupertinoPageRoute(builder: (_) => const OrganizerLogin()));

    } else {
      print("POST request failed with status: ${response.statusCode}");
      print("Response: $response");
    }
  }

  @override
  Widget build(BuildContext context) {
    var regOrgProv = Provider.of<RegisterOrgProvider>(context,listen: false);


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
                        async{
                          if(_selectedTab<7) {
                            setState(() {
                              _selectedTab += 1;
                            });
                          }
                          else
                          {
                            print(regOrgProv.email);
                            print(regOrgProv.fullName);
                            print(regOrgProv.phone);
                            print(regOrgProv.password);
                            print("${regOrgProv.nicFront}");
                            print("${regOrgProv.nicBack}");
                            print("${regOrgProv.selfie}");

                            await regOrgRequest(
                                regOrgProv.fullName,
                                regOrgProv.email,
                                regOrgProv.password,
                                regOrgProv.phone,
                                regOrgProv.dob,
                                XFile(regOrgProv.nicFront.path),
                                XFile(regOrgProv.nicBack.path),
                                XFile(regOrgProv.selfie.path),
                                "2",
                                regOrgProv.serviceID
                            );
                            regOrgProv.resetRegOrgProv();
                          }
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
