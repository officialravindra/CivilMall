import 'dart:convert';

import 'package:civildeal_user_app/Model/MaintenanceModel.dart';
import 'package:civildeal_user_app/Model/ServiceModel.dart';
import 'package:civildeal_user_app/Screens/serviceVendors.dart';
import 'package:civildeal_user_app/Services/Utilities/app_url.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:touchable_opacity/touchable_opacity.dart';

import '../Widget/theme.dart';

class SeeAllMaintenancePage extends StatefulWidget {
  String city_id;
  SeeAllMaintenancePage({Key? key, required this.city_id}) : super(key: key);

  @override
  State<SeeAllMaintenancePage> createState() => _SeeAllMaintenancePageState(city_id);
}

class _SeeAllMaintenancePageState extends State<SeeAllMaintenancePage> {
  String city_id;
  _SeeAllMaintenancePageState(this.city_id);

  Future<MaintenanceModel> getMaintenance () async{
    final response = await http.get(Uri.parse("https://civildeal.com/Api/getMaintenance"));
    var data = jsonDecode(response.body.toString());
    var code= data["code"];
    if(response.statusCode==200){
      if(code == 200){
        return MaintenanceModel.fromJson(data);
      }
      else{
        return MaintenanceModel.fromJson(data);
      }

    }
    else{
      return MaintenanceModel.fromJson(data);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Maintenance"),
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
            Expanded(
              child: FutureBuilder<MaintenanceModel>(
                future: getMaintenance(),
                builder: (context , snapshot){
                  if(snapshot.hasData){
                    return GridView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.data!.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                          childAspectRatio: (0.5 / 0.50)),
                      itemBuilder: (context,position){
                        return TouchableOpacity(
                          activeOpacity: 0.2,
                          child: InkWell(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Vendors(id: snapshot.data!.data![position].id!.toString(),city_id: city_id.toString(),vendor_type: "service" ),
                                  ));
                            },
                            child: Card(
                              elevation: 5,
                              child: Container(
                                height: MediaQuery.of(context).size.height *.25,
                                width: MediaQuery.of(context).size.width *.26,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height:120,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: NetworkImage("https://civildeal.com/public/assets/uploadsservice/" +snapshot.data!.data![position].bannerImage!.toString()),
                                          )
                                      ),
                                    ),
                                    Center(child: Padding(
                                      padding: const EdgeInsets.only(top: 5.0,left: 5.0,right: 5.0,bottom: 2.0),
                                      child: Text(
                                        snapshot.data!.data![position].name!.toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 14
                                        ),
                                      ),
                                    ))
                                  ],
                                ),

                              ),
                            ),
                          ),
                        );
                      },
                    );

                  }else{
                    return Container(
                      width: double.infinity,
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
