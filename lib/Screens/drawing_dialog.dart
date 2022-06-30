import 'dart:convert';

import 'package:civildeal_user_app/Model/GetDrawingSizeListModel.dart';
import 'package:civildeal_user_app/Model/GetDrawingUnitCategoryModel.dart';
import 'package:civildeal_user_app/Screens/drawing.dart';
import 'package:civildeal_user_app/Services/Utilities/app_url.dart';
import 'package:civildeal_user_app/Widget/theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CustomDialog extends StatefulWidget {

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  String ?_selectedUnit,_selectedSize;
  List unitList = [];
  List sizeList = [];
  Future<GetDrawingUnitCategoryModel> getdrawingUnit () async{
    final response = await http.get(Uri.parse(AppUrl.getDrawingUnitApi));
    var data = jsonDecode(response.body.toString());
    var status= data["status"];
    setState(() {
      unitList = data['data'];
    });

    print(unitList);
    if(response.statusCode==200){
      if(status == "Success"){
        print(data["message"]);
        return GetDrawingUnitCategoryModel.fromJson(data);

      }
      else{
        print(data["message"]);
        return GetDrawingUnitCategoryModel.fromJson(data);

      }
    }
    else{
      return GetDrawingUnitCategoryModel.fromJson(data);
    }
  }

  Future<GetDrawingSizeListModel> getdrawingSize () async{
    final response = await http.get(Uri.parse(AppUrl.getDrawingSizeApi));
    var data = jsonDecode(response.body.toString());
    var status= data["status"];
    setState(() {
      sizeList = data['data'];
    });

    if(response.statusCode==200){
      if(status == "Success"){
        print(data["message"]);
        return GetDrawingSizeListModel.fromJson(data);

      }
      else{
        print(data["message"]);
        return GetDrawingSizeListModel.fromJson(data);

      }
    }
    else{
      return GetDrawingSizeListModel.fromJson(data);
    }
  }

  String ?_selectedBuildingType;
  var type = {'single story':'1','double story':'2','triple story':'3'};
  List _types = [];
  TypeDependentDropDown(){
    type.forEach((key, value) {
      _types.add(key);
    });
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
            child: Text("Select Unit",
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
                  value: _selectedUnit,
                  onChanged: (newUnit){
                    setState(() {
                      _selectedUnit = "$newUnit";
                    });
                  },
                  items: unitList.map((item) {
                    return DropdownMenuItem(
                      child: Text(item['name']),
                      value: item['id'].toString(),
                    );
                  }).toList(),
                  hint: Text("Select Unit"),
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
          Padding(
            padding: const EdgeInsets.only(top: 5.0,left: 17.0,bottom: 5.0),
            child: Text("Select Building Type",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14
              ),),
          ),
          Padding(
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
                  value: _selectedBuildingType,
                  onChanged: (newValue){
                    setState(() {

                      // CategoryDependentDropDown(type[newValue]);

                      _selectedBuildingType = "$newValue";

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
                  hint: Text("Select Building Type",
                    style: TextStyle(
                        fontSize: 13
                    ),),
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
                            builder: (context) => DrawingScreen(
                                unit_id: _selectedUnit.toString(),
                                size: _selectedSize.toString(),
                                building_type: _selectedBuildingType.toString()
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
    getdrawingUnit();
    getdrawingSize();
    TypeDependentDropDown();
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