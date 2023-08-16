import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DescTab extends StatefulWidget {
  const DescTab({Key? key}) : super(key: key);

  @override
  State<DescTab> createState() => _DescTabState();
}

class _DescTabState extends State<DescTab> with SingleTickerProviderStateMixin{
  FocusNode F1 = FocusNode();
  TextEditingController T1 = TextEditingController();

  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 750), // Adjust the duration of the animation.
    );

    _animation = Tween<Offset>(
      begin: Offset(1.0, 0.0),
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
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: SlideTransition(
            position: _animation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Text("How would you describe your group?",
                  style: TextStyle(
                      fontFamily: "Helvetica_Bold",
                      color: Colors.black.withOpacity(0.8),
                      fontSize: 32
                  ),),

                const SizedBox(height: 15,),

                RichText(text: TextSpan(
                  children: <TextSpan>[

                    TextSpan(
                      text: "People will see this when we promote your group, but you'll be able to update it later. Your description must meet our ",
                      style: TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 15)
                    ),
                    const TextSpan(
                        text: "community guidelines.",
                        style: TextStyle(color: Color(0xffff1f6f),fontSize: 15)
                    ),
                  ]
                )),
                // Text("People will see this when we promote your group, but you'll be able to update it later. Your description must meet our ",
                //   style: TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 15),),

                //Description Container
                GestureDetector(
                  onTap: ()
                  {
                    setState(() {

                    });
                  },
                  child: Container(
                    constraints: const BoxConstraints(
                      minHeight: 200
                    ),
                    margin: const EdgeInsets.only(top: 15,bottom: 15),
                    padding: const EdgeInsets.only(left: 15,right: 15,top: 0,bottom: 0),
                    decoration: BoxDecoration(border: Border.all(color: _tap? const Color(0xffff1f6f) : Colors.black.withOpacity(0.5)),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                              cursorColor: const Color(0xffff1f6f),
                              style: TextStyle(fontSize: 16,color: Colors.black.withOpacity(0.8)),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Write at least 50 characters",
                                hintStyle: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: 13),

                              ),
                            )
                        ),

                      ],
                    ),
                  ),
                ),

                Text("• What's the event goal?",
                style: TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 15),),

                const SizedBox(height: 15,),

                Text("• Who are you hoping to meet?",
                  style: TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 15),),

                const SizedBox(height: 15,),

                Text("• What will you do at your events?",
                  style: TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 15),),

                const SizedBox(height: 15,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,

                  children: const [

                    Icon(CupertinoIcons.light_max,color: Color(0xffff1f6f)),

                    SizedBox(width: 10,),

                    Text("See examples of event descriptions",
                        style: TextStyle(color: Color(0xffff1f6f),fontSize: 15))



                  ],
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
