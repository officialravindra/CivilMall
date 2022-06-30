import 'dart:convert';

import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import 'package:civildeal_user_app/Model/GetInteriorExteriorDetailsModel.dart';
import 'package:civildeal_user_app/Screens/interior_downloadImage.dart';
import 'package:civildeal_user_app/Widget/theme.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../Services/Utilities/app_url.dart';

class InteriorDetailsScreen extends StatefulWidget {
  String id,category_name;
  InteriorDetailsScreen({Key? key, required this.id, required this.category_name}) : super(key: key);

  @override
  State<InteriorDetailsScreen> createState() => _InteriorDetailsScreenState(id,category_name);
}

class _InteriorDetailsScreenState extends State<InteriorDetailsScreen> {
  String id,category_name;
  _InteriorDetailsScreenState(this.id,this.category_name);

  List images = [];

  Future<GetInteriorExteriorDetailsModel> getInteriordetails () async{
    print(id);
    final response = await http.post(Uri.parse(AppUrl.getInteriorDetailsApi),
        body: {
          'id':id,
        }
    );
    var data = jsonDecode(response.body.toString());
    if(response.statusCode==200){
      var responseData = json.decode(response.body);
      var status= responseData["status"];
      var message= responseData["message"];

      if(status=="Success"){
        return GetInteriorExteriorDetailsModel.fromJson(data);
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
        return GetInteriorExteriorDetailsModel.fromJson(data);
      }
    }
    else
    {
      return GetInteriorExteriorDetailsModel.fromJson(data);
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    getInteriordetails();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category_name),
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
            FutureBuilder<GetInteriorExteriorDetailsModel>(
              future: getInteriordetails(),
              builder: (context,snapshot){
                if(snapshot.hasData){
                  images = snapshot.data!.image!;
                  return Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Text(category_name.toString().toUpperCase(),
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                            ),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),

                            ),
                            child: SizedBox(
                              height: 250,
                              width: double.infinity,
                              child: Carousel(
                                animationDuration: Duration(seconds: 2),
                                autoplay: false,
                                dotSpacing: 15,
                                dotSize: 6.0,
                                dotIncreasedColor: Colors.red,
                                dotBgColor: Colors.transparent,
                                indicatorBgPadding: 10.0,
                                images: images.map((item)=>Container(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30.0),
                                    child: InkWell(
                                      onTap: (){
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => InteriorDownloadImageScreen(image: item),
                                            ));
                                      },
                                      child: Container(
                                        height: MediaQuery.of(context).size.height / 5,
                                        width: MediaQuery.of(context).size.width / 1.2,
                                        child: Image.network(item??"assets/images/cd_image.jpeg",
                                          fit: BoxFit.cover,
                                        ),
                                        // child: FadeInImage.assetNetwork(
                                        //   placeholder: 'assets/images/cd_image.jpeg',
                                        //   image: item,
                                        //   imageErrorBuilder: (c, o, s) => Image.asset('assets/images/cd_image.jpeg', fit: BoxFit.cover),
                                        //   fit: BoxFit.cover,
                                        // ),
                                      ),
                                    ),
                                  ),
                                )).toList(),
                              ),
                            ),
                          ),
                        ),
                        Text("Size "+snapshot.data!.size.toString())
                      ],
                    ),
                  );
                }else if(snapshot.hasError){
                  return Center(child: Text("No Data Found"));
                }else{
                  return Container(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
              },

            ),
          ],
        ),

      ),
    );
  }
}
