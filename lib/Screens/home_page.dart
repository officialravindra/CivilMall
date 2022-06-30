import 'dart:convert';

import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import 'package:civildeal_user_app/Model/GetCartListModel.dart';
import 'package:civildeal_user_app/Model/GetLatestProductModel.dart';
import 'package:civildeal_user_app/Model/GetProductCategoryModel.dart';
import 'package:civildeal_user_app/Screens/maintenanceVendors.dart';
import 'package:civildeal_user_app/Screens/productDetails.dart';
import 'package:civildeal_user_app/Screens/productVendors.dart';
import 'package:civildeal_user_app/Screens/searchVendors.dart';
import 'package:civildeal_user_app/Screens/seeAllMaintenance.dart';
import 'package:civildeal_user_app/Screens/seeAllProduct.dart';
import 'package:civildeal_user_app/Screens/seeAllService.dart';
import 'package:civildeal_user_app/Screens/serviceVendors.dart';
import 'package:civildeal_user_app/Screens/sub_category.dart';
import 'package:civildeal_user_app/Services/Utilities/app_url.dart';
import 'package:civildeal_user_app/Utils/routs.dart';
import 'package:civildeal_user_app/Widget/drawer.dart';
import 'package:civildeal_user_app/Widget/theme.dart';
import 'package:civildeal_user_app/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import '../Model/GetBannerImagesModel.dart';
import '../Model/GetCityModel.dart';
import '../Model/MaintenanceModel.dart';
import '../Model/ProductModel.dart';
import '../Model/ServiceModel.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? city,city_id,city_ID;
  String ?_selectedCity;
  late String user_id;
  void getCred() async{

    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      // city = pref.getString("locationName")!;
      city_id = pref.getString("location_id")!;
      user_id = pref.getString("id")!;
      _selectedCity = city_id;
      getCartList(user_id);
      print(_selectedCity.toString());
      print("city "+city_id!);
    });

  }
  List bannerImages = [];
  List cityList = [];
  final List<String> images = [
    'https://media.istockphoto.com/photos/delivering-quality-construction-for-a-quality-lifestyle-picture-id1297780288?b=1&k=20&m=1297780288&s=170667a&w=0&h=NDdDs9BBGULLwYUDUt1AjIOroHuwmFY9N6ZEDAYV7sE=',
    'https://www.build-review.com/wp-content/uploads/2019/12/construction-2.jpg',
    'https://thumbs.dreamstime.com/b/construction-blueprint-5200849.jpg'
  ];


  String ?_selectedType;
  var type = {'service':'1','product':'2','maintenance':'3'};
  List _types = [];
  TypeDependentDropDown(){
    type.forEach((key, value) {
      _types.add(key);
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

  Future<GetLatestProductModel> getLatestProduct () async{
    final response = await http.get(Uri.parse(AppUrl.latestProductApi));
    var data = jsonDecode(response.body.toString());
    var status= data["status"];
    if(response.statusCode==200){
      if(status == "Success"){
        return GetLatestProductModel.fromJson(data);
      }
      else{
        return GetLatestProductModel.fromJson(data);
      }
      return GetLatestProductModel.fromJson(data);
    }
    else{
      return GetLatestProductModel.fromJson(data);
    }
  }

  Future<ServiceModel> getService () async{
    final response = await http.get(Uri.parse(AppUrl.servicerApi));
    var data = jsonDecode(response.body.toString());
    var code= data["code"];
    if(response.statusCode==200){
      if(code == 200){
        return ServiceModel.fromJson(data);
      }
      else{
        return ServiceModel.fromJson(data);
      }
      return ServiceModel.fromJson(data);
    }
    else{
      return ServiceModel.fromJson(data);
    }
  }

  Future<ProductModel> getProduct () async{
    final response = await http.get(Uri.parse(AppUrl.productApi));
    var data = jsonDecode(response.body.toString());
    var code= data["code"];
    if(response.statusCode==200){
      if(code == 200){
        return ProductModel.fromJson(data);
      }
      else{
        return ProductModel.fromJson(data);
      }

    }
    else{
      return ProductModel.fromJson(data);
    }
  }

  Future<MaintenanceModel> getMaintenance () async{
    final response = await http.get(Uri.parse(AppUrl.maintenanceApi));
    var data = jsonDecode(response.body.toString());
    var code= data["code"];
    if(response.statusCode==200){
      if(code == 200){
        return MaintenanceModel.fromJson(data);
      }
      else{
        return MaintenanceModel.fromJson(data);
      }

    }
    else{
      return MaintenanceModel.fromJson(data);
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
    TypeDependentDropDown();
    getCityList();
    getbannerImages();
    getCred();
    setState(() {

    });
    _selectedType = "service";
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                // channel.description,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title??''),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body??"")],
                  ),
                ),
              );
            });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('CivilDeal'),
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
          color: MyTheme.smokeyWhite,
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                      // borderRadius: BorderRadius.only(
                      //   bottomLeft: Radius.circular(50.0),
                      //   bottomRight: Radius.circular(50.0)
                      // ),
                        gradient: LinearGradient(
                            colors: [MyTheme.darkblue, MyTheme.lightskyblue],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter
                        )
                    ),
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

                                Container(
                                  width: 0.5,
                                  height: 40,
                                  color: Colors.black,
                                ),

                                  Expanded(
                                    flex: 15,
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
                                            value: _selectedType,
                                            onChanged: (newValue){
                                              setState(() {
                                                // _category =[];
                                                // CategoryDependentDropDown(type[newValue]);
                                                _selectedType = "$newValue";
                                              });

                                            },
                                            items: _types.map((type){
                                              return DropdownMenuItem(
                                                child: Text(type,style: TextStyle(fontSize: 13)),
                                                // child: Flexible(
                                                //   child: RichText(
                                                //     overflow: TextOverflow.ellipsis,
                                                //     // strutStyle: StrutStyle(fontSize: 12.0),
                                                //     text: TextSpan(
                                                //         style: TextStyle(color: Colors.black,fontSize: 12),
                                                //         text:type ),
                                                //   ),
                                                // ),
                                                value: type,
                                              );
                                            }).toList(),
                                            hint: Text("Select Type",
                                              style: TextStyle(
                                                  fontSize: 13
                                              ),),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                Container(
                                  width: 0.5,
                                  height: 40,
                                  color: Colors.black,
                                ),
                                Expanded(
                                  flex: 5,
                                  child: IconButton(icon: Icon(Icons.search), onPressed: (){
                                    // showSearch(context: context, delegate: DataSearch(cityList));
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => VendorsSearch(city_id: _selectedCity.toString(),vendor_type: _selectedType.toString()),
                                        ));
                                  },),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 5,),
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
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Container(
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(30),
                        //
                        //     ),
                        //     child: SizedBox(
                        //       height: 150,
                        //       width: double.infinity,
                        //       child: Carousel(
                        //         animationDuration: Duration(seconds: 1),
                        //         dotSpacing: 15,
                        //         dotSize: 6.0,
                        //         dotIncreasedColor: Colors.red,
                        //         dotBgColor: Colors.transparent,
                        //         indicatorBgPadding: 10.0,
                        //         images: images.map((item)=>Container(
                        //           decoration: BoxDecoration(
                        //             borderRadius: BorderRadius.circular(30),
                        //
                        //           ),
                        //           child: ClipRRect(
                        //             borderRadius: BorderRadius.circular(30.0),
                        //             child: Container(
                        //               decoration: BoxDecoration(
                        //                 borderRadius: BorderRadius.circular(30),
                        //
                        //               ),
                        //               height: MediaQuery.of(context).size.height / 5,
                        //               width: MediaQuery.of(context).size.width / 1.2,
                        //               child: Image.network(item,
                        //                 fit: BoxFit.cover,
                        //               ),
                        //             ),
                        //           ),
                        //         )).toList(),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(left: 25.0),
                          child: Text("CIVIL MALL",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                            ),),
                        ),
                      ],
                    ),

                  ),

                  // SizedBox(height: 230,),
                  Padding(
                    padding: const EdgeInsets.only(top: 270.0),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          color: MyTheme.bglayout,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 25.0),
                                  child: Text("CATEGORY",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold
                                    ),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0,right: 25.0),
                                  child: Container(
                                    height: 35,
                                    width: 65,
                                    child: Card(
                                      elevation: 2.0,
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: InkWell(
                                            onTap: (){
                                              Navigator.pushNamed(context, MyRoutes.civilmallRoute).then((_) {
                                                // This block runs when you have returned back from screen 2.
                                                setState(() {
                                                  // code here to refresh data
                                                  getCartList(user_id);
                                                });
                                              });
                                            },
                                            child: Text("See All",
                                              style: TextStyle(
                                                  color: Colors.blueAccent,
                                                  fontSize: 12
                                              ),),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 10,),
                            Container(
                              height: 150,
                              child: FutureBuilder<GetProductCategoryModel>(
                                future: getproductCategory(),
                                builder: (context,snapshot){
                                  if(snapshot.hasData){
                                    return ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: snapshot.data!.data!.length,
                                        itemBuilder: (context,position){
                                          return Padding(
                                            padding: const EdgeInsets.only(left: 8.0),
                                            child: TouchableOpacity(
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
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(5),
                                                      border: Border.all(
                                                          color: Colors.black45, style: BorderStyle.solid, width: 0.80),
                                                      color: Colors.white
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        height: MediaQuery.of(context).size.height *.18,
                                                        width: MediaQuery.of(context).size.width *.28,
                                                        child: Column(
                                                          children: [
                                                            Expanded(
                                                              child: Container(
                                                                height:100,
                                                                width: 130,
                                                                decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(5),
                                                                    image: DecorationImage(
                                                                      fit:BoxFit.fill,
                                                                      image: NetworkImage("https://civildeal.com/civilmall/public/images/category/" +snapshot.data!.data![position].image!.toString()),
                                                                    )
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.all(2.0),
                                                              child: Text(snapshot.data!.data![position].name!.toString(),
                                                                textAlign: TextAlign.center,
                                                                style: TextStyle(
                                                                    fontSize: 13
                                                                ),),
                                                            ),

                                                          ],
                                                        ),

                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        });
                                  }else{
                                    return Container(
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                            SizedBox(height: 15,),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Container(
                color: MyTheme.bg2layout,
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0),
                      child: Text("TOP PRODUCT",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold
                        ),),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: 180,
                      child: FutureBuilder<GetLatestProductModel>(
                        future: getLatestProduct(),
                        builder: (context,snapshot){
                          if(snapshot.hasData){
                            return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data!.data!.length,
                                itemBuilder: (context,position){
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
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
                                          });;
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              border: Border.all(
                                                  color: Colors.black45, style: BorderStyle.solid, width: 0.80),
                                              color: Colors.white
                                          ),
                                          child: Column(
                                            children: [
                                              Container(
                                                height: MediaQuery.of(context).size.height *.22,
                                                width: MediaQuery.of(context).size.width *.30,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        height:100,
                                                        width: 150,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(5),
                                                            image: DecorationImage(
                                                              fit:BoxFit.fill,
                                                              image: NetworkImage("https://civildeal.com/civilmall/public/images/product/" +snapshot.data!.data![position].image!.toString()),
                                                            )
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(2.0),
                                                      child: Text(snapshot.data!.data![position].name!.toString(),
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 13
                                                        ),),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.all(2.0),
                                                          child: Text("₹ " +snapshot.data!.data![position].sellingPrice!.toString(),
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                              fontSize: 13,
                                                            ),),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 5.0,top: 2.0),
                                                          child: Text("₹ " +snapshot.data!.data![position].mrpPrice!.toString(),
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                                fontSize: 13,
                                                              decoration: TextDecoration.lineThrough,
                                                              color: Colors.red
                                                            ),),
                                                        )
                                                      ],
                                                    )

                                                  ],
                                                ),

                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          }else{
                            return Container(
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 10,),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Container(
                color: MyTheme.bg3layout,
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0),
                      child: Text("LATEST PRODUCT",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold
                        ),),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: 180,
                      child: FutureBuilder<GetLatestProductModel>(
                        future: getLatestProduct(),
                        builder: (context,snapshot){
                          if(snapshot.hasData){
                            return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data!.data!.length,
                                itemBuilder: (context,position){
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
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
                                          });;
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              border: Border.all(
                                                  color: Colors.black45, style: BorderStyle.solid, width: 0.80),
                                              color: Colors.white
                                          ),
                                          child: Column(
                                            children: [
                                              Container(
                                                height: MediaQuery.of(context).size.height *.22,
                                                width: MediaQuery.of(context).size.width *.30,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        height:100,
                                                        width: 150,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(5),
                                                            image: DecorationImage(
                                                              fit:BoxFit.fill,
                                                              image: NetworkImage("https://civildeal.com/civilmall/public/images/product/" +snapshot.data!.data![position].image!.toString()),
                                                            )
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(2.0),
                                                      child: Text(snapshot.data!.data![position].name!.toString(),
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 13
                                                        ),),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.all(2.0),
                                                          child: Text("₹ " +snapshot.data!.data![position].sellingPrice!.toString(),
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                              fontSize: 13,
                                                            ),),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 5.0,top: 2.0),
                                                          child: Text("₹ " +snapshot.data!.data![position].mrpPrice!.toString(),
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                                fontSize: 13,
                                                                decoration: TextDecoration.lineThrough,
                                                                color: Colors.red
                                                            ),),
                                                        )
                                                      ],
                                                    )

                                                  ],
                                                ),

                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          }else{
                            return Container(
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 10,),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: MyTheme.darkblue
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 25.0,top: 15.0),
                            child: Text("SERVICE",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold
                              ),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0,right: 25.0),
                            child: Container(
                              height: 35,
                              width: 65,
                              child: Card(
                                elevation: 2.0,
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: InkWell(
                                      onTap: (){
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => SeeAllVendorsPage(city_id: _selectedCity.toString(),
                                                )));
                                      },
                                      child: Text("See All",
                                        style: TextStyle(
                                            color: Colors.blueAccent,
                                            fontSize: 12
                                        ),),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0,left: 8.3,right: 8.3),
                    child: Container(
                      height: 160,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                          color: Colors.white
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: FutureBuilder<ServiceModel>(
                              future: getService(),
                              builder: (context , snapshot){
                                if(snapshot.hasData){
                                  return ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: snapshot.data!.data!.length,
                                      itemBuilder: (context,position){
                                        return Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Padding(
                                            padding: const EdgeInsets.only(bottom: 30.0),
                                            child: Card(
                                              elevation: 5,
                                              child: TouchableOpacity(
                                                activeOpacity: 0.2,
                                                child: InkWell(
                                                  onTap: (){
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) => Vendors(id: snapshot.data!.data![position].id!.toString(),city_id: _selectedCity.toString(),vendor_type: "service" ),
                                                        ));
                                                  },
                                                  child: Container(
                                                    height: MediaQuery.of(context).size.height *.25,
                                                    width: MediaQuery.of(context).size.width *.26,
                                                    child: Material(
                                                      child: Column(
                                                        children: [
                                                          Expanded(
                                                            child: Padding(
                                                              padding: const EdgeInsets.only(top: 5.0),
                                                              child: Container(
                                                                height:100,
                                                                width: 80,
                                                                decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(5),
                                                                    image: DecorationImage(
                                                                      fit:BoxFit.fill,
                                                                      image: NetworkImage("https://civildeal.com/public/assets/uploadsservice/" +snapshot.data!.data![position].bannerImage!.toString()),
                                                                    )
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Center(child: Padding(
                                                            padding: const EdgeInsets.all(2.0),
                                                            child: Text(snapshot.data!.data![position].name!.toString(),
                                                              textAlign: TextAlign.center,
                                                              style: TextStyle(
                                                                  fontSize: 13
                                                              ),),
                                                          ))
                                                        ],
                                                      ),
                                                    ),

                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                }else{
                                  return Container(
                                    width: double.infinity,
                                    child: Center(child: CircularProgressIndicator()),
                                  );
                                }

                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 10,),
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: MyTheme.darkblue
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 25.0,top: 15.0),
                            child: Text("PRODUCT",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold
                            ),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0,right: 25.0),
                            child: Container(
                              height: 35,
                              width: 65,
                              child: Card(
                                elevation: 2.0,
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: InkWell(
                                      onTap: (){
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => SeeAllProductPage(city_id: _selectedCity.toString(),
                                                )));
                                      },
                                      child: Text("See All",
                                        style: TextStyle(
                                            color: Colors.blueAccent,
                                            fontSize: 12
                                        ),),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0,left: 8.3,right: 8.3),
                    child: Container(
                      height: 160,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                          color: Colors.white
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: FutureBuilder<ProductModel>(
                              future: getProduct(),
                              builder: (context , snapshot){
                                if(snapshot.hasData){
                                  return ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: snapshot.data!.data!.length,
                                      itemBuilder: (context,position){
                                        return Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: TouchableOpacity(
                                            activeOpacity: 0.2,
                                            child: InkWell(
                                              onTap: (){
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => ProductVendors(id: snapshot.data!.data![position].id!.toString(),city_id: _selectedCity.toString()),
                                                    ));
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(bottom: 30.0),
                                                child: Card(
                                                  elevation: 5,
                                                  child: Container(
                                                    height: MediaQuery.of(context).size.height *.25,
                                                    width: MediaQuery.of(context).size.width *.26,
                                                    child: Column(
                                                      children: [
                                                        Expanded(
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(top: 5.0),
                                                            child: Container(
                                                              height:100,
                                                              width: 80,
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(5),
                                                                  image: DecorationImage(
                                                                    fit:BoxFit.fill,
                                                                    image: NetworkImage("https://civildeal.com/public/assets/uploads/product/" +snapshot.data!.data![position].productImage!.toString()),
                                                                  )
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Center(child: Padding(
                                                          padding: const EdgeInsets.all(2.0),
                                                          child: Text(snapshot.data!.data![position].name!.toString(),
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                                fontSize: 13
                                                            ),),
                                                        ))
                                                      ],
                                                    ),

                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                }else{
                                  return Container(
                                    width: double.infinity,
                                    child: Center(child: CircularProgressIndicator()),
                                  );
                                }

                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 10,),
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: MyTheme.darkblue
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 25.0,top: 15.0),
                            child: Text("MAINTENANCE",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold
                              ),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0,right: 25.0),
                            child: Container(
                              height: 35,
                              width: 65,
                              child: Card(
                                elevation: 2.0,
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: InkWell(
                                      onTap: (){
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => SeeAllMaintenancePage(city_id: _selectedCity.toString(),
                                                )));
                                      },
                                      child: Text("See All",
                                        style: TextStyle(
                                            color: Colors.blueAccent,
                                            fontSize: 12
                                        ),),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0,left: 8.3,right: 8.3),
                    child: Container(
                      height: 160,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                          color: Colors.white
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: FutureBuilder<MaintenanceModel>(
                              future: getMaintenance(),
                              builder: (context , snapshot){
                                if(snapshot.hasData){
                                  return ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: snapshot.data!.data!.length,
                                      itemBuilder: (context,position){
                                        return Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: TouchableOpacity(
                                            activeOpacity: 0.2,
                                            child: InkWell(
                                              onTap: (){
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => MaintenanceVendors(id: snapshot.data!.data![position].id!.toString(),),
                                                    ));
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(bottom: 30.0),
                                                child: Card(
                                                  elevation: 5,
                                                  child: Container(
                                                    height: MediaQuery.of(context).size.height *.25,
                                                    width: MediaQuery.of(context).size.width *.26,
                                                    child: Column(
                                                      children: [
                                                        Expanded(
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(top: 5.0),
                                                            child: Container(
                                                              height:100,
                                                              width: 80,
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(5),
                                                                  image: DecorationImage(
                                                                    fit:BoxFit.fill,
                                                                    image: NetworkImage("https://civildeal.com/public/assets/uploadsservice/" +snapshot.data!.data![position].bannerImage!.toString()),
                                                                  )
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Center(child: Padding(
                                                          padding: const EdgeInsets.all(2.0),
                                                          child: Text(snapshot.data!.data![position].name!.toString(),
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                                fontSize: 13
                                                            ),),
                                                        ))
                                                      ],
                                                    ),

                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                }else{
                                  return Container(
                                    width: double.infinity,
                                    child: Center(child: CircularProgressIndicator()),
                                  );
                                }

                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 10,),


            ],
          ),
        ),
      ),

      drawer: MyDrawer(),
    );
  }
}


// class DataSearch extends SearchDelegate<String>{
//   late List category;
//
//   DataSearch({
//     required String category,
//   }) : super(
//   );
//
//   // final cities = [
//   //   "kota",
//   //   "jaipur",
//   //   "pali"
//   // ];
//
//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     return [
//       IconButton(icon: Icon(Icons.clear), onPressed: (){
//         query = "";
//       },)
//     ];
//   }
//
//   @override
//   Widget? buildLeading(BuildContext context) {
//     return IconButton(icon: AnimatedIcon(
//       icon: AnimatedIcons.menu_arrow,
//     progress: transitionAnimation,
//     ),
//     onPressed: (){
//       // close(context, null);
//     },
//     );
//   }
//
//   @override
//   Widget buildResults(BuildContext context) {
//     // TODO: implement buildResults
//     throw UnimplementedError();
//   }
//
//   @override
//   Widget buildSuggestions(BuildContext context) {
//     // TODO: implement buildResults
//     // throw UnimplementedError();
//     // final suggestionList = query.isNotEmpty?:"";
//
//     return ListView.builder(itemBuilder: (context, index) => ListTile(
//       leading: Icon(Icons.search_rounded),
//       title: Text(category[index]),
//     ),);
//   }
//
// }

