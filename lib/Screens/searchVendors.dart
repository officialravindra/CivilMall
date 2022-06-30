import 'dart:convert';

import 'package:civildeal_user_app/Model/MaintenanceModel.dart';
import 'package:civildeal_user_app/Model/ProductModel.dart';
import 'package:civildeal_user_app/Screens/serviceVendors.dart';
import 'package:civildeal_user_app/Services/Utilities/app_url.dart';
import 'package:flutter/material.dart';

import '../Model/ServiceModel.dart';
import 'package:http/http.dart' as http;

class VendorsSearch extends StatefulWidget {
  String city_id,vendor_type;
  VendorsSearch({Key? key, required this.city_id,required this.vendor_type}) : super(key: key);

  @override
  State<VendorsSearch> createState() => _VendorsSearchState(city_id,vendor_type);
}

class _VendorsSearchState extends State<VendorsSearch> {
  String city_id,vendor_type;
  _VendorsSearchState(this.city_id,this.vendor_type);

  List _category = [];
  List _categoryList = [];
  List _searchedNames = [];
  Future<ServiceModel> getService () async{
    final response = await http.get(Uri.parse(AppUrl.servicerApi));
    var data = jsonDecode(response.body.toString());
    var code= data["code"];
    setState(() {
      _category.clear();
      
      _category = _searchedNames = data['data'.toString().toLowerCase()];
      // for(int i =0; i<=_category.length;i++){
      //    _categoryList.add(_category[i]['name'.toLowerCase()]) ;
      //    print(_categoryList);
      //
      // }


    });
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
    setState(() {
      _category.clear();
      _category = _searchedNames =data['data'.toString()];
    });
    print("category "+_category.toString());

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
    setState(() {
      _category.clear();
      _category = _searchedNames = data['data'.toString().toLowerCase()];
    });
    print("category "+_category.toString());

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
  // changes the filtered name based on search text and sets state.
  void _searchChanged(String searchText) {
    if (searchText != null && searchText.isNotEmpty) {

      setState(() {
        _searchedNames =
            List.from(_category.where((name) => name['name'.toString().toLowerCase()].contains(searchText)));
        print(searchText);

        // print(List.from(_category.where((name) => name.contains(searchText))).toString());


      });
    }
    else {
      setState(() {
        _searchedNames  =
            List.from(_category);
        print("searchText "+searchText);
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      if(vendor_type=="service"){
        getService();
        print("services");
      }else if(vendor_type=="product"){
        getProduct();
        print("product");
      }else if(vendor_type=="maintenance"){
        getMaintenance();
        print("maintenance");
      }
      print(city_id);
    });

  }
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15.0,top: 50.0,right: 15.0),
            child: TextField(
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: "Search",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )
              ),
              onChanged: _searchChanged,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchedNames.length,
              itemBuilder: (context, index) => Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0,top: 8.0,bottom: 8.0),
                      child: InkWell(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Vendors(id: _category[index]['id'].toString(),city_id: city_id.toString(),vendor_type: vendor_type ),
                              ));
                        },
                        child: Text(_searchedNames[index]['name'].toString().toLowerCase(),
                        style: TextStyle(
                          fontSize: 14
                        ),),
                      ),
                    ),
                    Container(
                      height: 0.5,
                      color: Colors.black45,
                    )
                  ],
                )

              ),
            ),
          ),
        ],
      )


    );
  }
}
