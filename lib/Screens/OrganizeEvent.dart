import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_service_planner/Enums/Colors.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../Organizer/OrganizerLogin.dart';
import '../modals/OrganizeEventProvider.dart';
import 'OrganizeEventTabs/AboutTab.dart';
import 'OrganizeEventTabs/LocationTab.dart';
import 'OrganizeEventTabs/NameTab.dart';

class OrganizeEvent extends StatefulWidget {
  const OrganizeEvent({Key? key}) : super(key: key);

  @override
  State<OrganizeEvent> createState() => _OrganizeEventState();
}

class _OrganizeEventState extends State<OrganizeEvent> {

  int _selectedTab = 1;

  final tabs = [
    const LocationTab(),
    //const AboutTab(),
    const NameTab(),

  ];


  //Post Request for Org Event
  orgEventRequest(String fn, String email, String pass, String ph, String dob,XFile nicF,XFile nicB,XFile selfie, String role, String serviceID) async {
    final String url = "https://everythingforpageants.com/msp/api/serviceDetails.php";


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

      await ScaffoldMessenger.of(context).showSnackBar(SnackBar(duration: Duration(milliseconds: 1500),content: Text("Event added successfully.")));

      Navigator.push(context, CupertinoPageRoute(builder: (_) => const OrganizerLogin()));

    } else {
      print("POST request failed with status: ${response.statusCode}");
      print("Response: $response");
    }
  }


  @override
  Widget build(BuildContext context) {
    var OrgEventProv = Provider.of<OrganizeEventProvider>(context,listen:false);


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,

        leading: (_selectedTab > 1)? InkWell(
          onTap: () {
            setState(() {
              if(_selectedTab>1) {
                _selectedTab -= 1;
              }
            });
          },
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 18,horizontal: 18),
            child: Text("Back",style: TextStyle(color: appPrimary,fontSize: 16),),
          ),
        ) : const SizedBox(),
        leadingWidth: 100,
        actions: [
          InkWell(
            onTap: () => Navigator.pop(context),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 18,horizontal: 18),
              child: Text("Exit",style: TextStyle(color: appPrimary,fontSize: 16),),
            ),
          ),
        ],

        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Container(
              padding: const EdgeInsets.only(bottom: 20,left: 20,right: 20),
              child: StepProgressIndicator(
                totalSteps: 2,
                currentStep: _selectedTab,
                size: 10,
                selectedColor: appPrimary,
                unselectedColor: Colors.black.withOpacity(0.2),
                roundedEdges: const Radius.circular(10),

                // gradientColor: LinearGradient(
                //   begin: Alignment.topLeft,
                //   end: Alignment.bottomRight,
                //   colors: [Colors.orange, Colors.white],
                // ),
              ),
            ),),
      ),

      body: tabs[_selectedTab-1],

      bottomNavigationBar: Column(
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
                    setState(() {
                      if(_selectedTab<2) {
                        _selectedTab += 1;
                        print(OrgEventProv.location);
                        print(OrgEventProv.priceRangeStart);
                        print(OrgEventProv.timings);
                        print(OrgEventProv.tags);

                      }
                    });
                    if(_selectedTab == 2) {

                      // await regOrgRequest(
                      // regOrgProv.fullName,
                      // regOrgProv.email,
                      // regOrgProv.password,
                      // regOrgProv.phone,
                      // regOrgProv.dob,
                      // XFile(regOrgProv.nicFront.path),
                      // XFile(regOrgProv.nicBack.path),
                      // XFile(regOrgProv.selfie.path),
                      // "2",
                      // regOrgProv.serviceID
                      // );

                    }
                  },
                  child: Container(
                    //margin: const EdgeInsets.only(top: 20,bottom: 20),
                    padding: const EdgeInsets.only(top: 15,bottom: 15),
                    constraints: const BoxConstraints(
                      minWidth: 220,
                    ),
                    decoration: BoxDecoration(
                        color: appPrimary,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    alignment: Alignment.center,
                    child:  Text(_selectedTab ==2? "Publish event" : "Next",
                      style: const TextStyle(color: Colors.white,fontFamily: "Helvetica_Bold"),),
                  ),
                ),
              ],
            ),
          ),
        ],
      )
    );
  }

}
