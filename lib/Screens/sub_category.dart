import 'dart:convert';

import 'package:civildeal_user_app/Model/GetCartListModel.dart';
import 'package:civildeal_user_app/Model/GetProductSubCategoryModel.dart';
import 'package:civildeal_user_app/Screens/product_civilmall.dart';
import 'package:civildeal_user_app/Utils/routs.dart';
import 'package:civildeal_user_app/Widget/theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:touchable_opacity/touchable_opacity.dart';



class SubCategoryPage extends StatefulWidget {
  String id,sub_name;
  SubCategoryPage({Key? key, required this.id,required this.sub_name}) : super(key: key);

  @override
  State<SubCategoryPage> createState() => _SubCategoryPageState(id,sub_name);
}

class _SubCategoryPageState extends State<SubCategoryPage> {
  String id,sub_name;
  _SubCategoryPageState(this.id,this.sub_name);

  late String user_id;
  void getCred() async{

    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {

      user_id = pref.getString("id")!;

      getCartList(user_id);


    });

  }

  Future<GetProductSubCategoryModel> getproductsubCategory (String id) async{
    final response = await http.post(Uri.parse("https://civildeal.com/civilmall/api/getsubcategory"),
        body: {
          'category_id':id,
        }
    );
    var data = jsonDecode(response.body.toString());

    if(response.statusCode==200){
      var status= data["status"];

      if(status=='status'){
        return GetProductSubCategoryModel.fromJson(data);
      }else{

        return GetProductSubCategoryModel.fromJson(data);
      }
    }
    else
    {
      return GetProductSubCategoryModel.fromJson(data);
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
    getCred();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(sub_name),
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
        color: MyTheme.bg4layout,
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<GetProductSubCategoryModel>(
                future: getproductsubCategory(id),
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    return GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
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
                                  builder: (context) => ProductCategoryPage(id: snapshot.data!.data![position].categoryId!.toString(),product_name: snapshot.data!.data![position].name.toString()),
                                ));
                          },
                          child: Card(
                            elevation: 5,
                            child: TouchableOpacity(
                              activeOpacity: 0.2,
                              child: InkWell(
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProductCategoryPage(id: snapshot.data!.data![position].subCategoryId!.toString(),product_name: snapshot.data!.data![position].name.toString()),
                                      ));
                                },
                                child: Container(
                                  height: MediaQuery.of(context).size.height *.25,
                                  width: MediaQuery.of(context).size.width *.26,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 0.0),
                                        child: InkWell(
                                          splashColor: const Color(0x8034b0fc),
                                          onTap: (){
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => ProductCategoryPage(id: snapshot.data!.data![position].subCategoryId!.toString(),product_name: snapshot.data!.data![position].name.toString()),
                                                )).then((_) {
                                              // This block runs when you have returned back from screen 2.
                                              setState(() {
                                                // code here to refresh data
                                                getCartList(user_id);
                                              });
                                            });;
                                          },
                                          child: Container(
                                            height:120,
                                            width: MediaQuery.of(context).size.height *.25,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: NetworkImage("https://civildeal.com/civilmall/public/images/sub-category/" +snapshot.data!.data![position].image!.toString()),
                                                )
                                            ),
                                          ),
                                        ),
                                      ),
                                      Center(child: Padding(
                                        padding: const EdgeInsets.only(top: 10.0,left: 5.0,right: 5.0,bottom: 2.0),
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
                          ),
                        );
                      },
                    );
                  }else if(snapshot.hasError){
                    return Center(child: Text("No Data Found"));
                  }else{
                    return Container(
                      child: Center(
                          child: Lottie.asset('assets/images/loader.json'),
                      ),
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
