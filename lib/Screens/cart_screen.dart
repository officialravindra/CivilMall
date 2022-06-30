import 'dart:convert';

import 'package:civildeal_user_app/Model/GetCartIncrementPrice.dart';
import 'package:civildeal_user_app/Model/GetCartListModel.dart';
import 'package:civildeal_user_app/Widget/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:lottie/lottie.dart';
import 'package:number_inc_dec/number_inc_dec.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartScreenPage extends StatefulWidget {
  const CartScreenPage({Key? key}) : super(key: key);

  @override
  State<CartScreenPage> createState() => _CartScreenPageState();
}

class _CartScreenPageState extends State<CartScreenPage> {
  late Razorpay _razorpay;
  late String user_id,email,mobile;
  // late int quantity=0;
  // late int new_quantity;
  void getCred() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      user_id = pref.getString("id")!;
      email = pref.getString("email")??"";
      mobile = pref.getString("mobile")!;
      getCartLsit(user_id);
      print(user_id);

    });
  }

  int? cartsize;
  late String cart_id;
  int totalCartPrice=0;

  Future<GetCartListModel> getCartLsit(String user_id) async {
    final response = await http
        .post(Uri.parse("https://civildeal.com/civilmall/api/getcartinuser"), body: {
      'user_id': user_id,
    });

    var responseData = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      // var responseData = json.decode(response.body);
      var status = responseData["status"];

      var data = responseData["data"];
      print(data);

      if (status == "Success") {

        return GetCartListModel.fromJson(responseData);
      } else {

        return GetCartListModel.fromJson(responseData);
      }
    } else {
      return GetCartListModel.fromJson(responseData);
    }
  }

  Future<GetCartIncrementPrice> getCartIncrementPrice(String cart_id, quantity) async {

    final response = await http
        .post(Uri.parse("https://civildeal.com/civilmall/api/CartIncrementDecrement"), body: {
      'cart_id': cart_id,
      'quantity': quantity,
    });

    var responseData = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      // var responseData = json.decode(response.body);
      var status = responseData["status"];

      var data = responseData["data"];
      print(data);

      if (status == "Success") {
        getCartLsit(user_id);
        print("Success "+responseData["message"]);
        return GetCartIncrementPrice.fromJson(responseData);
      } else {
        Fluttertoast.showToast(
            msg: "fail " + responseData["message"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        print("fail "+responseData["message"]);
        return GetCartIncrementPrice.fromJson(responseData);
      }
    } else {
      print("failed "+responseData["message"]);
      return GetCartIncrementPrice.fromJson(responseData);
    }
  }

  void RemoveProduct(String cart_id, user_id) async {
    print(cart_id);
    print(user_id);
    try {
      Response response = await post(
          Uri.parse("https://civildeal.com/civilmall/api/RemoveFromCart"),
          body: {'cart_id': cart_id, 'user_id': user_id});

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);

        var status = responseData["status"];


        if (status == "Success") {

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Removed Sucessfully"),
          ));
          // WidgetsBinding.instance?.addPostFrameCallback((_) {
          //   setState(() {
          //     getCartLsit(user_id);
          //   });
          //
          // });


          print(responseData["message"]);

        } else {
          var message = responseData["message"];
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("" + message),
          ));
        }
      } else {
        var responseData = json.decode(response.body);
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(
          msg: "" + e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  void cartCheckout(String user_id, email, amount, razorPayId) async {

      print(user_id);
      print(email);
      print(amount);
      print(razorPayId);
      Response response = await post(
          Uri.parse("https://civildeal.com/civilmall/api/cart_checkout"),
          body: {'user_id': user_id,
            'email': email,
            'amount': amount,
            'transaction_id': razorPayId
          });

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);

        var status = responseData["status"];



        if (status == "Success") {

          Fluttertoast.showToast(
              msg: "Payment done Successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0);
          Navigator.pop(context, false);

        } else {
          var message = responseData["message"];
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("failed " + message),
          ));
        }
      } else {
        var responseData = json.decode(response.body);
      }
  }
  // late String Price;
  // List<GetCartListModel> cartList=[];
  // int? sum = 0;
  //
  // total(List<Data> list) {
  //
  //   for(int i =0;i<list.length;i++){
  //
  //     // String? y =  leadList[0].data![i].query.toString();
  //     setState(() {
  //       int? leadprice =  list![i].leadprice;
  //       sum = (sum! + leadprice!);
  //       print(sum);
  //     });
  //
  //
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCred();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }
  void openCheckout(int price) async {
    var options = {
      'key': 'rzp_test_QLN7Lfgoyl5jjU',
      'amount': price*100,
      'name': 'CivilDeal',
      'description': 'Order Payment',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': mobile, email: 'https://civildeal.com/'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print('Success Response: $response');
    /*Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId!,
        toastLength: Toast.LENGTH_SHORT); */
    print("order_id "+response.orderId.toString());
    cartCheckout(user_id,email,totalCartPrice.toString(),response.paymentId.toString());
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('Error Response: $response');
    /* Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message!,
        toastLength: Toast.LENGTH_SHORT); */
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('External SDK Response: $response');
    /* Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName!,
        toastLength: Toast.LENGTH_SHORT); */
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
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
      bottomNavigationBar: InkWell(
        onTap: (){
          openCheckout(totalCartPrice);
        },
        child: FutureBuilder<GetCartListModel>(
          future: getCartLsit(user_id),
          builder: (context,snapshot){
            if(snapshot.hasData){
              totalCartPrice = int.parse(snapshot.data!.totalCart.toString());
              return Container(
                height: 45,
                color: MyTheme.skyblue,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(snapshot.data?.totalCart.toString()??"",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0,bottom: 8.0),
                        child: Text(
                            "₹ Procees to pay",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  )

                ),
              );
            }else{
              return Text("");
            }
          },

        ),
      ),
      body: Column(
        children: [
          FutureBuilder<GetCartListModel>(
            future: getCartLsit(user_id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                //   leadList = snapshot.data!.data!.cast<CartItemModel>();
                // WidgetsBinding.instance?.addPostFrameCallback((_){
                //
                //   // total(snapshot.data!.data!);
                //
                // });
                // // Future.delayed(Duration.zero, () async {
                // //
                // // });
                // for(int i =0; i<=snapshot.data!.data!.length;i++){
                //   cart_id = snapshot.data!.data![i].cartId.toString();
                // }

                return Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.data!.length,
                      itemBuilder: (context, position) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0),
                          child: Card(
                            elevation: 2,
                            child: Container(
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 30,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5.0,
                                          left: 5.0,
                                          bottom: 5.0),
                                      child: Container(
                                        height: 120,
                                        width: 120,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(10),
                                            image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: NetworkImage(
                                                  "https://civildeal.com/civilmall/public/images/product/" +
                                                      snapshot
                                                          .data!
                                                          .data![position]
                                                          .productImage
                                                          .toString()),
                                            )),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      flex: 70,
                                      child: Container(
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                              const EdgeInsets.all(
                                                  8.0),
                                              child: Text(
                                                snapshot
                                                    .data!
                                                    .data![position]
                                                    .productName
                                                    .toString()
                                                    .trim(),
                                                textAlign:
                                                TextAlign.start,
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.black,
                                                    fontWeight:
                                                    FontWeight.bold),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                              const EdgeInsets.all(
                                                  8.0),
                                              child: Text(
                                                "₹ " +
                                                    snapshot
                                                        .data!
                                                        .data![position]
                                                        .totalPrice
                                                        .toString()
                                                        .trim(),
                                                textAlign:
                                                TextAlign.start,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Container(
                                                      height: 37,
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(5),
                                                          color: MyTheme.skyblue
                                                      ),
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(
                                                            left: 4.0, right: 4.0),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment
                                                              .spaceBetween,
                                                          children: [
                                                            InkWell(
                                                              onTap: () {
                                                                // updateQunty();
                                                                setState(() {
                                                                  // quatity = snapshot.data!
                                                                  //     .data!.minOrderLimit!;
                                                                  int quantity = snapshot.data!.data![position].quantity??0;
                                                                  quantity--;
                                                                  getCartIncrementPrice(snapshot.data!.data![position].cartId.toString(),
                                                                      quantity.toString());
                                                                  // new_quantity = (snapshot.data!.data![position].quantity!+quantity);
                                                                  // print(new_quantity);
                                                                  // if(quantity>snapshot.data!.data![position].quantity!.toInt()){
                                                                  //   quantity--;
                                                                  // }else{
                                                                  //   print("quantity "+quantity.toString());
                                                                  // }


                                                                });
                                                              },
                                                              child: Icon(
                                                                Icons.remove, color: Colors.white,
                                                              ),
                                                            ),
                                                            Text(snapshot.data!.data![position].quantity.toString(),
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                color: Colors.white,
                                                              ),),
                                                            InkWell(
                                                              onTap: () {
                                                                try{
                                                                  setState(() {
                                                                    int quantity = snapshot.data!.data![position].quantity??0;
                                                                    quantity++;
                                                                    getCartIncrementPrice(snapshot.data!.data![position].cartId.toString(),
                                                                        quantity.toString());
                                                                    // new_quantity = (snapshot.data!.data![position].quantity!+quantity);
                                                                    // print(new_quantity);
                                                                    // print("quantity "+new_quantity.toString());
                                                                  });
                                                                }catch(e){
                                                                  print("ecx "+e.toString());
                                                                }

                                                              },
                                                              child: Icon(
                                                                Icons.add, color: Colors.white,),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(right: 5.0,top: 8.0,bottom: 8.0),
                                                    child: ElevatedButton.icon(
                                                      icon: Icon(Icons.delete,
                                                          size: 16),
                                                      label: Text('Remove'),
                                                      onPressed: () => {
                                                        setState(() {
                                                          RemoveProduct(
                                                              snapshot
                                                                  .data!
                                                                  .data![
                                                              position]
                                                                  .cartId
                                                                  .toString(),
                                                              user_id);
                                                          getCartLsit(user_id);
                                                        })
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                          ],
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    Visibility(
                      visible: snapshot.data!.data!.length==0 ? false : true,
                      child: Card(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  "Bag Total",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                              ),
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                        flex: 50,
                                        child: Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: [
                                                Text("Total price"),
                                                Text("Shipping")
                                              ],
                                            ),
                                          ),
                                        )),
                                    Expanded(
                                        flex: 50,
                                        child: Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: [Text(snapshot.data?.totalCart.toString()??""), Text("0")],
                                            ),
                                          ),
                                        )),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Center(child: Text("No Data Found"));
              } else {
                return Container(
                  child: Center(child: Lottie.asset('assets/images/cart_loader.json'),),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}


