import 'dart:convert';

import 'package:civildeal_user_app/Model/GetDrawingSizeListModel.dart';
import 'package:civildeal_user_app/Model/GetDrawingUnitCategoryModel.dart';
import 'package:civildeal_user_app/Model/GetInteriorCategoryModel.dart';
import 'package:civildeal_user_app/Model/GetInteriorSizeModel.dart';
import 'package:civildeal_user_app/Screens/drawing.dart';
import 'package:civildeal_user_app/Screens/interior_exterior_screen.dart';
import 'package:civildeal_user_app/Services/Utilities/app_url.dart';
import 'package:civildeal_user_app/Widget/theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class InteriorDialog extends StatefulWidget {

  @override
  State<InteriorDialog> createState() => _InteriorDialogState();
}

class _InteriorDialogState extends State<InteriorDialog> {
  String ?_selectedCategory,_selectedSize;
  List categoryList = [];
  List sizeList = [];
  Future<GetInteriorCategoryModel> getInteriorCategory () async{
    final response = await http.get(Uri.parse(AppUrl.getInteriorCategoryApi));
    var data = jsonDecode(response.body.toString());
    var status= data["status"];
    setState(() {
      categoryList = data['data'];
    });

    print(categoryList);
    if(response.statusCode==200){
      if(status == "Success"){
        print(data["message"]);
        return GetInteriorCategoryModel.fromJson(data);

      }
      else{
        print(data["message"]);
        return GetInteriorCategoryModel.fromJson(data);

      }
    }
    else{
      return GetInteriorCategoryModel.fromJson(data);
    }
  }

  Future<GetInteriorSizeModel> getdrawingSize () async{
    final response = await http.get(Uri.parse(AppUrl.getInteriorSizeApi));
    var data = jsonDecode(response.body.toString());
    var status= data["status"];
    setState(() {
      sizeList = data['data'];
    });

    if(response.statusCode==200){
      if(status == "Success"){
        print(data["message"]);
        return GetInteriorSizeModel.fromJson(data);

      }
      else{
        print(data["message"]);
        return GetInteriorSizeModel.fromJson(data);

      }
    }
    else{
      return GetInteriorSizeModel.fromJson(data);
    }
  }


  dialogContent(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: const Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // To make the card compact
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 5.0,left: 17.0,bottom: 5.0),
            child: Text("Select Category",
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
                  value: _selectedCategory,
                  onChanged: (newUnit){
                    setState(() {
                      _selectedCategory = "$newUnit";
                    });
                  },
                  items: categoryList.map((item) {
                    return DropdownMenuItem(
                      child: Text(item['name']),
                      value: item['id'].toString(),
                    );
                  }).toList(),
                  hint: Text("Select Category"),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0,left: 17.0,bottom: 5.0),
            child: Text("Select Size",
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
                  value: _selectedSize,
                  onChanged: (newSize){
                    setState(() {
                      _selectedSize = "$newSize";
                    });
                  },
                  items: sizeList.map((item) {
                    return DropdownMenuItem(
                      child: Text(item['name']),
                      value: item['id'].toString(),
                    );
                  }).toList(),
                  hint: Text("Select Size"),
                ),
              ),
            ),
          ),
          SizedBox(height: 25,),
          Padding(
            padding: const EdgeInsets.only(left: 16.0,right: 16.0,top: 16.0,bottom: 50.0),
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => InteriorExteriorScreen(
                                category_id: _selectedCategory.toString(),
                                size: _selectedSize.toString(),
                            )));
                  },
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

          Align(
            alignment: Alignment.bottomCenter,
            child: InkWell(
                onTap: (){
                  Navigator.pop(context, false);
                },
                child: Icon(Icons.cancel)),
          ),
        ],
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    getInteriorCategory();
    getdrawingSize();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }
}