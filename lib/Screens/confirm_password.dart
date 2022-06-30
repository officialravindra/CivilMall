import 'dart:convert';

import 'package:civildeal_user_app/Screens/login_page.dart';
import 'package:civildeal_user_app/Services/Utilities/app_url.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import '../Utils/routs.dart';
import '../Widget/theme.dart';

class ConfirmPasswordPage extends StatefulWidget {
  String mobile;
  ConfirmPasswordPage({Key? key,required this.mobile}) : super(key: key);

  @override
  State<ConfirmPasswordPage> createState() => _ConfirmPasswordPageState(mobile);
}

class _ConfirmPasswordPageState extends State<ConfirmPasswordPage> {
  String mobile;
  _ConfirmPasswordPageState(this.mobile);
  bool _isHidden = true;
  final _formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void submitpassword(String mobile, password, confirmPassword) async{
    print(mobile);
    print(password);
    print(confirmPassword);
    if(_formKey.currentState!.validate()){

      try{
        Response response = await post(
            Uri.parse(AppUrl.confirmpasswordLogin),
            body: {
              'mobile':mobile,
              'password':password,
              'conform_password':confirmPassword,
            }
        );

        if(response.statusCode==200){
          var responseData = json.decode(response.body);


          var status= responseData["status"];
          var message= responseData["message"];



          if(status=="Success"){
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);

            Fluttertoast.showToast(
                msg: message,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }
          else{
            print("failed"+response.body);
            var message= responseData["message"];
            Fluttertoast.showToast(
                msg: message,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('Confirm Password',style: TextStyle(
            color: Colors.black
        ),),
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 60,),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text("Create new password",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                ),),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 10.0,right: 10.0),
              child: Text("Your new password must be different from previous password",
                style: TextStyle(
                    fontSize: 16,
                ),),
            ),
            SizedBox(height: 30,),
            Form(
              key: _formKey,
              child: Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0,right: 20.0),
                      child: TextFormField(
                        obscureText: _isHidden,
                        decoration: InputDecoration(
                            hintText: "Enter Password",
                            labelText: "Password",
                            suffix: InkWell(
                              onTap: _togglePasswordView,
                              child: Icon(
                                _isHidden ?         /// CHeck Show & Hide.
                                Icons.visibility :
                                Icons.visibility_off,
                              ),
                            ),
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
                        controller: passwordController,
                      ),
                    ),
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0,right: 20.0),
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            hintText: "Enter Confirm Password",
                            labelText: "Confirm Password",
                            isDense: true,
                            contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            )
                        ),
                        validator: (value){
                          if(value!=passwordController.text.toString()){
                            return "Confirm Password Not match";
                          }
                          return null;
                        },
                        autofocus: false,
                        keyboardType: TextInputType.visiblePassword,
                        controller: confirmPasswordController,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30,),
            Center(
              child: Container(
                height: 50,
                width: 200,
                child: Material(
                  color: MyTheme.skyblue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                  elevation: 6.0,
                  //shadowColor: Colors.grey[50],

                  child: InkWell(
                    splashColor: const Color(0x8034b0fc),
                    onTap: () {
                      submitpassword(mobile, passwordController.text.toString(),confirmPasswordController.text.toString());
                      // Navigator.pushNamed(context, MyRoutes.confirmPasswordRoute);
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

          ],
        ),
      ),
    );
  }
  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}


