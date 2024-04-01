import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:myactivity/utils/colors.dart';
import 'package:myactivity/view/home_page.dart';

import 'package:firebase_core/firebase_core.dart';

import 'login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(apiKey: 'AIzaSyBRCAS5z2YPfFp8sde4dOW9cfgdMTSiiJw', appId: 'appId', messagingSenderId: '', projectId: ''),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Intro Screen',
      theme: ThemeData(
          textTheme: const TextTheme(
            displayLarge: TextStyle(
              fontSize: 30,
              color: MyColors.titleTextColor,
              fontWeight: FontWeight.bold,
            ),
            displayMedium: TextStyle(
                fontSize: 18,
                color: MyColors.subTitleTextColor,
                fontWeight: FontWeight.w400,
                wordSpacing: 1.2,
                height: 1.2),
            displaySmall: TextStyle(
              fontSize: 18,
              color: MyColors.titleTextColor,
              fontWeight: FontWeight.bold,
            ),
            headlineMedium: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          )),
      home:  MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    initializeDefault();
    super.initState();
    Timer(Duration(seconds: 3),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                HomePage()
            )
        )
    );
  }
  Future<FirebaseApp?> initializeDefault() async {
    FirebaseApp app = await Firebase.initializeApp(

    );
    return app;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child:FlutterLogo(size:MediaQuery.of(context).size.height)
    );
  }
}