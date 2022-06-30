import 'dart:convert';

import 'package:civildeal_user_app/Model/OrderhistoryModel.dart';
import 'package:civildeal_user_app/Widget/theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class OrderPage extends StatefulWidget {

  OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {

  late String user_id;

  void getCred() async{

    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      user_id = pref.getString("id")!;
    });

  }


  Future<OrderhistoryModel> getorderHistory (String id) async{
    final response = await http.post(Uri.parse("https://civildeal.com/civilmall/api/getUserOrders"),
        body: {
          'user_id':id,
        }
    );
    var data = jsonDecode(response.body.toString());

    if(response.statusCode==200){
      var status= data["status"];

      if(status=='Success'){

        return OrderhistoryModel.fromJson(data);
      }else{

        return OrderhistoryModel.fromJson(data);
      }
    }
    else
    {
      return OrderhistoryModel.fromJson(data);
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
        title: Text("Order History"),
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
                child: FutureBuilder<OrderhistoryModel>(
                  future: getorderHistory(user_id),
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
                                child: InkWell(
                                  onTap: (){
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //       builder: (context) => ProductDetailsPage(id: snapshot.data!.data![position].productId!.toString(),
                                    //           product_name: snapshot.data!.data![position].name.toString(),
                                    //           min_quantity:snapshot.data!.data![position].minOrderLimit??0),
                                    //     ));
                                  },
                                  child: Container(
                                    child: Row(
                                      children: [
                                        Expanded(
                                            flex:35,
                                            child: Container(
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(top: 5.0,left: 5.0,bottom: 5.0),
                                                    child: Container(
                                                      height:120,
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          image: DecorationImage(
                                                            fit: BoxFit.fill,
                                                            image: NetworkImage("https://civildeal.com/civilmall/public/images/product/" +snapshot.data!.data![position].productImage!.toString()),
                                                          )
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(3.0),
                                                    child: Text(snapshot.data!.data![position].addedDate!.toString(),
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
                                          flex: 65,
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 15.0,right: 5.0,bottom: 5.0),
                                            child: Container(
                                              height: 150,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(snapshot.data!.data![position].productName.toString().trim(),
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold
                                                    ),),
                                                  Text("Quantity : "+snapshot.data!.data![position].quantity.toString(),
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey,
                                                    ),),
                                                  Text("Total Price : "+snapshot.data!.data![position].totalPrice.toString()+" ₹",
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                    ),),
                                                  SelectableText("Order Id : "+snapshot.data!.data![position].orderId.toString(),
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.blue,
                                                    ),),
                                                  SelectableText("Payment Id : "+snapshot.data!.data![position].transactionId.toString(),
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                    ),),
                                                  Text("Order Status : "+snapshot.data!.data![position].status.toString(),
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.bold
                                                    ),),
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
                              ),
                            );
                          });
                    }else if(snapshot.hasError){
                      return Center(child: Text("No Post Found"));
                    }else{
                      return Container(
                        child: Center(child: CircularProgressIndicator(),),
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
