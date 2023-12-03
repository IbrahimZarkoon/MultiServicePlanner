import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_service_planner/modals/RegisterOrgProvider.dart';
import 'package:provider/provider.dart';

class firstTab extends StatefulWidget {
  const firstTab({Key? key}) : super(key: key);

  @override
  State<firstTab> createState() => _firstTabState();
}

class _firstTabState extends State<firstTab> with SingleTickerProviderStateMixin{

  late AnimationController _controller;
  late Animation<Offset> _animation;

  TextEditingController _emailCon = TextEditingController();
  TextEditingController _nameCon = TextEditingController();
  TextEditingController _phCon = TextEditingController();

  FocusNode _emailNode = FocusNode();
  FocusNode _nameNode = FocusNode();
  FocusNode _phNode = FocusNode();



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
    _nameNode.unfocus();
    _emailNode.unfocus();
    _phNode.unfocus();
    _controller.dispose();
    super.dispose();
  }

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

            Text("Create your account",
              style: TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 28,fontFamily: "Helvetica_Bold"),),

            const SizedBox(height: kToolbarHeight,),

            //Name Container
            Container(
              //height: MediaQuery.of(context).size.height*0.075,
              constraints: const BoxConstraints(
                  maxHeight: 55
              ),
              margin: const EdgeInsets.only(left: 15,right: 15,bottom: 15),
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(left: 15,top: 0,bottom: 0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.black.withOpacity(.1))
              ),

              child:  TextField(
                focusNode: _nameNode,
                controller: _nameCon,
                onChanged: (String value)
                {
                  regOrgProv.fullName = value;
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 5),

                  border: InputBorder.none,
                  hintText: "Full Name",
                  hintStyle: TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 12),
                  icon: Icon(CupertinoIcons.person,color: Colors.black.withOpacity(0.8),),
                  //suffixIcon: Icon(CupertinoIcons.eye,color: Colors.black.withOpacity(0.5),)
                  //helperText: "Email Address"
                  //labelText: "Email Address"
                ),
              ),
            ),

            //Email Container
            Container(
              //height: MediaQuery.of(context).size.height*0.075,
              constraints: const BoxConstraints(
                  maxHeight: 55
              ),
              margin: const EdgeInsets.only(left: 15,right: 15,bottom: 15),
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(left: 15,top: 0,bottom: 0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.black.withOpacity(.1))
              ),

              child:  TextField(
                controller: _emailCon,
                focusNode: _emailNode,
                onChanged: (String value)
                {
                  regOrgProv.email = value;
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 5),

                  border: InputBorder.none,
                  hintText: "Email Address",
                  hintStyle: TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 12),
                  icon: Icon(CupertinoIcons.person,color: Colors.black.withOpacity(0.8),),
                  //suffixIcon: Icon(CupertinoIcons.eye,color: Colors.black.withOpacity(0.5),)
                  //helperText: "Email Address"
                  //labelText: "Email Address"
                ),
              ),
            ),

            //Ph # Container
            Container(
              //height: MediaQuery.of(context).size.height*0.075,
              constraints: const BoxConstraints(
                  maxHeight: 55
              ),
              margin: const EdgeInsets.only(left: 15,right: 15,bottom: 15),
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(left: 15,top: 0,bottom: 0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.black.withOpacity(.1))
              ),

              child:  TextField(
                controller: _phCon,
                focusNode: _phNode,
                keyboardType: TextInputType.phone,
                onChanged: (String value)
                {
                  regOrgProv.phone = value;
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 5),

                  border: InputBorder.none,

                  hintText: "Phone Number",
                  hintStyle: TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 12),
                  icon: Icon(Icons.call_outlined,color: Colors.black.withOpacity(0.8),),
                  //suffixIcon: Icon(CupertinoIcons.eye,color: Colors.black.withOpacity(0.5),)
                  //helperText: "Email Address"
                  //labelText: "Email Address"
                ),
              ),
            ),



          ],
        ),
      ),
    );
  }
}
