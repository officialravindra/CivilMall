import 'dart:convert';

import 'package:civildeal_user_app/Utils/routs.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:civildeal_user_app/Model/VendorProfileModel.dart';
import 'package:civildeal_user_app/Widget/theme.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();


}

class _ProfilePageState extends State<ProfilePage> {

  late String vendor_id;
  void getCred() async{

    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      vendor_id = pref.getString("id")!;
      print(vendor_id);
    });

  }

  Future<VendorProfileModel> getVendorProfile () async{

    final response = await http.post(Uri.parse("https://civildeal.com/Api/getVendorProfile"),
        body: {
          'vendor_id':vendor_id,
        }
    );
    var data = jsonDecode(response.body.toString());

    if(response.statusCode==200){
      var responseData = json.decode(response.body);
      var code= responseData["code"];
      var message= responseData["message"];

      if(code==200){
        return VendorProfileModel.fromJson(data);
      }else{
        Fluttertoast.showToast(
            msg: message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        return VendorProfileModel.fromJson(data);
      }
    }
    else
    {
      return VendorProfileModel.fromJson(data);
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCred();
    getVendorProfile();
  }
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vendor Profile"),
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
      body: SingleChildScrollView(
        child: Material(
          child: FutureBuilder<VendorProfileModel>(
            future: getVendorProfile(),
            builder: (context, snapshot){
              if(snapshot.hasData){
                return Container(
                  child: Column(
                    children: [
                      Container(
                        color: MyTheme.creamColor,
                        child: Column(
                          children: [
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 30.0),
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50.0),
                                    child: FadeInImage.assetNetwork(
                                      placeholder: 'assets/images/man.png',
                                      image: "https://civildeal.com/public/assets/uploads/vendor/" +snapshot.data!.data![0].userimage.toString(),
                                      imageErrorBuilder: (c, o, s) => Image.asset('assets/images/man.png', fit: BoxFit.cover),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: Text(snapshot.data!.data![0].name.toString()+ " " +snapshot.data!.data![0].lastname.toString(),
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 14
                                  ),),
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 5.0,bottom: 20.0),
                                child: Text(snapshot.data!.data![0].mobile.toString(),
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 14
                                  ),),
                              ),
                            ),

                            // Padding(
                            //   padding: const EdgeInsets.only(bottom: 15.0),
                            //   child: Container(
                            //     width: 100,
                            //     child: InkWell(
                            //       onTap: (){
                            //         // Navigator.pushNamed(context, MyRoutes.editprofileRoute);
                            //         // Navigator.of(context).push(new MaterialPageRoute(builder: (context) => EditProfilePage())).whenComplete(getVendorProfile);
                            //         Navigator.pushNamed(context, MyRoutes.editprofileRoute).then((_) {
                            //           // This block runs when you have returned back from screen 2.
                            //           setState(() {
                            //             // code here to refresh data
                            //             getVendorProfile();
                            //           });
                            //         });
                            //       },
                            //       child: Card(
                            //           child: Center(
                            //               child: Padding(
                            //                 padding: const EdgeInsets.all(5.0),
                            //                 child: Text("Edit Profile"),
                            //               ))),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 20.0,left: 10.0,right: 10.0),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          decoration: BoxDecoration(

                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                                color: Colors.black45, style: BorderStyle.solid, width: 0.80),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(snapshot.data!.data![0].name.toString()),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0,left: 10.0,right: 10.0),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          decoration: BoxDecoration(

                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                                color: Colors.black45, style: BorderStyle.solid, width: 0.80),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(snapshot.data!.data![0].mobile.toString()),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0,left: 10.0,right: 10.0),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          decoration: BoxDecoration(

                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                                color: Colors.black45, style: BorderStyle.solid, width: 0.80),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(snapshot.data!.data?[0].address.toString()??"",
                                    maxLines: 2,
                                    softWrap: true,
                                    overflow: TextOverflow.fade,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0,left: 10.0,right: 10.0),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          decoration: BoxDecoration(

                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                                color: Colors.black45, style: BorderStyle.solid, width: 0.80),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(snapshot.data!.data?[0].email.toString()??""),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 15.0,left: 10.0,right: 10.0),
                      //   child: Container(
                      //
                      //     width: double.infinity,
                      //     padding: EdgeInsets.symmetric(horizontal: 10.0),
                      //     decoration: BoxDecoration(
                      //
                      //       borderRadius: BorderRadius.circular(10.0),
                      //       border: Border.all(
                      //           color: Colors.black45, style: BorderStyle.solid, width: 0.80),
                      //     ),
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.start,
                      //       children: [
                      //         Padding(
                      //           padding: const EdgeInsets.all(8.0),
                      //           child: Text(snapshot.data!.data![0].vendorType!.toString()),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 15.0,left: 10.0,right: 10.0),
                      //   child: Container(
                      //     width: double.infinity,
                      //     padding: EdgeInsets.symmetric(horizontal: 10.0),
                      //     decoration: BoxDecoration(
                      //
                      //       borderRadius: BorderRadius.circular(10.0),
                      //       border: Border.all(
                      //           color: Colors.black45, style: BorderStyle.solid, width: 0.80),
                      //     ),
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.start,
                      //       children: [
                      //         Padding(
                      //           padding: const EdgeInsets.all(8.0),
                      //           child: Text(snapshot.data!.data![0].pan.toString()),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 15.0,left: 10.0,right: 10.0,bottom: 20.0),
                      //   child: Container(
                      //     width: double.infinity,
                      //     padding: EdgeInsets.symmetric(horizontal: 10.0),
                      //     decoration: BoxDecoration(
                      //
                      //       borderRadius: BorderRadius.circular(10.0),
                      //       border: Border.all(
                      //           color: Colors.black45, style: BorderStyle.solid, width: 0.80),
                      //     ),
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.start,
                      //       children: [
                      //         Flexible(
                      //           child: Padding(
                      //             padding: const EdgeInsets.all(5.0),
                      //             child: Text(snapshot.data!.data![0].shortDescription!.toString(),
                      //               maxLines: 3,
                      //               softWrap: true,
                      //               overflow: TextOverflow.fade,
                      //             ),
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0,right: 15.0,top: 30.0,bottom: 50.0),
                        child: Container(
                          height: 50,
                          width: 200,
                          child: Material(
                            color: MyTheme.skyblue,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                            elevation: 6.0,
                            //shadowColor: Colors.grey[50],

                            child: InkWell(
                              splashColor: const Color(0x8034b0fc),
                              onTap: () {
                                Navigator.pushNamed(context, MyRoutes.editprofileRoute).then((_) {
                                  // This block runs when you have returned back from screen 2.
                                  setState(() {
                                    // code here to refresh data
                                    getVendorProfile();
                                  });
                                });
                              },
                              child: Container(

                                //decoration: ,

                                child: Center(
                                  child: Text(
                                    'Edit Profile',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
              else if(snapshot.hasError){
                return Center(child: Text("Please wait"));
              }else{
                return Container(
                  child: Center(child: CircularProgressIndicator()),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
