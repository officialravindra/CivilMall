import 'dart:convert';

import 'package:civildeal_user_app/Model/VendorsModel.dart';
import 'package:civildeal_user_app/Screens/vendorProfile.dart';
import 'package:civildeal_user_app/Widget/theme.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class MaintenanceVendors extends StatefulWidget {
  String id;
  MaintenanceVendors({Key? key, required this.id}) : super(key: key);

  @override
  State<MaintenanceVendors> createState() => _MaintenanceVendorsState(id);
}

class _MaintenanceVendorsState extends State<MaintenanceVendors> {
  String id;
  _MaintenanceVendorsState(this.id);
  List vendorsList = [];

  late String vendor_type;
  void getCred() async{

    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      vendor_type = pref.getString("vendor_type")!;
      print(vendor_type);
    });

  }

  Future<VendorsModel> getServiceVendors (String id) async{

    final response = await http.post(Uri.parse("https://civildeal.com/Api/vendorlist"),
        body: {
          'id':id,
          'city_id':"1",
          'vendor_type':"maintenance",
        }
    );
    print(id);
    var data = jsonDecode(response.body.toString());

    if(response.statusCode==200){
      var responseData = json.decode(response.body);
      var code= responseData["code"];
      var message= responseData["message"];
      setState(() {
        vendorsList = data['data'];
      });
      if(code==200){
        return VendorsModel.fromJson(data);
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
        return VendorsModel.fromJson(data);
      }
    }
    else
    {
      return VendorsModel.fromJson(data);
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCred();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vendors"),
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
        color: MyTheme.creamColor,
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<VendorsModel>(
                future: getServiceVendors(id),
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data!.data!.length,
                        itemBuilder: (context,position){
                          return Padding(
                            padding: const EdgeInsets.only(left: 5.0,right: 5.0),
                            child: Card(
                              elevation: 1,
                              child: Container(
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex:30,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 5.0,left: 5.0,bottom: 5.0),
                                        child: Container(
                                          height:100,
                                          width: 100,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: NetworkImage("https://civildeal.com/public/assets/uploads/vendor/" +snapshot.data!.data![position].userimage!.toString()),
                                              )
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 70,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 10.0,right: 5.0,top: 3.0,bottom: 3.0),
                                        child: Container(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(height: 5,),
                                              Text(snapshot.data!.data![position].companyName.toString(),
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold
                                                ),),
                                              SizedBox(height: 3,),
                                              Text("Service : "+snapshot.data!.data![position].serviceProuductName.toString(),
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black,
                                                ),),
                                              SizedBox(height: 3,),
                                              Text("Experience : "+snapshot.data!.data![position].experience.toString(),
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                ),),
                                              SizedBox(height: 3,),
                                              Text("Location : "+snapshot.data!.data![position].locationName.toString(),
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.blue,
                                                ),),
                                              SizedBox(height: 5,),
                                              InkWell(
                                                onTap: (){
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) => VendorProfile(id: snapshot.data!.data![position].id!.toString(),),
                                                      ));
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.only(right: 15.0),
                                                  child: Align(
                                                    alignment: Alignment.centerRight,
                                                    child: Container(
                                                      height: 30,
                                                      width: 60,
                                                      decoration: BoxDecoration(
                                                          color: Colors.teal,
                                                          borderRadius: BorderRadius.circular(5)
                                                      ),
                                                      child: Center(child: Text("View",
                                                        style: TextStyle(
                                                            color: Colors.white
                                                        ),)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 5,),
                                            ],
                                          ),

                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  }else if(snapshot.hasError){
                    return Center(child: Text("No Vendor Found"));
                  }else{
                    return Container(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
