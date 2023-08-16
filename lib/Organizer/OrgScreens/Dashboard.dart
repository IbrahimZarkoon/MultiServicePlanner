import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socialapp/Organizer/OrgScreens/Homepage.dart';
import 'package:socialapp/Organizer/OrgScreens/OrgNotif.dart';
import 'package:socialapp/Organizer/OrgScreens/OrgProfile.dart';
import 'package:socialapp/Organizer/Widgets/orgAppBar.dart';
import 'package:socialapp/Organizer/Widgets/orgDrawer.dart';

class OrgDashboard extends StatefulWidget {
  OrgDashboard({Key? key, required this.orgTabIndex}) : super(key: key);

  int orgTabIndex;

  @override
  State<OrgDashboard> createState() => _OrgDashboardState();
}

class _OrgDashboardState extends State<OrgDashboard> with SingleTickerProviderStateMixin{
  int _selectedIndex = 0;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();


  final orgTabs = [
    const OrgHomePage(),
    const OrgNotif(),
    const OrgProfile()
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this,initialIndex: widget.orgTabIndex);
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        endDrawer: orgDrawer(context),

        appBar: _tabController.index == 0?
        PreferredSize(preferredSize: const Size.fromHeight(kToolbarHeight), child: AppBar(

          automaticallyImplyLeading: false,
          elevation: 0.5,
          centerTitle: false,
          title: Container(
            alignment: Alignment.centerLeft,
            child: const Text("BRAND ORGANIZER",style: TextStyle(color: Color(0xffff1f6f),fontFamily: "Helvetica_Bold",fontSize: 22),),
          ),
          backgroundColor: const Color(0xffffffff),

          actions: [

            //Profile Image Container
            InkWell(
              onTap: () {
                scaffoldKey.currentState?.openEndDrawer();

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
                    border: Border.all(color: const Color(0xffff1f6f),width: 2)
                ),
                child: const Icon(Icons.menu,size: 22,color: Color(0xffff1f6f),),
              ),
            ),

          ],
        ))
            :
         PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child:  orgAppBar(scaffoldKey: scaffoldKey),
        ),

        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

        body: RepaintBoundary(
            child:TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: orgTabs
            )
        ),

        bottomNavigationBar:  Container(
          decoration: BoxDecoration(
              color: const Color(0xfff9f9f9),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 1.5,
                    spreadRadius: 1,
                    offset: const Offset(0,-1)
                )
              ]
          ),
          height: kToolbarHeight+15,
          child: TabBar(

            dividerColor: const Color(0xfff1f1f1),
            padding: const EdgeInsets.all(0),
            physics: const NeverScrollableScrollPhysics(),
            indicator: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Color(0xffff1f6f),
                  width: 3.0,
                ),
              ),
            ),
            controller: _tabController,
            indicatorColor: Colors.white,
            unselectedLabelColor: Colors.black.withOpacity(0.35),
            labelColor: const Color(0xffff1f6f),
            labelStyle: const TextStyle(
                fontSize: 11
            ),

            onTap: (int index)
            {
              setState(() {
                widget.orgTabIndex = index;
              });
            },
            tabs: [
              Tab(
                iconMargin: const EdgeInsets.only(bottom: 5),
                icon: Icon(widget.orgTabIndex == 0? Icons.dashboard : Icons.dashboard_customize_outlined),
                child: const Text("Dashboard"),
              ),

              Tab(
                iconMargin: const EdgeInsets.only(bottom: 5),

                icon: Icon(widget.orgTabIndex == 1? Icons.notifications : Icons.notifications_none_outlined),
                text: 'Notifications',
              ),
              Tab(
                iconMargin: const EdgeInsets.only(bottom: 5),

                icon: Icon(widget.orgTabIndex == 2? CupertinoIcons.person_fill : CupertinoIcons.person),
                text: 'Profile',
              ),

            ],
          ),
        ),

        // bottomNavigationBar:  CupertinoTabScaffold(
        //
        //   tabBar: CupertinoTabBar(
        //     currentIndex: _selectedIndex,
        //     onTap: (index) {
        //       setState(() {
        //         _selectedIndex = index;
        //       });
        //     },
        //
        //     activeColor: Color(0xFFfc9038),
        //     items: const <BottomNavigationBarItem>[
        //       BottomNavigationBarItem(
        //         icon: Icon(CupertinoIcons.home,size: 25,),
        //         label: 'Home',
        //       ),
        //       BottomNavigationBarItem(
        //         icon: Icon(CupertinoIcons.profile_circled,size: 25,),
        //         label: 'Profile',
        //       ),
        //       BottomNavigationBarItem(
        //         icon: Icon(CupertinoIcons.cart,size: 25,),
        //         label: 'Cart',
        //       ),
        //       // BottomNavigationBarItem(
        //       //   icon: Icon(CupertinoIcons.circle_grid_3x3_fill),
        //       //   label: 'Keypad',
        //       // ),
        //     ],
        //   ), tabBuilder: (BuildContext context, int index) {
        //   return CupertinoTabView(
        //     builder: (BuildContext context) {
        //       return Center(
        //         child: tabs.elementAt(_selectedIndex),
        //       );
        //     },
        //   );
        // },
        // ),




        //
        // body: SingleChildScrollView(
        //   scrollDirection: Axis.vertical,
        //   physics: BouncingScrollPhysics(),
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.start,
        //     children: [
        //       SizedBox(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.925,child: tabs[widget.tabindex]),
        //
        //       SizedBox(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.075,child: fbvCustomTabBar()),
        //     ],
        //   ),
        // ),

        //bottomNavigationBar:  SizedBox(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.075,child: fbvCustomTabBar()),
      ),
    );

    // (_profile || _menu)? SizedBox() :
  }

}
