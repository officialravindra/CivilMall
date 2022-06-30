import 'dart:convert';

import 'package:civildeal_user_app/Screens/drawing_dialog.dart';
import 'package:civildeal_user_app/Screens/interior_exterior_dialog.dart';
import 'package:civildeal_user_app/Screens/login_page.dart';
import 'package:civildeal_user_app/Screens/profilePage.dart';
import 'package:civildeal_user_app/Widget/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../Utils/routs.dart';

class MyDrawer extends StatefulWidget {

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  String? user_image,name,lastname,mobile,location_name,user_id;
  void getCred() async{

    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      user_id = pref.getString("id");
      user_image = pref.getString("path_image");
      name = pref.getString("name");
      lastname = pref.getString("lastname");
      mobile = pref.getString("mobile");
      location_name = pref.getString("location_name");
      print(user_image);
      print(name);
    });

  }



  @override
  void initState() {
    // TODO: implement initState
    getCred();
    super.initState();
  }
  void profileRoute() async{

    SharedPreferences pref = await SharedPreferences.getInstance();
    String? val = pref.getString("id");
    if(val != null){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => ProfilePage()), (route) => false);
    }else{
      Navigator.pushNamed(context, MyRoutes.loginRoute);
      Fluttertoast.showToast(
          msg: "Login Please",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }
  @override
  Widget build(BuildContext context) {

    final image_url = "https://scontent.fslv1-1.fna.fbcdn.net/v/t1.6435-9/74876766_2611202742303111_3401555287444815872_n.jpg?_nc_cat=110&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=w90IBYludGwAX9gVL5T&_nc_ht=scontent.fslv1-1.fna&oh=15a0b9f3449e65ad92cf3ea4ea919b51&oe=619F8B22";

    return Padding(
      padding: const EdgeInsets.only(right: 80),
      child: Drawer(
        backgroundColor: MyTheme.skyblue,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
                padding: EdgeInsets.zero,
                child: UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    color: MyTheme.skyblue
                  ),
                  accountName: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 18.0),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Text(name??"Guest",style: TextStyle(
                                color: Colors.white
                            ),),
                          ),
                          Text(" ",style: TextStyle(
                              color: Colors.white
                          ),),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Text(lastname??"",style: TextStyle(
                                color: Colors.white
                            ),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0,right: 15.0),
                            child: TextButton.icon(     // <-- TextButton
                              onPressed: () {},
                              icon: Icon(
                                Icons.place,
                                size: 16.0,
                                color: Colors.white,
                              ),
                              label: Text(location_name??"",style: TextStyle(
                                color: Colors.white
                              ),),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  accountEmail: Text(mobile??"", style: TextStyle(color: Colors.white),),
                  currentAccountPicture: Container(
                    height: 100,
                    width: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40.0),
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/images/man.png',
                        image: user_image??"assets/images/man.png",
                        imageErrorBuilder: (c, o, s) => Image.asset('assets/images/man.png', fit: BoxFit.cover),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),


                )),

            InkWell(
              onTap: (){
                Navigator.pushNamed(context, MyRoutes.homeRoute);
              },
              child: ListTile(
                leading: Icon(
                    CupertinoIcons.home,
                  color: Colors.white,
                ),
                title: Text("Home",style: TextStyle(
                  color: Colors.white
                ),),
              ),
            ),

            InkWell(
              onTap: (){
                Navigator.pushNamed(context, MyRoutes.civilmallRoute);
                // Fluttertoast.showToast(
              //   msg: "Coming Soon" ,
              //   toastLength: Toast.LENGTH_SHORT,
              //   gravity: ToastGravity.CENTER,
              //   timeInSecForIosWeb: 1,
              //   backgroundColor: Colors.black,
              //   textColor: Colors.white,
              //   fontSize: 16.0);
               },
              child: ListTile(
                leading: Icon(
                  CupertinoIcons.sportscourt,
                  color: Colors.white,
                ),
                title: Text("Civil Mall",style: TextStyle(
                    color: Colors.white
                ),),
              ),
            ),
            InkWell(
              onTap: (){
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return InteriorDialog();
                    });

              },
              child: ListTile(
                leading: Icon(
                  CupertinoIcons.bed_double,
                  color: Colors.white,
                ),
                title: Text("Interior & Exterior",style: TextStyle(
                    color: Colors.white
                ),),
              ),
            ),
            InkWell(
              onTap: (){
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CustomDialog();
                    });

              },
              child: ListTile(
                leading: Icon(
                  CupertinoIcons.hand_draw,
                  color: Colors.white,
                ),
                title: Text("Drawing",style: TextStyle(
                    color: Colors.white
                ),),
              ),
            ),

            InkWell(
              onTap: (){
                Navigator.pushNamed(context, MyRoutes.postRequirmentRoute);
              },
              child: ListTile(
                leading: Icon(
                    CupertinoIcons.doc_checkmark,
                  color: Colors.white,
                ),
                title: Text("Post Requirment",style: TextStyle(
                    color: Colors.white
                ),),
              ),
            ),

            InkWell(
              onTap: (){
                Navigator.pushNamed(context, MyRoutes.projectPostRoute);
              },
              child: ListTile(
                leading: Icon(
                    CupertinoIcons.list_bullet,
                  color: Colors.white,
                ),
                title: Text("Project Post",style: TextStyle(
                    color: Colors.white
                ),),
              ),
            ),

            InkWell(
              onTap: (){
                Navigator.pushNamed(context, MyRoutes.checkBidRoute);
              },
              child: ListTile(
                leading: Icon(
                    CupertinoIcons.square_grid_2x2,
                  color: Colors.white,
                ),
                title: Text("Check Bid",style: TextStyle(
                    color: Colors.white
                ),),
              ),
            ),

            InkWell(
              onTap: (){
                Navigator.pushNamed(context, MyRoutes.blogWebviewRoute);
              },
              child: ListTile(
                leading: Icon(
                  CupertinoIcons.doc_text_search,
                  color: Colors.white,
                ),
                title: Text("Blog",style: TextStyle(
                    color: Colors.white
                ),),
              ),
            ),

            InkWell(
              onTap: (){
                profileRoute();

              },
              child: ListTile(
                leading: Icon(
                    CupertinoIcons.person_alt,
                  color: Colors.white,
                ),
                title: Text("Profile",style: TextStyle(
                    color: Colors.white
                ),),
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.pushNamed(context, MyRoutes.orderRoute);
              },
              child: ListTile(
                leading: Icon(
                  CupertinoIcons.clock_fill,
                  color: Colors.white,
                ),
                title: Text("Order",style: TextStyle(
                    color: Colors.white
                ),),
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.pushNamed(context, MyRoutes.contactUsRoute);
              },
              child: ListTile(
                leading: Icon(
                  CupertinoIcons.phone,
                  color: Colors.white,
                ),
                title: Text("Contact Us",style: TextStyle(
                    color: Colors.white
                ),),
              ),
            ),
            InkWell(

              onTap: () async{
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Confirm Sign out'),
                        content: Text('Are  sure to sign out from app now?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context, false);
                            },
                            child: Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () async {
                              SharedPreferences pref = await SharedPreferences.getInstance();
                              await pref.clear();
                              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);

                            },
                            child: Text('Yes and Confirm'),
                          )
                        ],
                        elevation: 15,
                      );
                    });

              },
              child: ListTile(
                leading: Icon(
                    CupertinoIcons.square_arrow_left,
                  color: Colors.white,
                ),
                title: Text("LogOut",style: TextStyle(
                    color: Colors.white
                ),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
