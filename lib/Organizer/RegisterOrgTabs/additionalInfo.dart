import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class additionalInfo extends StatefulWidget {
  const additionalInfo({Key? key}) : super(key: key);

  @override
  State<additionalInfo> createState() => _additionalInfoState();
}

class _additionalInfoState extends State<additionalInfo> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<Offset> _animation;

  final FocusNode _dobNode = FocusNode();
  final FocusNode _confirmNode = FocusNode();

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

          ],
        ),
      ),
    );
  }
}
