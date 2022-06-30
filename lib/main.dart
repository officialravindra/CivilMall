import 'package:civildeal_user_app/Screens/blog_webview.dart';
import 'package:civildeal_user_app/Screens/cart_screen.dart';
import 'package:civildeal_user_app/Screens/checkBidPage.dart';
import 'package:civildeal_user_app/Screens/civilmallScreen.dart';
import 'package:civildeal_user_app/Screens/confirm_password.dart';
import 'package:civildeal_user_app/Screens/contact_us_page.dart';
import 'package:civildeal_user_app/Screens/editProfile.dart';
import 'package:civildeal_user_app/Screens/forget_password.dart';
import 'package:civildeal_user_app/Screens/order_page.dart';
import 'package:civildeal_user_app/Screens/postRequirmentPage.dart';
import 'package:civildeal_user_app/Screens/profilePage.dart';
import 'package:civildeal_user_app/Screens/projectPostPage.dart';
import 'package:civildeal_user_app/Screens/verify_otp.dart';
import 'package:civildeal_user_app/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'Screens/home_page.dart';
import 'Screens/interestedVendorsPage.dart';
import 'Screens/login_page.dart';
import 'Screens/onboarding.dart';
import 'Screens/register.dart';
import 'Utils/routs.dart';
import 'Widget/theme.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    // 'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}

Future<void> main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: HomePage(),
      themeMode: ThemeMode.light,
      theme: MyTheme.lightTheme(context),
      darkTheme: MyTheme.darkTheme(context),
      debugShowCheckedModeBanner: false,


      routes: {
        "/": (context) => SplashScreen(),
        MyRoutes.homeRoute: (context) => HomePage(),
        MyRoutes.civilmallRoute: (context) => CivilMallPage(),
        MyRoutes.loginRoute: (context) => LoginPage(),
        MyRoutes.onboardingRoute: (context) => OnboardingScreen(),
        MyRoutes.registerRoute: (context) => UserRegister(),
        MyRoutes.forgetPasswordRoute: (context) => ForgetPassword(),
        // MyRoutes.verifyotpRoute: (context) => VerifyOtpPage(),
        // MyRoutes.confirmPasswordRoute: (context) => ConfirmPasswordPage(),
        MyRoutes.postRequirmentRoute: (context) => PostRequriment(),
        MyRoutes.checkBidRoute: (context) => CheckBidPage(),
        MyRoutes.interestedVendorsRoute: (context) => InterestedVendorsPage(id: '',),
        MyRoutes.projectPostRoute: (context) => ProjectPostPage(),
        // MyRoutes.seeAllServiceRoute: (context) => SeeAllVendorsPage(),
        MyRoutes.editprofileRoute: (context) => EditProfilePage(),
        MyRoutes.profileRoute: (context) => ProfilePage(),
        MyRoutes.cartRoute: (context) => CartScreenPage(),
        MyRoutes.blogWebviewRoute: (context) => BlogWebviewScreen(),
        MyRoutes.orderRoute: (context) => OrderPage(),
        MyRoutes.contactUsRoute: (context) => ContactUsPage(),
        // MyRoutes.freeListingRoute: (context) => FreeListingPage(),
      },
    );
  }

}

