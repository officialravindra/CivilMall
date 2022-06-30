import 'dart:io';

import 'package:civildeal_user_app/Widget/theme.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({Key? key}) : super(key: key);

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  openwhatsapp(String mobile) async{
    print(mobile);
    var whatsappURl_android = "whatsapp://send?phone="+mobile+"&text=hello";
    var whatappURL_ios ="https://wa.me/$mobile?text=${Uri.parse("hello")}";
    if(Platform.isIOS){
      // for iOS phone only
      if( await canLaunch(whatappURL_ios)){
        await launch(whatappURL_ios, forceSafariVC: false);
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: new Text("whatsapp not installed")));
      }
    }else{
      // android , web
      if( await canLaunch(whatsappURl_android)){
        await launch(whatsappURl_android);
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: new Text("whatsapp not installed")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Us"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: <Color>[
                MyTheme.lightorange,
                MyTheme.orange
              ],
            ),
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Card(
              elevation: 5,
              child: Container(
                color: MyTheme.skyblue,
                width: double.infinity,
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    Text("You can call us between 9 am to 8 pm",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16
                    ),),
                    SizedBox(height: 20,),
                    InkWell(
                      onTap: (){
                        _makePhoneCall('tel:'+"9983830099");
                      },
                      child: Container(
                        height:50,
                        width: 50,
                        child: Center(
                          child: CircleAvatar(
                            backgroundImage: AssetImage("assets/images/telephone1.png"),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                  ],
                ),
              ),
            ),
            Card(
              elevation: 5,
              child: Container(
                color: MyTheme.skyblue,
                width: double.infinity,
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    Text("Contact us on Whatsapp",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16
                      ),),
                    SizedBox(height: 20,),
                    InkWell(
                      onTap: (){
                        openwhatsapp("+91 "+"9983830099");
                      },
                      child: Container(
                        height:50,
                        width: 50,
                        child: Center(
                          child: CircleAvatar(
                            backgroundImage: AssetImage("assets/images/whats_app.png"),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20,),
            Container(
              height: 300,
                width: double.infinity,
                child: Center(child: Lottie.asset('assets/images/contact_us.json')))
          ],
        ),
      ),

    );
  }
}
