import 'dart:convert';

import 'package:civildeal_user_app/Model/CheckBidModel.dart';
import 'package:civildeal_user_app/Screens/interestedVendorsPage.dart';
import 'package:civildeal_user_app/Widget/theme.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class CheckBidPage extends StatefulWidget {
  const CheckBidPage({Key? key}) : super(key: key);

  @override
  State<CheckBidPage> createState() => _CheckBidPageState();
}

class _CheckBidPageState extends State<CheckBidPage> {
  late String vendor_id;
  void getCred() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      vendor_id = pref.getString("id")!;

      print(vendor_id);

    });
  }

  Future<CheckBidModel> getProjectPostList () async{

    final response = await http.post(Uri.parse("https://civildeal.com/Api/UserProjectPost"),
        body: {
          'user_id':vendor_id,
        }
    );
    var data = jsonDecode(response.body.toString());

    if(response.statusCode==200){
      var responseData = json.decode(response.body);
      var code= responseData["code"];
      var message= responseData["message"];

      if(code==200){
        return CheckBidModel.fromJson(data);
      }else{
        Fluttertoast.showToast(
            msg: "No Post Found",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.SNACKBAR,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0
        );
        return CheckBidModel.fromJson(data);
      }
    }
    else
    {
      return CheckBidModel.fromJson(data);
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
        title: Text("Check Bid"),
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
              child: FutureBuilder<CheckBidModel>(
                future: getProjectPostList(),
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data!.data?.length ?? 0,
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
                                                      image: NetworkImage(snapshot.data!.data![position].imagePath!.toString()+ "/" +snapshot.data!.data![position].images!.toString()),
                                                    )
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(3.0),
                                              child: Text(snapshot.data!.data![position].createdAt!.toString(),
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: MyTheme.skyblue
                                              ),),
                                            )
                                          ],
                                        ),
                                      )

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
                                              Text("Title : "+snapshot.data!.data![position].title.toString().trim(),
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold
                                                ),),
                                              Text("Budget Range : "+snapshot.data!.data![position].minBujet.toString()+ "-" +snapshot.data!.data![position].maxBujet.toString()+" ₹",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black,
                                                ),),
                                              Text("Location : "+snapshot.data!.data![position].locationName.toString(),
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                ),),
                                              Text("Details : "+snapshot.data!.data![position].description.toString(),
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
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) => InterestedVendorsPage(id: snapshot.data!.data![position].id!.toString()),
                                                            ));
                                                      },
                                                      child: Container(
                                                        height: 30,
                                                        decoration: BoxDecoration(
                                                            color: MyTheme.skyblue,
                                                            borderRadius: BorderRadius.circular(5)
                                                        ),
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(5.0),
                                                          child: Center(child: Text("See vendors",
                                                            style: TextStyle(
                                                                color: Colors.white
                                                            ),)),
                                                        ),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: (){
                                                        // addLeadInCart(vendor_id,vendor_type,snapshot.data!.data![position].id.toString());
                                                      },
                                                      child: Container(
                                                        height: 30,
                                                        width: 80,
                                                        decoration: BoxDecoration(
                                                            color: MyTheme.skyblue,
                                                            borderRadius: BorderRadius.circular(5)
                                                        ),
                                                        child: Center(child: Text("Delete",
                                                          style: TextStyle(
                                                              color: Colors.white
                                                          ),)),
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
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  }else if(snapshot.hasError){
                    return Center(child: Text("No Post Found"));
                  }else{
                    return Container(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                },
              ),
            ),
          ],
        )
      ),
    );
  }
}
