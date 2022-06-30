import 'dart:convert';

import 'package:civildeal_user_app/Model/InterestedVendorsModel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../Widget/theme.dart';

class InterestedVendorsPage extends StatefulWidget {
  String id;
  InterestedVendorsPage({Key? key,required this.id}) : super(key: key);

  @override
  State<InterestedVendorsPage> createState() => _InterestedVendorsPageState(id);
}

class _InterestedVendorsPageState extends State<InterestedVendorsPage> {
  String id;
  _InterestedVendorsPageState(this.id);

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<InterestedVendorsModel> getProjectPostList () async{

    final response = await http.post(Uri.parse("https://civildeal.com/Api/getVendorBidsList"),
        body: {
          'post_id':id,
        }
    );
    var data = jsonDecode(response.body.toString());

    if(response.statusCode==200){
      var responseData = json.decode(response.body);
      var code= responseData["code"];
      var message= responseData["message"];

      if(code==200){
        return InterestedVendorsModel.fromJson(data);
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
        return InterestedVendorsModel.fromJson(data);
      }
    }
    else
    {
      return InterestedVendorsModel.fromJson(data);
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Interested Vendors"),
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
              child: FutureBuilder<InterestedVendorsModel>(
                future: getProjectPostList(),
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
                                      flex: 70,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 10.0,right: 5.0,top: 3.0,bottom: 3.0),
                                        child: Container(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("Name : "+snapshot.data!.data![position].name.toString().trim(),
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold
                                                ),),
                                              Text("Amount : "+snapshot.data!.data![position].bidAmount.toString()+" ₹",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black,
                                                ),),
                                              Text("Estimated time : "+snapshot.data!.data![position].estimateTime.toString(),
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                ),),
                                              Text("Date : "+snapshot.data!.data![position].createdAt.toString(),
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.blue,
                                                ),),
                                              SizedBox(height: 5,),
                                              Container(
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    InkWell(
                                                      onTap: (){
                                                        setState(() {
                                                          _makePhoneCall('tel:'+snapshot.data!.data![position].mobile.toString());
                                                        });
                                                      },
                                                      child: Container(
                                                        height: 30,
                                                        decoration: BoxDecoration(
                                                            color: MyTheme.skyblue,
                                                            borderRadius: BorderRadius.circular(5)
                                                        ),
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(5.0),
                                                          child: Center(child: Text(snapshot.data!.data![position].mobile.toString(),
                                                            style: TextStyle(
                                                                color: Colors.white
                                                            ),)),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 5,)


                                            ],
                                          ),

                                        ),
                                      ),
                                    ),
                                    Expanded(
                                        flex:30,
                                        child: Padding(
                                          padding: const EdgeInsets.only(right: 8.0),
                                          child: Container(
                                            child: Column(
                                              children: [
                                                Padding(
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
                                              ],
                                            ),
                                          ),
                                        )

                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  }else{
                    return Text("Loading...");
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
