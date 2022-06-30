import 'dart:convert';

import 'package:civildeal_user_app/Screens/verify_otp.dart';
import 'package:civildeal_user_app/Services/Utilities/app_url.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import '../Utils/routs.dart';
import '../Widget/theme.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController mobileController = TextEditingController();
  void forgetPassword(String mobile) async{

    if(_formKey.currentState!.validate()){

      try{
        Response response = await post(
            Uri.parse(AppUrl.forgotLogin),
            body: {
              'mobile':mobile,
            }
        );

        if(response.statusCode==200){
          var responseData = json.decode(response.body);


          var code= responseData["code"];
          var message= responseData["message"];


          if(code==200){
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VerifyOtpPage(mobile: mobile),
                ));
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(message),
            ));

          }
          else{
            print("failed"+response.body);
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
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor: Colors.white,
    //   statusBarBrightness: Brightness.dark,
    //   statusBarIconBrightness: Brightness.dark
    // ));
    return Material(
      color: Colors.white,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Image.asset("assets/images/cd_image.jpeg",fit: BoxFit.cover,
            ),
            Text("Forget Your",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),),
            Text("Password?",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),),
            Text("Confirm your mobile no",
              style: TextStyle(
                fontSize: 16,
              ),),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 15.0,right: 15.0),
              child: TextFormField(
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    hintText: "Enter Mobile No",
                    labelText: "Mobile",
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
                  }
                  return null;
                },
                autofocus: false,
                keyboardType: TextInputType.number,
                controller: mobileController,
              ),
            ),
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.only(left: 16.0,right: 16.0,top: 16.0,bottom: 100.0),
              child: InkWell(
                onTap: (){
                  forgetPassword(mobileController.text.toString());
                },
                child: Ink(
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: MyTheme.skyblue,
                  ),

                  child: Center(
                    child: Text(
                      "Forget Password",
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
    );
  }
}
