import 'package:flutter/material.dart';
import 'package:multi_service_planner/modals/OrgProvider.dart';
import 'package:multi_service_planner/modals/OrganizeEventProvider.dart';
import 'package:multi_service_planner/modals/RegisterOrgProvider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'Providers/CacheManager.dart';
import 'Screens/SplashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(

      providers: [
        ChangeNotifierProvider(create: (_) => OrgProvider()),
        ChangeNotifierProvider(create: (_) => OrganizeEventProvider()),
        ChangeNotifierProvider(create: (_) => CacheManagerProvider()),
        ChangeNotifierProvider(create: (_) => RegisterOrgProvider())

      ],
      child: MaterialApp(

        title: 'Multi Service Planner',
        theme: ThemeData(

          fontFamily: "Helvetica"

        ),
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}