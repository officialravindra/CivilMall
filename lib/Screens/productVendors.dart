import 'dart:convert';

import 'package:civildeal_user_app/Model/GetCityModel.dart';
import 'package:civildeal_user_app/Model/ProductDetailsModel.dart';
import 'package:civildeal_user_app/Model/VendorsModel.dart';
import 'package:civildeal_user_app/Screens/vendorProfile.dart';
import 'package:civildeal_user_app/Widget/theme.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Services/Utilities/app_url.dart';


class ProductVendors extends StatefulWidget {
  String id,city_id;
  ProductVendors({Key? key, required this.id,required this.city_id}) : super(key: key);

  @override
  State<ProductVendors> createState() => _ProductVendorsState(id,city_id);
}

class _ProductVendorsState extends State<ProductVendors> {
  String id,city_id;
  _ProductVendorsState(this.id,this.city_id);
  List vendorsList = [];
  final _formKey = GlobalKey<FormState>();
  TextEditingController requirmentController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  late String vendor_type,vendor_id;
  void getCred() async{

    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      vendor_type = pref.getString("vendor_type")!;
      print(vendor_type);
    });

  }

  List cityList = [];

  String ?_selectedCity,lead_type;

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
        print("sucess");
        return GetCityModel.fromJson(data);

      }
      else{
        print("fail");
        return GetCityModel.fromJson(data);

      }
    }
    else{
      return GetCityModel.fromJson(data);
    }
  }

  Future<VendorsModel> getServiceVendors (String id) async{

    final response = await http.post(Uri.parse("https://civildeal.com/Api/vendorlist"),
        body: {
          'id':id,
          'city_id':city_id,
          'vendor_type':"product",
        }
    );
    print("city "+city_id);
    print("id "+id);
    var data = jsonDecode(response.body.toString());

    if(response.statusCode==200){
      var responseData = json.decode(response.body);
      var code= responseData["code"];
      var message= responseData["message"];
      setState(() {
        vendorsList = data['data'];
      });
      if(code==200){
        return VendorsModel.fromJson(data);
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
        return VendorsModel.fromJson(data);
      }
    }
    else
    {
      return VendorsModel.fromJson(data);
    }

  }

  Future<ProductDetailsModel> getProductDetails (String id) async{

    final response = await http.post(Uri.parse("https://civildeal.com/Api/getProductDetails"),
        body: {
          'product_id':id,
        }
    );
    var data = jsonDecode(response.body.toString());

    if(response.statusCode==200){
      var responseData = json.decode(response.body);
      var code= responseData["code"];
      var message= responseData["message"];

      if(code==200){
        return ProductDetailsModel.fromJson(data);
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
        return ProductDetailsModel.fromJson(data);
      }
    }
    else
    {
      return ProductDetailsModel.fromJson(data);
    }

  }

  void submitSendEnquiry(String requirment , name , email , mobile , cityid) async{

    if(_formKey.currentState!.validate()){

      try{

        Response response = await post(
            Uri.parse(AppUrl.directVendorEnquiryApi),
            body: {
              'query':requirment,
              'name':name,
              'email':email,
              'phone':mobile,
              'citi_id':cityid,
              'service_id':"",
              'product_id':id,
              'leadtype':"product",
            }
        );

        if(response.statusCode==200){


          var responseData = json.decode(response.body);


          var code= responseData["code"];


          print("responseCode"+code.toString());


          if(code == 200)
          {
            var data = responseData["data"];
            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //   content: Text("Enquiry Send Succesfully"),
            // ));
            Fluttertoast.showToast(
                msg: "Enquiry Send Succesfully",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.SNACKBAR,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0
            );
            requirmentController.clear();
            nameController.clear();
            emailController.clear();
            mobileController.clear();
            print(responseData["message"]);




            var message = responseData["message"];




            print("data"+data[0]["name"]);


          }
          else{

            var message = responseData["message"];
            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //   content: Text(""+message),
            // ));
            Fluttertoast.showToast(
                msg: message,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.SNACKBAR,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }



        }else{
          var responseData = json.decode(response.body);

        }
      }catch(e){
        print("exe "+e.toString());
        // Fluttertoast.showToast(
        //     msg: ""+e.toString(),
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.CENTER,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.black,
        //     textColor: Colors.white,
        //     fontSize: 16.0
        // );
      }
    }


  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCred();
    getCityList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vendors"),
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
        color: MyTheme.creamColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 25,
              child: FutureBuilder<ProductDetailsModel>(
                future: getProductDetails(id),
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Card(
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex:40,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 5.0,left: 5.0,bottom: 5.0),
                                  child: Container(
                                    height:100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage("https://civildeal.com/public/assets/uploads/product/" +snapshot.data!.data![0].productImage!.toString()),
                                        )
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 60,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(snapshot.data!.data![0].name.toString(),
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold
                                          ),),
                                          Text("Availability :",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                            ),),
                                          Text("In Stock :",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 14,
                                            ),),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 5.0,top: 5.0,bottom: 5.0),
                                            child: InkWell(
                                              onTap: (){
                                                sendEnquiry();
                                              },
                                              child: Container(
                                                height:40,
                                                width: 120,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(5),
                                                  color: MyTheme.skyblue
                                                ),
                                                child: Center(
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text("Contact now",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14
                                                    ),),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }else
                    {
                      return Text("Loading...");
                    }
                },
              ),
            ),

            Expanded(
              flex: 5,
              child: Text("FEATURE VENDORS",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold
              ),),
            ),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                color: Colors.black,
                height: 1,
                width: double.infinity,
              ),
            ),
            Expanded(
              flex: 70,
              child: FutureBuilder<VendorsModel>(
                future: getServiceVendors(id),
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
                                      flex:30,
                                      child: Padding(
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
                                              SizedBox(height: 5,),
                                              Text(snapshot.data!.data![position].companyName.toString(),
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold
                                                ),),
                                              SizedBox(height: 3,),
                                              Text("Service : "+snapshot.data!.data![position].serviceProuductName.toString(),
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black,
                                                ),),
                                              SizedBox(height: 3,),
                                              Text("Experience : "+snapshot.data!.data![position].experience.toString(),
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                ),),
                                              SizedBox(height: 3,),
                                              Text("Location : "+snapshot.data!.data![position].locationName.toString(),
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.blue,
                                                ),),
                                              SizedBox(height: 5,),
                                              InkWell(
                                                onTap: (){
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) => VendorProfile(id: snapshot.data!.data![position].id!.toString(),),
                                                      ));
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.only(right: 15.0),
                                                  child: Align(
                                                    alignment: Alignment.centerRight,
                                                    child: Container(
                                                      height: 35,
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                          color: MyTheme.skyblue,
                                                          borderRadius: BorderRadius.circular(5)
                                                      ),
                                                      child: Center(child: Text("View",
                                                        style: TextStyle(
                                                            color: Colors.white
                                                        ),)),
                                                    ),
                                                  ),
                                                ),

                                              ),
                                              SizedBox(height: 5,),
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
                    return Center(child: Text("No Vendor Found"));
                  }else{
                   return Text("Loading...");
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
  void sendEnquiry() {
    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), //this right here
      child: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(

              child: Padding(
                padding: const EdgeInsets.only(left: 10.0,top: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text("TELL US WHAT YOU",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: MyTheme.skyblue,
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 5.0,right: 5.0),
                                  child: Text(
                                    "NEED",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        color: Colors.black54,
                        height: 1,
                        width: double.infinity,
                      ),
                    ),
                    SizedBox(height: 15,),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              TextFormField(
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                    hintText: "Enter Requirment",
                                    labelText: "Requirment",
                                    isDense: true,
                                    contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10)
                                    )
                                ),
                                validator: (value){
                                  if(value!.isEmpty){
                                    return "Requirment cannot be empty";
                                  }
                                  return null;
                                },
                                autofocus: false,
                                keyboardType: TextInputType.text,
                                controller: requirmentController,
                              ),

                              SizedBox(height: 20.0,),

                              TextFormField(
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                    hintText: "Enter Your Name",
                                    labelText: "Name",
                                    suffixIcon: Icon(Icons.person),
                                    isDense: true,
                                    contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10)
                                    )
                                ),
                                validator: (value){
                                  if(value!.isEmpty){
                                    return "Name cannot be empty";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.text,
                                controller: nameController,
                              ),

                              SizedBox(height: 20.0,),

                              TextFormField(
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                    hintText: "Enter Email",
                                    labelText: "Email",
                                    suffixIcon: Icon(Icons.email),
                                    isDense: true,
                                    contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10)
                                    )
                                ),
                                validator: (value){
                                  if(value!.isEmpty){
                                    return "Email cannot be empty";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.emailAddress,
                                controller: emailController,
                              ),
                              SizedBox(height: 20.0,),

                              TextFormField(
                                decoration: InputDecoration(
                                    hintText: "Enter Mobile",
                                    labelText: "Mobile",
                                    isDense: true,
                                    contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10)
                                    )
                                ),
                                validator: (value){
                                  if(value!.isEmpty){
                                    return "Mobile cannot be empty";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                controller: mobileController,
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 5,),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0,right: 15),
                          child: Container(
                            height: 40,
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            decoration: BoxDecoration(

                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                  color: Colors.black45, style: BorderStyle.solid, width: 0.80),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                value: _selectedCity,
                                onChanged: (newCity){
                                  setState(() {
                                    _selectedCity = "$newCity";
                                    print(_selectedCity);
                                  });
                                },
                                items: cityList.map((item) {
                                  return DropdownMenuItem(
                                    child: Text(item['name']),
                                    value: item['id'].toString(),
                                  );
                                }).toList(),
                                hint: Text("Select City"),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 25,),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0,right: 16.0,top: 16.0,bottom: 100.0),
                          child: InkWell(
                            onTap: (){
                              submitSendEnquiry(requirmentController.text.toString(),nameController.text.toString(),emailController.text.toString(),mobileController.text.toString(),_selectedCity);
                            },
                            child: Ink(
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: MyTheme.skyblue,
                              ),

                              child: Center(
                                child: Text(
                                  "Submit",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
    showDialog(context: context, builder: (BuildContext context) => errorDialog);}
}
