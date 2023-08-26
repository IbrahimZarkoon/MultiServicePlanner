import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialapp/Organizer/OrgScreens/Homepage.dart';
import 'package:socialapp/Organizer/OrgScreens/OrgChats.dart';
import 'package:socialapp/Organizer/OrgScreens/OrgNotif.dart';
import 'package:socialapp/Organizer/OrgScreens/OrgProfile.dart';
import 'package:socialapp/Organizer/Widgets/orgAppBar.dart';
import 'package:socialapp/Organizer/Widgets/orgDrawer.dart';

import '../../Providers/CacheManager.dart';

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
    OrgChats(),
    const OrgNotif(),
    const OrgProfile()
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this,initialIndex: widget.orgTabIndex);
  }

  @override
  Widget build(BuildContext context) {
    final cacheManager = Provider.of<CacheManagerProvider>(context).cacheManager;

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
            child: ClipRRect(

              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                color: Color(0xffff1f6f),
                height: kToolbarHeight-10,
                imageUrl: "https://www.nexarce.com/wp-content/uploads/2023/04/NexarceLogo.png",
                cacheManager: cacheManager,
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(
                    color: Color(0xffff1f6f),
                    value: 5,
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error,color: Color(0xffff1f6f),),
              ),
            ),
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

                icon: Icon(widget.orgTabIndex == 1? CupertinoIcons.chat_bubble_2_fill : CupertinoIcons.chat_bubble_2),
                text: 'Chats',
              ),

              Tab(
                iconMargin: const EdgeInsets.only(bottom: 5),

                icon: Icon(widget.orgTabIndex == 2? Icons.notifications : Icons.notifications_none_outlined),
                text: 'Notifications',
              ),
              Tab(
                iconMargin: const EdgeInsets.only(bottom: 5),

                icon: Icon(widget.orgTabIndex == 3? CupertinoIcons.person_fill : CupertinoIcons.person),
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
