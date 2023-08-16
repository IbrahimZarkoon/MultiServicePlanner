import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socialapp/Organizer/OrgScreens/Homepage.dart';
import 'package:socialapp/Screens/ExplorePage.dart';
import 'package:socialapp/Screens/MyProfile.dart';
import 'package:socialapp/Screens/NotificationsTab.dart';
import 'package:socialapp/Screens/Organizers.dart';

import '../CustomWidgets/CustomAppBar.dart';
import '../CustomWidgets/RoundedBottomBar.dart';
import 'HomePage.dart';
import 'ProfileDrawer/profileDrawer.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({Key? key, required this.userTabIndex}) : super(key: key);

  int userTabIndex;

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> with SingleTickerProviderStateMixin{
  int _selectedIndex = 0;

  final userTabs = [
    const HomePage(), // 0
    const ExplorePage(),
    const NotificationsTab(),
    const Organizers()
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this,initialIndex: widget.userTabIndex);
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(

        endDrawer: Drawer(
          elevation: 10,
          shadowColor: Colors.black.withOpacity(0.5),
          child:  userDrawer(context),


        ),

        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight*2),
          child: CustomAppBar(),
        ),

        body: RepaintBoundary(
          child:TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: userTabs
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
                widget.userTabIndex = index;
              });
            },
            tabs: [
              Tab(
                iconMargin: const EdgeInsets.only(bottom: 5),
                icon: Icon(widget.userTabIndex == 0? Icons.home : Icons.home_outlined),
                child: const Text("Home"),
              ),
              const Tab(
                iconMargin: EdgeInsets.only(bottom: 5),

                icon: Icon(CupertinoIcons.search),
                text: 'Explore',
              ),
              Tab(
                iconMargin: const EdgeInsets.only(bottom: 5),

                icon: Icon(widget.userTabIndex == 2? Icons.notifications :Icons.notifications_none_outlined),
                text: 'Notifications',
              ),
              Tab(
                iconMargin: const EdgeInsets.only(bottom: 5),

                icon: Icon(widget.userTabIndex == 3? Icons.people :Icons.people_alt_outlined),
                text: 'Organizers',
              ),
            ],
          ),
        ),
      ),
    );
  }

}
