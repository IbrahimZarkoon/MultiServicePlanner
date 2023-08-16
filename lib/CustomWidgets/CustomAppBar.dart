import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socialapp/LocationPage.dart';
import 'package:socialapp/Routes/customRoute.dart';
import 'package:socialapp/Screens/SearchPage.dart';

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



  @override
  Widget build(BuildContext context) {
    return AppBar(

      automaticallyImplyLeading: false,
      elevation: 0.25,
      centerTitle: false,
      title: Container(
        alignment: Alignment.centerLeft,
        child: const Text("SOCIAL BRAND",style: TextStyle(color: Colors.white,fontFamily: "Helvetica_Bold",fontSize: 20),),
      ),
      backgroundColor: const Color(0xffff1f6f),

      actions: [

        InkWell(
          onTap: () => Navigator.push(context, customRoute(const LocationPage())),
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.only(bottom: 10),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Container(
                    margin: const EdgeInsets.only(left: 15,right: 0),
                    child: const Icon(Icons.location_on,color: Color(0xffffffff),size: 20,)),

                // Icon(Icons.location_on_outlined,color: Color(0xffff1f6f),size: 20,),

                const SizedBox(width: 5,),

                const Text("Current Location",style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xffffffff),fontSize: 13),),

                const SizedBox(width: 5,),

                const Icon(Icons.keyboard_arrow_down,size: 20,color: Color(0xffffffff),)
              ],
            ),
          ),
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
                      child: const Icon(Icons.search,color: Color(0xffff1f6f), size: 22,))),

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
