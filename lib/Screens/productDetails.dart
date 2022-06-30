import 'dart:convert';

import 'package:civildeal_user_app/Model/ProductDetailsRelatedCategory.dart';
import 'package:civildeal_user_app/Utils/routs.dart';
import 'package:civildeal_user_app/Widget/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:number_inc_dec/number_inc_dec.dart';
import '../Model/GetCartListModel.dart';


class ProductDetailsPage extends StatefulWidget {
  String id,product_name;
  int min_quantity;
  ProductDetailsPage({Key? key, required this.id,required this.product_name,required this.min_quantity}) : super(key: key);

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState(id,product_name,min_quantity);
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  String id, product_name;
  int min_quantity;
  _ProductDetailsPageState(this.id, this.product_name,this.min_quantity);

  late String user_id;
  late int quantity=min_quantity;


  void getCred() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      user_id = pref.getString("id")!;
      getCartList(user_id);

      print(user_id);
    });
  }

  updateQunty() async {
  }

  int? cartsize;

  // cartList(List<Data> list){
  //   setState(() {
  //     cartsize = list.length;
  //   });
  //
  //   print(cartsize);
  // }

  Future<GetCartListModel> getCartList(String user_id) async {
    final response = await http
        .post(
        Uri.parse("https://civildeal.com/civilmall/api/getcartinuser"), body: {
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

  void AddtoCart(String product_id, user_id) async {
    print(product_id);
    print(user_id);
    try {
      Response response = await post(
          Uri.parse("https://civildeal.com/civilmall/api/addproductincart"),
          body: {
            'product_id': product_id,
            'user_id': user_id,
          }
      );

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);


        var status = responseData["status"];

        if (status == "Success") {

          print("Succesfully added in cart" + response.body);
          getCartList(user_id);
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            setState(() {
              getproductsListCategory(id);
            });

          });

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Succesfully added in cart"),
          ));
        }
        else {
          print("failedcart " + response.body);
          var message = responseData["message"];
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("" + message),
          ));
        }
      }
      else {
        print("failed2" + response.body);
      }
    } catch (e) {
      print("exce " + e.toString());
    }
  }

  Future<ProductDetailsRelatedCategory> getproductsListCategory(String id) async {
    print(id);
    final response = await http.post(
        Uri.parse("https://civildeal.com/civilmall/api/getproductdetail"),
        body: {
          'product_id': id,
          'user_id':user_id
        }
    );
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      var status = data["status"];

      if (status == 'Success') {
        print("success "+response.body);
        return ProductDetailsRelatedCategory.fromJson(data);
      } else {
        print("fail "+response.body);
        return ProductDetailsRelatedCategory.fromJson(data);
      }
    }
    else {
      return ProductDetailsRelatedCategory.fromJson(data);
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
    return WillPopScope(
      onWillPop: () async {
        // You can do some work here.
        // Returning true allows the pop to happen, returning false prevents it.
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(product_name),
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
          actions: [
            FutureBuilder<GetCartListModel>(
              future: getCartList(user_id),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // WidgetsBinding.instance?.addPostFrameCallback((_) {
                  //   // cartList(snapshot.data!.data!);
                  //
                  // });
                  cartsize = snapshot.data!.data!.length;
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: 35.0,
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () {
                          // Todo:navigate to cart screen
                          // if (kDebugMode) {
                          //   print("tapped on cart icon");
                          // }
                          Navigator.pushNamed(context, MyRoutes.cartRoute).then((_) {
                            // This block runs when you have returned back from screen 2.
                            setState(() {
                              // code here to refresh data
                              getCartList(user_id);
                              getproductsListCategory(id);
                            });
                          });
                        },
                        child: Stack(
                          children: <Widget>[
                            const IconButton(
                              icon: Icon(
                                Icons.shopping_cart_sharp,
                                color: Colors.white,
                              ),
                              onPressed: null,
                            ),
                            1 == 0
                                ? Container()
                                : Positioned(
                              top: 0,
                              right: 0,
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    height: 20.0,
                                    width: 20.0,
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        cartsize?.toString()??"",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 11.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },

            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                FutureBuilder<ProductDetailsRelatedCategory>(
                  future: getproductsListCategory(id),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Card(
                              child: Container(
                                height: 250,
                                width: double.infinity,
                                child: FadeInImage.assetNetwork(
                                  placeholder: 'assets/images/man.png',
                                  image: "https://civildeal.com/civilmall/public/images/product/" +
                                      snapshot.data!.data!.image.toString(),
                                  imageErrorBuilder: (c, o, s) =>
                                      Image.asset(
                                          'assets/images/man.png',
                                          fit: BoxFit.cover),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, top: 5.0),
                              child: Text(snapshot.data!.data!.name.toString(),
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold
                                ),),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, top: 5.0),
                                    child: Text("₹ " +
                                        snapshot.data!.data!.sellingPrice
                                            .toString(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500
                                      ),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 15.0),
                                    child: Text(
                                      snapshot.data!.data!.stockStatus.toString(),
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.deepPurpleAccent,
                                      ),),
                                  ),
                                ],
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text("₹ " +
                                  snapshot.data!.data!.mrpPrice.toString(),
                                  style: TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      color: Colors.red
                                  )),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, top: 5.0),
                                    child: Text("by : ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500
                                      ),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, top: 5.0),
                                    child: Text(snapshot.data!.data?.productBy
                                        .toString() ?? "",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500
                                      ),),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20.0, top: 10.0),
                                    child: Visibility(
                                      visible:false,
                                      child: Container(
                                        height: 40,
                                        width: 120,
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
                                                    if(quantity>min_quantity){
                                                      quantity--;
                                                    }else{
                                                      print("quantity "+quantity.toString());
                                                    }


                                                  });
                                                },
                                                child: Icon(
                                                  Icons.remove, color: Colors.white,
                                                ),
                                              ),
                                              Text(quantity.toString(),
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                ),),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    // quatity = snapshot.data!
                                                    //     .data!.minOrderLimit!;
                                                    quantity++;
                                                    print("quantity "+quantity.toString());
                                                  });
                                                },
                                                child: Icon(
                                                  Icons.add, color: Colors.white,),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: snapshot.data!.data!.isAdded.toString()=="0" ? true : false,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0, right: 20.0),
                                      child: InkWell(
                                        onTap: () {
                                          AddtoCart(
                                              snapshot.data!.data!.productId
                                                  .toString(), user_id);
                                        },
                                        child: Container(
                                          height: 40,
                                          width: 120,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(
                                                  5),
                                              color: MyTheme.skyblue
                                          ),
                                          child: Center(child: Text(
                                            "Add To Cart", style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                          ),)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible:snapshot.data!.data!.isAdded.toString()=="1" ? true : false,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0, right: 20.0),
                                      child: Container(
                                        height: 40,
                                        width: 120,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                5),
                                            color: MyTheme.orange
                                        ),
                                        child: Center(child: Text(
                                          "Added", style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),)),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 20.0,),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Text("Product Description", style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold
                              ),),
                            ),
                            SizedBox(height: 5.0,),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15.0),
                              child: Container(
                                height: 0.5,
                                color: Colors.black26,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5.0, bottom: 5.0),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 40,
                                        color: MyTheme.creamColor,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Expanded(
                                              flex: 40,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 2.0),
                                                child: Text("Size",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 60,
                                              child: Text(
                                                snapshot.data!.data!.size!
                                                    .toString().trim(),
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 40,
                                        color: Colors.white,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Expanded(
                                              flex: 40,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 2.0),
                                                child: Text("Material",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 60,
                                              child: Text(
                                                snapshot.data!.data!.material!
                                                    .toString().trim(),
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 40,
                                        color: MyTheme.creamColor,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Expanded(
                                              flex: 40,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 2.0),
                                                child: Text("Colors",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 60,
                                              child: Text(
                                                snapshot.data!.data!.colour!
                                                    .toString().trim(),
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(left: 10.0,
                                  right: 10.0,
                                  top: 5.0,
                                  bottom: 20.0),
                              child: Text(
                                snapshot.data!.data!.description
                                    .toString(),
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500
                                ),),
                            ),
                          ],
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text("No Data Found"));
                    } else {
                      return Container(
                        child: Center(child: Lottie.asset('assets/images/loader.json')),
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


