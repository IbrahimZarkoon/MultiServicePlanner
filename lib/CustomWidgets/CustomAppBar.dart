import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:socialapp/LocationPage.dart';
import 'package:socialapp/Routes/customRoute.dart';
import 'package:socialapp/Screens/SearchPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Enums/Colors.dart';
import '../Screens/Dashboard.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {

  final TextEditingController _searchCon = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose

    _searchCon.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<Map<String, dynamic>> getLocationInfo(double latitude, double longitude) async {
    final apiKey = 'AIzaSyAZF17_nequz3Y6dsuoQrYuE303OBU-bEE';
    final url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to load location data');
    }
  }

  String dropdown = "Current Location";



  @override
  Widget build(BuildContext context) {
    return AppBar(

      automaticallyImplyLeading: false,
      elevation: 0.25,
      centerTitle: false,
      title: Container(
        alignment: Alignment.centerLeft,
        child: Image.asset("assets/images/logos/LOGO.png",
          color: const Color(0xffffffff),fit: BoxFit.cover,height: kToolbarHeight-10,),
      ),
      backgroundColor: const Color(0xff09426d),

      actions: [

        InkWell(
          // onTap: ()async{
          //
          //   LatLng result = await Navigator.push(context, customRoute(const LocationPage()));
          //
          //   print("Popped LATLNG: $result");
          //
          //   getLocationInfo(result.latitude, result.longitude);
          //
          //
          //
          //
          // },
          child: DropdownButton<String>(
            underline: SizedBox(),
            icon: Icon(Icons.keyboard_arrow_down, size: 20, color: Color(0xffffffff)),
            elevation: 1,
            borderRadius: BorderRadius.circular(5),
            dropdownColor: Color(0xff09426d),
            value: dropdown, // Set the currently selected item
             onChanged: (String? value) {
              setState(() {
                dropdown = value!;
              });
             },
            items: <String>[
              'Current Location',
              'North Nazimabad', // Add your additional items here
              'DHA',
              'Gulshan',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(

                value: value,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Container(
                    //   margin: const EdgeInsets.only(left: 15, right: 0),
                    //   child: const Icon(Icons.location_on, color: Color(0xffffffff), size: 20),
                    // ),
                    // const SizedBox(width: 5),
                    Text(
                      value,
                      style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xffffffff), fontSize: 13),
                    ),
                    // const SizedBox(width: 5),
                    // const Icon(Icons.keyboard_arrow_down, size: 20, color: Color(0xffffffff)),
                  ],
                ),
              );
            }).toList(),
          )
        ),

      ],

      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight*1),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: kToolbarHeight*1,
          // color: Colors.red,
          child:
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [

                //Search Bar
                SearchBar(context),

                //Profile Image Container
                InkWell(
                  onTap: () {
                    Scaffold.of(context).openEndDrawer();

                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 15,bottom: 15),
                    padding: const EdgeInsets.all(5),
                    constraints: const BoxConstraints(
                      maxHeight: 40
                    ),
                    decoration: BoxDecoration(
                        //color: Color(0xffffffff),
                        borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white,width: 2)
                    ),
                    child: const Icon(Icons.person,size: 25,color: Colors.white,),
                  ),
                ),



              ],
            )
        ),
      ),
    );
  }

  Widget horizontalListCon(BuildContext context, String title, bool active) {
    return Container(
      alignment: Alignment.center,
      //width: MediaQuery.of(context).size.width*0.25,

      margin: const EdgeInsets.only(right: 15, top: 0, bottom: 0),
      padding: const EdgeInsets.only(left: 25, right: 25, bottom: 5, top: 5),

      decoration: BoxDecoration(
        color: active? const Color(0xff009ed9) : Colors.black.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        // boxShadow: [
        //   BoxShadow(
        //       color: Colors.black.withOpacity(0.1),
        //       blurRadius: 1,
        //       offset: const Offset(0, 0))
        // ]
      ),
      child: Text(
        title,
        style: TextStyle(
            color: active ? Colors.white : Colors.black.withOpacity(0.6),
            fontWeight: FontWeight.bold,
            fontFamily: active? "" : "Helvetica",
            fontSize: 12),
      ),
    );
  }
  
  Widget SearchBar(BuildContext context)
  {
    return Expanded(
      child: InkWell(
        onTap: ()
        {
          Navigator.push(context, MaterialPageRoute(builder: (_) => SearchPage(tag: "appBarSearch")));
        },
        child: Container(
          constraints: const BoxConstraints(
              maxHeight: 40
          ),
          //width: MediaQuery.of(context).size.width*0.8,
          margin: const EdgeInsets.only(left: 15,right: 15,bottom: 15,top: 0),
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5,top: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 0,
                blurRadius: 3,
                offset: const Offset(0, 0), // changes position of shadow
              ),
            ],
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              Container(
                  padding: const EdgeInsets.only(left: 5,right: 0,top: 0,bottom: 0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color(0xffffffff)
                  ),
                  child: Hero(
                      tag: "appBarSearch",
                      child: const Icon(Icons.search,color: appPrimary, size: 22,))),

              const SizedBox(width: 10),

              Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: TextField(
                      enabled: false,
                      controller: _searchCon,
                      //controller: _searchCon,
                      focusNode: _focusNode,
                      //onChanged: (query) => setState(() {}),
                      style: const TextStyle(color: Colors.black, height: 1, fontSize: 14),
                      decoration: InputDecoration(
                        //prefixIcon: Icon(Icons.search, color: Color(0xFF5D5D67), size: 23),
                          hintText: "What are you looking for?",
                          hintStyle: TextStyle(color: Colors.black.withOpacity(0.35),fontWeight: FontWeight.bold ,fontSize: 13),
                          border: InputBorder.none),
                    ),
                  )),

            ],
          ),
        ),
      ),
    );
  }
}
