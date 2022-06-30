import 'dart:convert';

import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import 'package:civildeal_user_app/Model/GetBannerImagesModel.dart';
import 'package:civildeal_user_app/Model/GetCartListModel.dart';
import 'package:civildeal_user_app/Model/GetProductCategoryModel.dart';
import 'package:civildeal_user_app/Screens/sub_category.dart';
import 'package:civildeal_user_app/Utils/routs.dart';
import 'package:civildeal_user_app/Widget/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import '../Services/Utilities/app_url.dart';


class CivilMallPage extends StatefulWidget {
  const CivilMallPage({Key? key}) : super(key: key);

  @override
  State<CivilMallPage> createState() => _CivilMallPageState();
}

class _CivilMallPageState extends State<CivilMallPage> {

  final List<String> images = [
    'https://media.istockphoto.com/photos/delivering-quality-construction-for-a-quality-lifestyle-picture-id1297780288?b=1&k=20&m=1297780288&s=170667a&w=0&h=NDdDs9BBGULLwYUDUt1AjIOroHuwmFY9N6ZEDAYV7sE=',
    'https://www.build-review.com/wp-content/uploads/2019/12/construction-2.jpg',
    'https://thumbs.dreamstime.com/b/construction-blueprint-5200849.jpg'
  ];
  late String user_id;
  void getCred() async{

    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {

      user_id = pref.getString("id")!;

      getCartList(user_id);


    });

  }
  List bannerImages = [];

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

  Future<GetProductCategoryModel> getproductCategory () async{
    final response = await http.get(Uri.parse(AppUrl.getallproductcategoryApi));
    var data = jsonDecode(response.body.toString());
    var status= data["status"];
    if(response.statusCode==200){
      if(status == 'Success'){
        return GetProductCategoryModel.fromJson(data);
      }
      else{
        return GetProductCategoryModel.fromJson(data);
      }

    }
    else{
      return GetProductCategoryModel.fromJson(data);
    }
  }
  Future<GetBannerImagesModel> getbannerImages () async{
    final response = await http.get(Uri.parse(AppUrl.getBannerImagesApi));
    var data = jsonDecode(response.body.toString());
    var status= data["status"];
    // bannerImages = data['data'];
    // print(bannerImages);
    if(response.statusCode==200){
      if(status == 'Success'){
        return GetBannerImagesModel.fromJson(data);
      }
      else{
        return GetBannerImagesModel.fromJson(data);
      }

    }
    else{
      return GetBannerImagesModel.fromJson(data);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getbannerImages();
    getCred();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Civil Mall"),
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
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              FutureBuilder<GetBannerImagesModel>(
                future: getbannerImages(),
                  builder: (context,snapshot){
                  if(snapshot.hasData){
                    bannerImages = snapshot.data!.data!;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),

                        ),
                        child: SizedBox(
                          height: 150,
                          width: double.infinity,
                          child: Carousel(
                            animationDuration: Duration(seconds: 1),
                            dotSpacing: 15,
                            dotSize: 6.0,
                            dotIncreasedColor: Colors.red,
                            dotBgColor: Colors.transparent,
                            indicatorBgPadding: 10.0,
                            images: bannerImages.map((item)=>Container(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30.0),
                                child: Container(
                                  height: MediaQuery.of(context).size.height / 5,
                                  width: MediaQuery.of(context).size.width / 1.2,
                                  child: Image.network(item,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            )).toList(),
                          ),
                        ),
                      ),
                    );
                  }else{
                    return Text("loading...");
                  }
                  }),

              SizedBox(height: 20,),
              Container(
                color: MyTheme.bglayout,
                child: Column(
                  children: [
                    Text("Category",
                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                    SizedBox(height: 20,),
                    FutureBuilder<GetProductCategoryModel>(
                      future: getproductCategory(),
                      builder: (context , snapshot){
                        if(snapshot.hasData){
                          return GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
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
                                          builder: (context) => SubCategoryPage(id: snapshot.data!.data![position].categoryId!.toString(),sub_name: snapshot.data!.data![position].name.toString()),
                                        )).then((_) {
                                      // This block runs when you have returned back from screen 2.
                                      setState(() {
                                        // code here to refresh data
                                        getCartList(user_id);
                                      });
                                    });;
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 2.0),
                                    child: Card(
                                      elevation: 5,
                                      child: Container(
                                        color: MyTheme.lightskyblue,
                                        height: MediaQuery.of(context).size.height *.25,
                                        width: MediaQuery.of(context).size.width *.26,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(top: 0.0),
                                              child: Container(
                                                  height:130,
                                                  // decoration: BoxDecoration(
                                                  //     borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
                                                  //     image: DecorationImage(
                                                  //       fit: BoxFit.fill,
                                                  //       image: NetworkImage("https://civildeal.com/civilmall/public/images/category/" +snapshot.data!.data![position].image!.toString()),
                                                  //     )
                                                  // ),
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5),bottomRight: Radius.circular(5)),
                                                    child: FadeInImage.assetNetwork(
                                                      placeholder: 'assets/images/no_photo.png',
                                                      image: 'https://civildeal.com/civilmall/public/images/category/'+snapshot.data!.data![position].image.toString(),
                                                      imageErrorBuilder: (c, o, s) => Image.asset('assets/images/no_photo.png', fit: BoxFit.cover),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  )
                                              ),
                                            ),
                                            Center(child: Padding(
                                              padding: const EdgeInsets.only(top: 10.0,left: 5.0,right: 5.0,bottom: 2.0),
                                              child: Text(
                                                snapshot.data!.data![position].name!.toString(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 12
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
                            child: Center(child: Lottie.asset('assets/images/loader.json'),),
                          );
                        }
                      },
                    ),
                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
