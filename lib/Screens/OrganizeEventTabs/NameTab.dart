import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NameTab extends StatefulWidget {
  const NameTab({Key? key}) : super(key: key);

  @override
  State<NameTab> createState() => _NameTabState();
}

class _NameTabState extends State<NameTab> with SingleTickerProviderStateMixin {
  FocusNode F1 = FocusNode();
  TextEditingController T1 = TextEditingController();

  late AnimationController _controller;
  late Animation<Offset> _animation;

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

  bool _tap = false;

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    F1.dispose();
    T1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()
      {
        F1.unfocus();
        _tap = false;
      },
      child: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(15),
        child: SlideTransition(
          position: _animation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              Text("What's the name of your event?",
                style: TextStyle(
                    fontFamily: "Helvetica_Bold",
                    color: Colors.black.withOpacity(0.8),
                    fontSize: 32
                ),),

              const SizedBox(height: 15,),

              Text("Choose a name that will give people a clear idea of what the group is about. You can edit this later if you change your mind.",
                style: TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 15),),

              //Name Container
              GestureDetector(
                onTap: ()
                {
                  setState(() {

                  });
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 15,bottom: 15),
                  padding: const EdgeInsets.only(left: 15,right: 15,top: 0,bottom: 0),
                  decoration: BoxDecoration(border: Border.all(color: _tap? const Color(0xff009ed9) : Colors.black.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      Expanded(
                          child: TextField(
                            onTap: ()
                            {
                              setState(() {
                                _tap = true;
                              });
                            },
                            focusNode: F1,
                            controller: T1,
                            cursorColor: const Color(0xff009ed9),
                            style: TextStyle(fontSize: 16,color: Colors.black.withOpacity(0.8)),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Event name",
                              hintStyle: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: 13),

                            ),
                          )
                      ),

                      _tap?
                      InkWell(
                          onTap: ()
                          {
                            setState(() {
                              T1.text = "";
                              _tap = false;
                              F1.unfocus();

                            });
                          },
                          child: Icon(CupertinoIcons.xmark_circle_fill,color: Colors.black.withOpacity(0.5),size: 20,))
                          :
                      const SizedBox(),
                    ],
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
