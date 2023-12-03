import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_service_planner/Enums/Colors.dart';
import 'package:provider/provider.dart';

import '../../modals/RegisterOrgProvider.dart';


class additionalInfo extends StatefulWidget {
  const additionalInfo({Key? key}) : super(key: key);

  @override
  State<additionalInfo> createState() => _additionalInfoState();
}

class _additionalInfoState extends State<additionalInfo> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<Offset> _animation;

  TextEditingController _dobCon = TextEditingController();
  TextEditingController _webURLCon = TextEditingController();

  final FocusNode _dobNode = FocusNode();
  final FocusNode _webURLNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750), // Adjust the duration of the animation.
    );

    _animation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut, // Adjust the animation curve.
    ));

    // Start the animation when the screen is loaded.
    _controller.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    _controller.dispose();
    super.dispose();
  }

  String _selectedServiceType = '';

  List<String> serviceTypes = ['','Photographer','Decor','Venue','Catering'];

  @override
  Widget build(BuildContext context) {

    var regOrgProv = Provider.of<RegisterOrgProvider>(context,listen: false);


    return SlideTransition(
      position: _animation,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [

            Text("Additional Information",
              style: TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 28,fontFamily: "Helvetica_Bold"),),

            const SizedBox(height: kToolbarHeight,),

            //Pass Container
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
                  border: Border.all(color: Colors.black.withOpacity(0.1))
              ),

              child:  Row(
                children: [
                  Expanded(
                    child: TextField(
                      focusNode: _dobNode,
                      controller: _dobCon,
                      onChanged: (String value)
                      {
                        regOrgProv.dob = value;
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(left: 5),

                        border: InputBorder.none,
                        hintText: "DD/MM/YYYY",
                        hintStyle: TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 12),
                        icon: Icon(CupertinoIcons.calendar,size: 20,color: Colors.black.withOpacity(0.8),),

                        //suffixIcon: Icon(CupertinoIcons.eye,color: Colors.black.withOpacity(0.5),)
                        //helperText: "Email Address"
                        //labelText: "Email Address"
                      ),
                    ),


                  ),
                ],
              ),
            ),

            //Website Url Container
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
                  border: Border.all(color: Colors.black.withOpacity(.1))
              ),

              child:  Row(
                children: [
                  Expanded(
                    child: TextField(
                      focusNode: _webURLNode,
                      controller: _webURLCon,
                      onChanged: (String value)
                      {
                        regOrgProv.webUrl = value;
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(left: 5),

                        border: InputBorder.none,
                        hintText: "Website / Url",
                        hintStyle: TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 12),
                        icon: Icon(CupertinoIcons.link,size: 20,color: Colors.black.withOpacity(0.8),),

                        //suffixIcon: Icon(CupertinoIcons.eye,color: Colors.black.withOpacity(0.5),)
                        //helperText: "Email Address"
                        //labelText: "Email Address"
                      ),
                    ),


                  ),
                ],
              ),
            ),

            //Service Type Container
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
                  border: Border.all(color: Colors.black.withOpacity(.1))
              ),

              child:  Row(
                children: [

                  Text("Select vendor type:",style: TextStyle(
                    fontSize: MediaQuery.sizeOf(context).height * 0.016,
                    fontFamily: "OpenSans_Bold",
                  ),),

                  SizedBox(width: 10,),

                  Expanded(child: serviceTypeDropDown())
                ],
              ),
            ),


          ],
        ),
      ),
    );
  }

  Widget serviceTypeDropDown()
  {
    var regOrgProv = Provider.of<RegisterOrgProvider>(context,listen: false);

    return DropdownButton<String>(
      value: _selectedServiceType,
      underline: SizedBox(),
      style: TextStyle(
        color: appPrimary,
        fontSize: MediaQuery.sizeOf(context).height * 0.014,
        fontFamily: "OpenSans_Bold",
      ),
      icon: Icon(
        Icons.keyboard_arrow_down,
        color: appPrimary,
        size: MediaQuery.sizeOf(context).height * 0.02,
      ),
      iconSize: MediaQuery.sizeOf(context).height * 0.02,
      elevation: 1,

      items: serviceTypes.map((String serviceType) {
        return DropdownMenuItem<String>(
          value: serviceType,
          child: Text(
            serviceType,
            style: TextStyle(
              color: appPrimary,
              fontSize: MediaQuery.of(context).size.height * 0.014,
              fontFamily: "OpenSans_SemiBold",
            ),
          ),
        );
      }).toList(),

      onChanged: (String? option) {
        setState(() {
          _selectedServiceType = option ?? '';
        });
        option == "Photographer" ? regOrgProv.serviceID = '1'
            :
        option == "Decor" ? regOrgProv.serviceID = '2'
            :
        option == "Venue" ? regOrgProv.serviceID = '3'
            :
        option == "Catering" ? regOrgProv.serviceID = '7'
            :
        regOrgProv.serviceID = '';
      },

    );
  }
}
