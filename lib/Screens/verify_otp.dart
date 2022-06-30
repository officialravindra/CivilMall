import 'dart:convert';

import 'package:civildeal_user_app/Screens/confirm_password.dart';
import 'package:civildeal_user_app/Services/Utilities/app_url.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import '../Utils/routs.dart';
import '../Widget/theme.dart';

class VerifyOtpPage extends StatefulWidget {
  String mobile;
  VerifyOtpPage({Key? key, required this.mobile}) : super(key: key);

  @override
  State<VerifyOtpPage> createState() => _VerifyOtpPageState(mobile);
}

class _VerifyOtpPageState extends State<VerifyOtpPage> {
  String mobile;
  _VerifyOtpPageState(this.mobile);
  final _formKey = GlobalKey<FormState>();
  TextEditingController otpController = TextEditingController();

  void verifyOtp(String mobile, otp) async{

    if(_formKey.currentState!.validate()){

      try{
        Response response = await post(
            Uri.parse(AppUrl.verifyotpLogin),
            body: {
              'mobile':mobile,
              'otp':otp,
            }
        );

        if(response.statusCode==200){
          var responseData = json.decode(response.body);


          var status= responseData["status"];
          var message= responseData["message"];



          if(status=="Success"){
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ConfirmPasswordPage(mobile: mobile),
                ));

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

        title: Text('Verify OTP',style: TextStyle(
          color: Colors.black
        ),),
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          height: double.infinity,
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(height: 60,),
              Center(
                child: Text("Enter the 4-digit code sent to",
                  style: TextStyle(
                  fontSize: 18,
                    fontWeight: FontWeight.w500
                ),),
              ),
              Center(
                child: Text("+91 "+mobile,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                  ),),
              ),
              SizedBox(height: 120,),
              Padding(
                padding: const EdgeInsets.only(left: 20.0,right: 20.0),
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      hintText: "Enter OTP",
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
                  keyboardType: TextInputType.text,
                  controller: otpController,
                ),
              ),
              SizedBox(height: 20,),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Didn't recieve the code?",
                      style: TextStyle(
                        fontSize: 16,
                      ),),
                    Text("Resend",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      ),),

                  ],
                ),
              ),
              SizedBox(height: 15,),
              Container(
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
                      verifyOtp(mobile, otpController.text.toString());
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

            ],
          ),
        ),
      ),
    );
  }
}
