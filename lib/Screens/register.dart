import 'dart:convert';

import 'package:civildeal_user_app/Services/Utilities/app_url.dart';
import 'package:civildeal_user_app/Widget/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:http/http.dart'as http;

import '../Model/GetCityModel.dart';
import '../Utils/routs.dart';


class UserRegister extends StatefulWidget {
  const UserRegister({Key? key}) : super(key: key);

  @override
  State<UserRegister> createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  List cityList = [];

  String ?_selectedCity;
  var city = {'Jaipur':'1','Kota':'2','Ajmer':'3'};
  List _cities = [];
  CityDependentDropDown(){
    city.forEach((key, value) {
      _cities.add(key);
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

  
  void Register(String name, lastname, mobile, email , password ,city) async{
    
    if(_formKey.currentState!.validate()){
      
      try{
        Response response = await post(
            Uri.parse(AppUrl.registerApi),
          body: {
              'username':name,
              'lastname':lastname,
              'mobile':mobile,
              'email':email,
              'password':password,
              'location':city,
          }
        );

        if(response.statusCode==200){
          var responseData = json.decode(response.body);


          var status= responseData["status"];
          var message= responseData["message"];




          if(status=="Success"){
            Navigator.pushNamed(context, MyRoutes.loginRoute);
            print("Register Succesfully"+response.body);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Register Succesfully"),
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
    CityDependentDropDown();
    getCityList();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Image.asset("assets/images/cd_image.jpeg",fit: BoxFit.cover,
              ),
              Text("Register Now",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          hintText: "Enter Name",
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
                      autofocus: false,
                      keyboardType: TextInputType.text,
                      controller: nameController,
                    ),

                    SizedBox(height: 20.0,),

                    TextFormField(
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          hintText: "Enter Last Name",
                          labelText: "Last Name",
                          suffixIcon: Icon(Icons.person),
                          isDense: true,
                          contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          )
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return "Last Name cannot be empty";
                        }
                        return null;
                      },
                      autofocus: false,
                      keyboardType: TextInputType.text,
                      controller: lastnameController,
                    ),
                    SizedBox(height: 20.0,),
                    TextFormField(
                      inputFormatters: [
                        new LengthLimitingTextInputFormatter(10),
                      ],
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          hintText: "Enter Mobile No",
                          labelText: "Mobile No",
                          suffixIcon: Icon(Icons.phone_android),
                          isDense: true,
                          contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          )
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return "Mobile No cannot be empty";
                        }else if(value.length < 10){
                          return "Fill 10 number digit";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      controller: mobileNoController,
                    ),

                    SizedBox(height: 20.0,),

                    TextFormField(
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          hintText: "Enter Your Email",
                          labelText: "Email",
                          suffixIcon: Icon(Icons.person),
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
                      autofocus: false,
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                    ),

                    SizedBox(height: 20.0,),

                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: "Enter Password",
                          labelText: "Password",
                          isDense: true,
                          contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          )
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return "Password cannot be empty";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      controller: passwordController,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.only(left: 16.0,right: 16),
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
              Padding(
                padding: const EdgeInsets.only(left: 16.0,right: 16.0,top: 16.0,bottom: 100.0),
                child: InkWell(
                  onTap: (){
                    Register(nameController.text.toString(),lastnameController.text.toString(),mobileNoController.text.toString(),emailController.text.toString(),passwordController.text.toString(),_selectedCity);
                  },
                  child: Ink(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: MyTheme.skyblue,
                    ),

                    child: Center(
                      child: Text(
                        "Register now",
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
        ),
      ),
    );
  }
}
