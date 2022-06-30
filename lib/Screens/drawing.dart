import 'dart:convert';

import 'package:civildeal_user_app/Model/GetDrawingListmodel.dart';
import 'package:civildeal_user_app/Screens/drawing_details_screen.dart';
import 'package:civildeal_user_app/Services/Utilities/app_url.dart';
import 'package:civildeal_user_app/Widget/theme.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:touchable_opacity/touchable_opacity.dart';

class DrawingScreen extends StatefulWidget {
  String unit_id,size,building_type;
  DrawingScreen({Key? key, required this.unit_id, required this.size, required this.building_type}) : super(key: key);

  @override
  State<DrawingScreen> createState() => _DrawingScreenState(unit_id,size,building_type);
}

class _DrawingScreenState extends State<DrawingScreen> {
  String unit_id,size,building_type;
  _DrawingScreenState(this.unit_id,this.size,this.building_type);

  Future<GetDrawingListmodel> getDrawingList (String unit_id,size,building_type) async{

    final response = await http.post(Uri.parse(AppUrl.getDrawingListApi),
        body: {
          'unit':unit_id,
          'size':size,
          'building_type':building_type,
        }
    );
    var data = jsonDecode(response.body.toString());

    if(response.statusCode==200){
      var responseData = json.decode(response.body);
      var status= responseData["status"];
      var message= responseData["message"];

      if(status=="Success"){
        return GetDrawingListmodel.fromJson(data);
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
        return GetDrawingListmodel.fromJson(data);
      }
    }
    else
    {
      return GetDrawingListmodel.fromJson(data);
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Drawing"),
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
        color: MyTheme.backgroundlayout,
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<GetDrawingListmodel>(
                future: getDrawingList(unit_id,size,building_type),
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
                                    builder: (context) => DrawingDetailsScreen(id: snapshot.data!.data![position].id!.toString(),building_type: building_type),
                                  ));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5.0,right: 5.0),
                              child: Container(
                                height: MediaQuery.of(context).size.height *.25,
                                width: MediaQuery.of(context).size.width *.26,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Card(
                                      elevation:5,
                                      child: Container(
                                        height:135,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: NetworkImage(snapshot.data!.data![position].image!.toString()),
                                            )
                                        ),
                                      ),
                                    ),
                                    Center(child: Padding(
                                      padding: const EdgeInsets.only(top: 10.0,left: 5.0,right: 5.0,bottom: 2.0),
                                      child: Text(
                                        snapshot.data!.data![position].drBuildingType!.toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 15
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
