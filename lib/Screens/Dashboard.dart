import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_service_planner/Response/NotificationModal.dart';
import 'package:multi_service_planner/modals/UserProvider.dart';
import 'package:provider/provider.dart';
import '../CustomWidgets/CustomAppBar.dart';
import '../CustomWidgets/RoundedBottomBar.dart';
import '../Enums/Colors.dart';
import 'ExplorePage.dart';
import 'HomePage.dart';
import 'NotificationsTab.dart';
import 'Organizers.dart';
import 'ProfileDrawer/userDrawer.dart';
import 'package:http/http.dart' as http;

class DashboardPage extends StatefulWidget {
  DashboardPage({Key? key, required this.userTabIndex}) : super(key: key);

  int userTabIndex;

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  List<NotificationModal>? _notifications;
  final userTabs = [
    const HomePage(), // 0
    const ExplorePage(),
    const NotificationsTab(),
    const Services()
  ];

  late TabController _tabController;

  void fetchNoti(UserProvider userProvider) async {
    var url = Uri.parse(
        'https://everythingforpageants.com/msp/api/approveBookPackage.php');
    var response =
        await http.post(url, body: json.encode({"id": userProvider.userID}));
    var decodedJson = jsonDecode(response.body);
    List<dynamic> dataArray = decodedJson;
    final _notifications =
        dataArray.map((item) => NotificationModal.fromJson(item)).toList();

    userProvider.setNotifications(_notifications);
    print(_notifications[0].date);
  }

  @override
  void initState() {
    super.initState();
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);

    fetchNoti(userProvider);

    _tabController = TabController(
        length: 4, vsync: this, initialIndex: widget.userTabIndex);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        endDrawer: Drawer(
          elevation: 10,
          shadowColor: Colors.black.withOpacity(0.5),
          child: userDrawer(context),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight * 2),
          child: CustomAppBar(),
        ),
        body: RepaintBoundary(
            child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: userTabs)),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(color: const Color(0xfff9f9f9), boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 1.5,
                spreadRadius: 1,
                offset: const Offset(0, -1))
          ]),
          height: kToolbarHeight + 15,
          child: TabBar(
            dividerColor: const Color(0xfff1f1f1),
            padding: const EdgeInsets.all(0),
            physics: const NeverScrollableScrollPhysics(),
            indicator: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: appPrimary,
                  width: 3.0,
                ),
              ),
            ),
            controller: _tabController,
            indicatorColor: Colors.white,
            unselectedLabelColor: Colors.black.withOpacity(0.35),
            labelColor: appPrimary,
            labelStyle: const TextStyle(fontSize: 11),
            onTap: (int index) {
              setState(() {
                widget.userTabIndex = index;
              });
            },
            tabs: [
              Tab(
                iconMargin: const EdgeInsets.only(bottom: 5),
                icon: Icon(widget.userTabIndex == 0
                    ? Icons.home
                    : Icons.home_outlined),
                child: const Text("Home"),
              ),
              const Tab(
                iconMargin: EdgeInsets.only(bottom: 5),
                icon: Icon(CupertinoIcons.search),
                text: 'Explore',
              ),
              Tab(
                iconMargin: const EdgeInsets.only(bottom: 5),
                icon: Icon(widget.userTabIndex == 2
                    ? Icons.notifications
                    : Icons.notifications_none_outlined),
                text: 'Notifications',
              ),
              Tab(
                iconMargin: const EdgeInsets.only(bottom: 5),
                icon: Icon(widget.userTabIndex == 3
                    ? Icons.people
                    : Icons.people_alt_outlined),
                text: 'Services',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
