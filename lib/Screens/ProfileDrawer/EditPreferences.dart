import 'package:flutter/material.dart';
import 'package:socialapp/Screens/ProfileDrawer/clarifyTab.dart';
import 'package:socialapp/Screens/ProfileDrawer/preferencesTab.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class EditPreferences extends StatefulWidget {
  const EditPreferences({Key? key}) : super(key: key);

  @override
  State<EditPreferences> createState() => _EditPreferencesState();
}

class _EditPreferencesState extends State<EditPreferences> {
  int _selectedTab = 1;

  final tabs = [
    const preferencesTab(),
    const ClarifyTab()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,

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
              child: Text("Back",style: TextStyle(color: Color(0xffff1f6f),fontSize: 16),),
            ),
          ) : const SizedBox(),
          leadingWidth: 100,
          centerTitle: true,
          title: Container(
            width: kToolbarHeight-10,
            height: kToolbarHeight-10,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              image: const DecorationImage(
                image: NetworkImage("https://w0.peakpx.com/wallpaper/794/29/HD-wallpaper-best-whatsapp-dp-boy-walking-alone-birds.jpg"),
                fit: BoxFit.cover
              )
            ),
          ),
          actions: [
            InkWell(
              onTap: () => Navigator.pop(context),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 18,horizontal: 18),
                child: Text("Exit",style: TextStyle(color: Color(0xffff1f6f),fontSize: 16),),
              ),
            ),
          ],

          // bottom: PreferredSize(
          //   preferredSize: const Size.fromHeight(kToolbarHeight),
          //   child: Container(
          //     padding: const EdgeInsets.only(bottom: 20,left: 20,right: 20),
          //     child: StepProgressIndicator(
          //       totalSteps: 2,
          //       currentStep: _selectedTab,
          //       size: 10,
          //       selectedColor: const Color(0xff009ed9),
          //       unselectedColor: Colors.black.withOpacity(0.2),
          //       roundedEdges: const Radius.circular(10),
          //
          //       // gradientColor: LinearGradient(
          //       //   begin: Alignment.topLeft,
          //       //   end: Alignment.bottomRight,
          //       //   colors: [Colors.orange, Colors.white],
          //       // ),
          //     ),
          //   ),),
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
                    {
                      if(_selectedTab ==2)
                        {
                          Navigator.pop(context);
                        }

                      setState(() {
                        if(_selectedTab<2) {
                          _selectedTab += 1;
                        }
                      });
                    },
                    child: Container(
                      //margin: const EdgeInsets.only(top: 20,bottom: 20),
                      padding: const EdgeInsets.only(top: 15,bottom: 15),
                      constraints: const BoxConstraints(
                        minWidth: 220,
                      ),
                      decoration: BoxDecoration(
                          color: const Color(0xffff1f6f),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      alignment: Alignment.center,
                      child:  Text(_selectedTab ==2? "Done" : "Next",
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
