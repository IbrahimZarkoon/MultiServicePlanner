import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../modals/RegisterOrgProvider.dart';

class passwordTab extends StatefulWidget {
  const passwordTab({Key? key}) : super(key: key);

  @override
  State<passwordTab> createState() => _passwordTabState();
}

class _passwordTabState extends State<passwordTab> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<Offset> _animation;

  TextEditingController _passCon = TextEditingController();
  TextEditingController _confirmPassCon = TextEditingController();

  FocusNode _passNode = FocusNode();
  FocusNode _confirmNode = FocusNode();

  bool obPass = true;

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

            Text("Set your password",
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
                      focusNode: _passNode,
                      obscureText: obPass,
                      controller: _passCon,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(left: 5),

                        border: InputBorder.none,
                        hintText: "Password",
                        hintStyle: TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 12),
                        icon: Icon(CupertinoIcons.lock,color: Colors.black.withOpacity(0.8),),

                        //suffixIcon: Icon(CupertinoIcons.eye,color: Colors.black.withOpacity(0.5),)
                        //helperText: "Email Address"
                        //labelText: "Email Address"
                      ),
                    ),


                  ),

                  InkWell(
                      onTap: ()
                      {
                        setState(() {
                          obPass = !obPass;
                        });
                      },
                      child: Icon(obPass? CupertinoIcons.eye : CupertinoIcons.eye_fill,color: Colors.black.withOpacity(0.5),)),
                ],
              ),
            ),

            //Confirm Pass Container
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
                      focusNode: _confirmNode,
                      obscureText: obPass,
                      controller: _confirmPassCon,
                      onChanged: (String value)
                      {
                        if(_passCon.text == value) {
                          regOrgProv.password = value;
                        }
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(left: 5),

                        border: InputBorder.none,
                        hintText: "Confirm password",
                        hintStyle: TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 12),
                        icon: Icon(CupertinoIcons.lock,color: Colors.black.withOpacity(0.8),),

                        //suffixIcon: Icon(CupertinoIcons.eye,color: Colors.black.withOpacity(0.5),)
                        //helperText: "Email Address"
                        //labelText: "Email Address"
                      ),
                    ),


                  ),

                  InkWell(
                      onTap: ()
                      {
                        setState(() {
                          obPass = !obPass;
                        });
                      },
                      child: Icon(obPass? CupertinoIcons.eye : CupertinoIcons.eye_fill,color: Colors.black.withOpacity(0.5),)),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
