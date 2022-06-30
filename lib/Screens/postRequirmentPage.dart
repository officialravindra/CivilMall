import 'dart:convert';

import 'package:civildeal_user_app/Model/GetCityModel.dart';
import 'package:civildeal_user_app/Model/MaintenanceModel.dart';
import 'package:civildeal_user_app/Model/ProductModel.dart';
import 'package:civildeal_user_app/Model/ServiceModel.dart';
import 'package:civildeal_user_app/Services/Utilities/app_url.dart';
import 'package:civildeal_user_app/Widget/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class PostRequriment extends StatefulWidget {
  const PostRequriment({Key? key}) : super(key: key);

  @override
  State<PostRequriment> createState() => _PostRequrimentState();
}

class _PostRequrimentState extends State<PostRequriment> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController requirmentController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  List cityList = [];
  List _category = [];
  String ?_selectedCity;
  String ?_selectedType;
  var type = {'service':'1','product':'2','maintenance':'3'};
  List _types = [];
  TypeDependentDropDown(){
    type.forEach((key, value) {
      _types.add(key);
    });
  }

  String ?_selectedCategory;

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

  Future<ServiceModel> getService () async{
    final response = await http.get(Uri.parse(AppUrl.servicerApi));
    var data = jsonDecode(response.body.toString());
    var code= data["code"];
    setState(() {
      _category.clear();
      _category = data['data'.toString()];
      // Fluttertoast.showToast(
      //     msg: _category.toString(),
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.CENTER,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: Colors.red,
      //     textColor: Colors.white,
      //     fontSize: 16.0
      // );

      print(_category);
    });
    if(response.statusCode==200){
      if(code == 200){
        _selectedCategory = _category[0];
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
    setState(() {
      _category.clear();
      _category = data['data'.toString()];
    });

    if(response.statusCode==200){

      if(code == 200){
        _selectedCategory = _category[0];
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
    setState(() {
      _category.clear();
      _category = data['data'.toString()];
    });

    if(response.statusCode==200){
      if(code == 200){

        _selectedCategory = _category[0];
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

  void postRequirement(String query,name, mobile) async{

    if(_formKey.currentState!.validate()){

      try{
        Response response = await post(
            Uri.parse("https://civildeal.com/Api/saveGeneralEnquery"),
            body: {
              'query':query,
              'name':name,
              'mobile':mobile,
              'city_id':"1",
              'leadtype':"service",
              'service_name':"architect",
              'product_name':"",
            }
        );

        if(response.statusCode==200){
          var responseData = json.decode(response.body);


          var code= responseData["code"];
          var message= responseData["message"];


          print("responseCode"+code.toString());

          if(code==200){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(message),
            ));
            requirmentController.clear();
            nameController.clear();
            mobileNoController.clear();

            var data = responseData["data"];


            print("data"+data[0]["name"]);
          }
          else{
            print("failed"+response.body);
            var message= responseData["message"];
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(""+message),
            ));
            Fluttertoast.showToast(
                msg: message,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }
        }
        else{
          print("failed2"+response.body);
        }
      }catch(e){
        print("exce " +e.toString());
      }
    }else{
      print("failed");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    TypeDependentDropDown();
    getCityList();
    getService();
    getProduct();
    getMaintenance();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post Requirment"),
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
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30,),
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
                              "Need",
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
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text("Requirment",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14
                  ),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      hintText: "Enter requirment ",
                      isDense: true,
                      contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),
                  validator: (value){
                    if(value!.isEmpty){
                      return "Requirement can not be empty";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  controller: requirmentController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0,left: 15.0),
                child: Text("Name",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14
                  ),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      hintText: "Enter Name ",
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
              ),

              Padding(
                padding: const EdgeInsets.only(top: 5.0,left: 15.0),
                child: Text("Mobile",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  inputFormatters: [
                    new LengthLimitingTextInputFormatter(10),
                  ],
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      hintText: "Enter Mobile No ",
                      isDense: true,
                      contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),
                  validator: (value){
                    if(value!.isEmpty){
                      return "Mobile no can not be empty";
                    }else if(value.length < 10){
                      return "Fill 10 number digit";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  controller: mobileNoController,
                ),
              ),
              SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.only(top: 5.0,left: 17.0,bottom: 5.0),
                child: Text("Select City",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14
                  ),),
              ),
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
              SizedBox(height: 15,),
              Container(

                child: Row(

                  children: [
                    Expanded(
                      flex: 40,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0,top: 5.0,right: 10.0,bottom: 0.0),
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
                              value: _selectedType,
                              onChanged: (newValue){
                                setState(() {
                                  _category =[];
                                  // CategoryDependentDropDown(type[newValue]);

                                  _selectedType = "$newValue";
                                  print(_selectedType);
                                  // Fluttertoast.showToast(
                                  //     msg: _selectedType.toString(),
                                  //     toastLength: Toast.LENGTH_SHORT,
                                  //     gravity: ToastGravity.CENTER,
                                  //     timeInSecForIosWeb: 1,
                                  //     backgroundColor: Colors.red,
                                  //     textColor: Colors.white,
                                  //     fontSize: 16.0
                                  // );
                                  if(_selectedType=="service"){
                                    getService();

                                  }else if(_selectedType == "product"){

                                    getProduct();
                                  }else if(_selectedType == "maintenance"){

                                    getMaintenance();
                                  }
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
                                  //         style: TextStyle(color: Colors.black,fontSize: 13),
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
                    Expanded(
                      flex: 50,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 0.0,top: 5.0,right: 5.0,bottom: 0.0),
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
                              value: _selectedCategory,
                              onChanged: (newValue){
                                setState(() {
                                  _selectedCategory = "$newValue";
                                });
                                // Fluttertoast.showToast(
                                //     msg: _selectedCategory.toString(),
                                //     toastLength: Toast.LENGTH_SHORT,
                                //     gravity: ToastGravity.CENTER,
                                //     timeInSecForIosWeb: 1,
                                //     backgroundColor: Colors.red,
                                //     textColor: Colors.white,
                                //     fontSize: 16.0
                                // );
                                print(newValue);
                              },
                              items: _category.map((item){
                                return DropdownMenuItem(
                                  child: Text(item['name'],style: TextStyle(fontSize: 13)),
                                  // child: Flexible(
                                  //   child: RichText(
                                  //     overflow: TextOverflow.ellipsis,
                                  //     // strutStyle: StrutStyle(fontSize: 12.0),
                                  //     text: TextSpan(
                                  //         style: TextStyle(color: Colors.black,fontSize: 13),
                                  //         text:item['name'] ),
                                  //   ),
                                  // ),
                                  value: item['id'].toString(),
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
                    )

                  ],
                ),
              ),
              SizedBox(height: 25,),
              Padding(
                padding: const EdgeInsets.only(left: 16.0,right: 16.0,top: 16.0,bottom: 100.0),
                child: Container(
                  height: 50,
                  child: Material(
                    color: MyTheme.skyblue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    elevation: 6.0,
                    //shadowColor: Colors.grey[50],

                    child: InkWell(
                      splashColor: const Color(0x8034b0fc),
                      onTap: () {
                        postRequirement(requirmentController.text.toString(),nameController.text.toString(),mobileNoController.text.toString(),);                      },
                      child: Container(

                        //decoration: ,

                        child: Center(
                          child: Text(
                            'Submit',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                          ),
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
    );
  }
}
