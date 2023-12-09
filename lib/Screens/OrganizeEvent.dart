import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_service_planner/Enums/Colors.dart';
import 'package:multi_service_planner/Organizer/OrgScreens/Dashboard.dart';
import 'package:multi_service_planner/modals/OrgProvider.dart';
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
  orgEventRequest(
      String loc,String about, String link, String serviceId, String userId,
      String title, String priceStart, String priceEnd, String capacity, String timings,XFile bannerImg,List<XFile> relatedPics, String venueName, String venueMapLink) async {

    final String url = "https://everythingforpageants.com/msp/api/serviceDetails.php";
  print(loc);
  print(about);
  print(serviceId);
  print(userId);
  print(title);
  print(priceStart);
  print(capacity);
  print(timings);
  print(bannerImg);
  print(relatedPics);
  print(venueName);

    var request =
    http.MultipartRequest('POST', Uri.parse(url));

    // Add the file to the request as form data
    request.fields['location'] = loc;
    request.fields['title'] = title;
    request.fields['priceRangeStart'] = priceStart;
    request.fields['priceRangeEnd'] = priceEnd;
    request.fields['capacity'] = capacity;
    request.fields['timings'] = timings;
    request.fields['venueName'] = venueName;
    request.fields['venueMapLink'] = venueMapLink;
    request.fields['about'] = about;
    request.fields['link'] = link;
    request.fields['service_id'] = serviceId;
    request.fields['user_id'] = userId;


    if (bannerImg != null && bannerImg.path != '') {
      request.files.add(
        await http.MultipartFile.fromPath('bannerImg', bannerImg.path),
      );
    }
    if (relatedPics.isNotEmpty) {
      for (XFile file in relatedPics) {
        request.files.add(
          await http.MultipartFile.fromPath('relatedPics[]', file.path),
        );
      }
    }
    // if(relatedPics.isEmpty)
    //   {
    //     request.files.add(
    //       await http.MultipartFile.fromPath('relatedPics[]', ''),
    //     );
    //   }

    var response = await request.send();

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Event upload successful!");
      print("Response: ${response.toString()}");

      await ScaffoldMessenger.of(context).showSnackBar(SnackBar(duration: Duration(milliseconds: 1500),content: Text("Event added successfully.")));

      Provider.of<OrganizeEventProvider>(context,listen:false).resetRegOrgProv();

      Navigator.push(context, CupertinoPageRoute(builder: (_) =>  OrgDashboard(orgTabIndex: 0)));

    } else {
      print("Upload event request failed with status: ${response.statusCode}");
      print("Response: $response");
    }
  }


  @override
  Widget build(BuildContext context) {
    var OrgEventProv = Provider.of<OrganizeEventProvider>(context,listen:false);
    var OrgProv = Provider.of<OrgProvider>(context,listen:false);


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
                    if(_selectedTab == 2 && OrgEventProv.venueName != '') {

                      print("SERVICE ID :: ${OrgProv.serviceID}");
                      print("USER ID :: ${OrgProv.orgID}");


                      await orgEventRequest(
                          OrgEventProv.location,
                          OrgEventProv.desc,
                          OrgEventProv.link,
                          OrgProv.serviceID,
                          OrgProv.orgID,
                          '',
                          OrgEventProv.priceRangeStart,
                          OrgEventProv.priceRangeEnd,
                          OrgEventProv.capacity,
                          OrgEventProv.timings,
                          XFile(OrgEventProv.bannerImg.path),
                          OrgEventProv.relatedPics,
                          OrgEventProv.venueName,
                          ''
                      );

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
