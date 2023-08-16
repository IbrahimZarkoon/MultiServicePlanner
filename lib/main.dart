import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialapp/Providers/CacheManager.dart';
import 'package:socialapp/Screens/Dashboard.dart';
import 'package:socialapp/Screens/HomePage.dart';
import 'package:socialapp/Screens/SplashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(

      providers: [
        ChangeNotifierProvider(create: (_) => CacheManagerProvider())
      ],
      child: MaterialApp(

        title: 'Social App',
        theme: ThemeData(

          fontFamily: "Helvetica"

        ),
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}