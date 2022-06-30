import 'dart:convert';

import 'package:civildeal_user_app/Model/GetDrawingListmodel.dart';
import 'package:civildeal_user_app/Model/GetInteriorListmodel.dart';
import 'package:civildeal_user_app/Screens/InteriorDetailsScreen.dart';
import 'package:civildeal_user_app/Screens/drawing_details_screen.dart';
import 'package:civildeal_user_app/Services/Utilities/app_url.dart';
import 'package:civildeal_user_app/Widget/theme.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class InteriorExteriorScreen extends StatefulWidget {
  String category_id,size;
  InteriorExteriorScreen({Key? key, required this.category_id, required this.size}) : super(key: key);

  @override
  State<InteriorExteriorScreen> createState() => _InteriorExteriorScreenState(category_id,size);
}

class _InteriorExteriorScreenState extends State<InteriorExteriorScreen> {
  String category_id,size;
  _InteriorExteriorScreenState(this.category_id,this.size);

  Future<GetInteriorListmodel> getInteriorList (String category_id,size) async{
    print(category_id);
    print(size);
    final response = await http.post(Uri.parse(AppUrl.getInteriorListApi),
        body: {
          'category_id':category_id,
          'size_id':size,
        }
    );
    var data = jsonDecode(response.body.toString());

    if(response.statusCode==200){
      var responseData = json.decode(response.body);
      var status= responseData["status"];
      var message= responseData["message"];

      if(status=="Success"){
        return GetInteriorListmodel.fromJson(data);
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
        return GetInteriorListmodel.fromJson(data);
      }
    }
    else
    {
      return GetInteriorListmodel.fromJson(data);
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
              child: FutureBuilder<GetInteriorListmodel>(
                future: getInteriorList(category_id,size),
                builder: (context , snapshot){
                  if(snapshot.hasData){
                    return GridView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.data!.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                          childAspectRatio: (0.5 / 0.50)),
                      itemBuilder: (context,position){
                        return InkWell(
                          onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => InteriorDetailsScreen(id: snapshot.data!.data![position].id!.toString(),
                                      category_name: snapshot.data!.data![position].categoryName!.toString()),
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
                                      snapshot.data!.data![position].categoryName!.toString(),
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
