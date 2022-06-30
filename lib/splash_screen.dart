import 'dart:async';

import 'package:civildeal_user_app/Screens/home_page.dart';
import 'package:civildeal_user_app/Utils/routs.dart';
import 'package:civildeal_user_app/Widget/theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () {
      checkLogin();
    });
  }

  void checkLogin() async{

    SharedPreferences pref = await SharedPreferences.getInstance();
    String? val = pref.getString("id");
    if(val != null){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
    }else if(val==null){
      print(val);
      Navigator.pushNamed(context, MyRoutes.onboardingRoute);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/cd_image.jpeg',
              height: 300,
              width: 300,
            ),
            SizedBox(
              height: 20,
            ),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(MyTheme.skyblue),
            )
          ],
        ),
      ),
    );
  }
}
