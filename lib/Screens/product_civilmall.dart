import 'dart:convert';

import 'package:civildeal_user_app/Model/GetCartListModel.dart';
import 'package:civildeal_user_app/Model/GetCategoryRelatedProductModel.dart';
import 'package:civildeal_user_app/Model/GetCityModel.dart';
import 'package:civildeal_user_app/Screens/productDetails.dart';
import 'package:civildeal_user_app/Services/Utilities/app_url.dart';
import 'package:civildeal_user_app/Utils/routs.dart';
import 'package:civildeal_user_app/Widget/theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:touchable_opacity/touchable_opacity.dart';


class ProductCategoryPage extends StatefulWidget {
  String id,product_name;
  ProductCategoryPage({Key? key, required this.id,required this.product_name}) : super(key: key);

  @override
  State<ProductCategoryPage> createState() => _ProductCategoryPageState(id,product_name);
}

class _ProductCategoryPageState extends State<ProductCategoryPage> {
  String id,product_name;
  _ProductCategoryPageState(this.id,this.product_name);

  late String user_id;
  List cityList = [];
  String ?_selectedCity,city_id;

  void getCred() async{

    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      city_id = pref.getString("location_id")!;
      user_id = pref.getString("id")!;
      _selectedCity = city_id;
      getCartList(user_id);
      print(_selectedCity.toString());

    });

  }

  Future<GetCityModel> getCityList () async{
    final response = await http.get(Uri.parse(AppUrl.getCityApi));
    var data = jsonDecode(response.body.toString());
    var code= data["code"];
    setState(() {
      cityList = data['data'];
    });

    print(cityList);
    if(response.statusCode==200){
      if(code == 200){
        return GetCityModel.fromJson(data);

      }
      else{
        return GetCityModel.fromJson(data);

      }
    }
    else{
      return GetCityModel.fromJson(data);
    }
  }

  Future<GetCategoryRelatedProductModel> getproductsListCategory (String id,city) async{
    print("cati_id "+id);
    print("city "+city);
    final response = await http.post(Uri.parse("https://civildeal.com/civilmall/api/getproduct"),
        body: {
          'sub_category_id':id,
          'location_id':city,
        }
    );
    var data = jsonDecode(response.body.toString());

    if(response.statusCode==200){
      var status= data["status"];

      if(status=='status'){
        var data1= data["data"];
        print(data1);
        return GetCategoryRelatedProductModel.fromJson(data);
      }else{

        return GetCategoryRelatedProductModel.fromJson(data);
      }
    }
    else
    {
      return GetCategoryRelatedProductModel.fromJson(data);
    }

  }
  int? cartsize;

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


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCityList();
    getCred();

  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // You can do some work here.
        // Returning true allows the pop to happen, returning false prevents it.
        Navigator.pop(context);
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
        body: Container(
          color: MyTheme.bg3layout,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      border: Border.all(
                          color: Colors.black45, style: BorderStyle.solid, width: 0.80),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Expanded(
                          flex: 20,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Container(
                              height: 40,
                              width: 100,

                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.0),

                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  value: _selectedCity??city_id,
                                  onChanged: (newCity){
                                    setState(() {
                                      _selectedCity = "$newCity";
                                      print("city "+_selectedCity.toString());
                                    });
                                  },
                                  items: cityList.map((item) {
                                    return DropdownMenuItem(
                                      child: Text(item['name'.toLowerCase()],style: TextStyle(fontSize: 13)),
                                      // child: Flexible(
                                      //   child: RichText(
                                      //     overflow: TextOverflow.ellipsis,
                                      //     // strutStyle: StrutStyle(fontSize: 12.0),
                                      //     text: TextSpan(
                                      //         style: TextStyle(color: Colors.black,fontSize: 12),
                                      //         text:item['name'.toLowerCase()] ),
                                      //   ),
                                      // ),
                                      value: item['id'].toString(),
                                    );
                                  }).toList(),
                                  hint: Text("Select City",style: TextStyle(fontSize: 13),),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: FutureBuilder<GetCategoryRelatedProductModel>(
                    future: getproductsListCategory(id,_selectedCity),
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
                                  child: TouchableOpacity(
                                    activeOpacity: 0.2,
                                    child: InkWell(
                                      onTap: (){
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ProductDetailsPage(id: snapshot.data!.data![position].productId!.toString(),
                                                  product_name: snapshot.data!.data![position].name.toString(),
                                                  min_quantity:snapshot.data!.data![position].minOrderLimit??0),
                                            )).then((_) {
                                          // This block runs when you have returned back from screen 2.
                                          setState(() {
                                            // code here to refresh data
                                            getCartList(user_id);
                                          });
                                        });
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
                                                                image: NetworkImage("https://civildeal.com/civilmall/public/images/product/" +snapshot.data!.data![position].image!.toString()),
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
                                                padding: const EdgeInsets.only(left: 15.0,right: 5.0,bottom: 3.0),
                                                child: Container(
                                                  height: 120,
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(snapshot.data!.data![position].name.toString().trim(),
                                                        textAlign: TextAlign.start,
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.bold
                                                        ),),
                                                      Text(snapshot.data!.data![position].description.toString(),
                                                        textAlign: TextAlign.start,
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.grey,
                                                        ),),
                                                      Text(snapshot.data!.data![position].mrpPrice.toString()+" ₹",
                                                        textAlign: TextAlign.start,
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                        ),),
                                                      // Text(snapshot.data!.data![position].locationId.toString(),
                                                      //   textAlign: TextAlign.start,
                                                      //   style: TextStyle(
                                                      //     fontSize: 12,
                                                      //     color: Colors.blue,
                                                      //   ),),
                                                      RichText(
                                                        text: TextSpan(
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.blue,
                                                          ),
                                                          children: [
                                                            WidgetSpan(
                                                              child: Padding(
                                                                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                                                child: Icon(Icons.place,size: 14,),
                                                              ),
                                                            ),
                                                            TextSpan(text: snapshot.data!.data![position].locationId.toString()),
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
                                  ),
                                ),
                              );
                            });
                      }else if(snapshot.hasError){
                        return Center(child: Text("No Post Found"));
                      }else{
                        return Container(
                          child: Center(child: Lottie.asset('assets/images/loader.json'),),
                        );
                      }
                    },
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }
}
