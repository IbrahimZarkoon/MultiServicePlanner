import 'package:flutter/material.dart';

class orgAppBar extends StatefulWidget {
   orgAppBar({Key? key,required this.scaffoldKey}) : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  State<orgAppBar> createState() => _orgAppBarState();
}

class _orgAppBarState extends State<orgAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(

      automaticallyImplyLeading: false,
      elevation: 0.0,
      centerTitle: false,
      title: Container(
        alignment: Alignment.centerLeft,
        child: const Text("BRAND ORGANIZER",style: TextStyle(color: Colors.white,fontFamily: "Helvetica_Bold",fontSize: 20),),
      ),
      backgroundColor: const Color(0xffff1f6f),

      actions: [

        //Profile Image Container
        InkWell(
          onTap: () {
            widget.scaffoldKey.currentState?.openEndDrawer();

          },
          child: Container(
            margin: const EdgeInsets.only(right: 15,bottom: 10,top: 10),
            padding: const EdgeInsets.all(5),
            constraints: const BoxConstraints(
                maxHeight: 40
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              //color: Color(0xffffffff),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white,width: 2)
            ),
            child: const Icon(Icons.menu,size: 22,color: Color(0xffff1f6f),),
          ),
        ),

      ],
    );
  }
}
