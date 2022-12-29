import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app/local/shared_data.dart';
import 'package:food_app/model/login_model.dart';
import 'package:food_app/model/register_model.dart';
import 'package:food_app/screens/otp_screen.dart';
import 'package:food_app/session/key_text.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/static_text.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;
import 'package:sms_autofill/sms_autofill.dart';

import '../model/cart_model.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loader = false;
  bool isSelcted = false;
  late LoginResponse _loginRes;
  bool isLoder = false;
  bool isVisible = false;
  String ? otp;

  final TextEditingController emailOrPhone = TextEditingController();
  final TextEditingController password = TextEditingController();
  final GlobalKey<FormState> key = GlobalKey<FormState>();

  void initialize() async {

    setState(() {});
  }



  @override
  void initState() {
    initialize();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: BG_COLOR,
        title: Text("Login"),
      ),
      body:  Stack(
        children: [

          SizedBox(height: 40,),
          Container(
            width: double.infinity,
            child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 140.0, bottom: 15),
                      child: Container(
                        width: 200,
                        height: 200,
                        child: Image.asset(
                            'assets/images/logo.jpeg'),
                      ),
                    ),

                    Container(
                      // width: ScreenWidth * (3 / 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [




                          Padding(

                            padding: const EdgeInsets.only(left: 24.0,right: 24,top: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey,width: 1)
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Image.asset("assets/images/logo.jpeg",height: 30,width: 30,fit: BoxFit.contain,),
                                  ),
                                  Expanded(
                                    child: TextField(
                                      keyboardType: TextInputType.phone,

                                      controller: emailOrPhone,
                                      onSubmitted: (val){
                                        setState(() {
                                          if(emailOrPhone.value.text.length==11){
                                            FocusScope.of(context).unfocus();
                                          }
                                        });
                                      },
                                      onChanged: (val){
                                        if(emailOrPhone.value.text.length==11){
                                          FocusScope.of(context).unfocus();
                                        }
                                      },
                                      decoration: InputDecoration(

                                          contentPadding: EdgeInsets.only(top: 13,left: 12),
                                          hintText: "Enter your mobile number",
                                          helperStyle: TextStyle(fontSize: 10),
                                          hintStyle: TextStyle(color: Colors.black),
                                          suffixStyle: TextStyle(fontSize: 17,color: Colors.black),

                                          prefixIcon: Padding(
                                            padding: const EdgeInsets.only(left: 12.0,right: 8,top: 11),
                                            child: Text("+88",style: TextStyle(fontSize: 17,color: Colors.grey[800]),


                                            ),
                                          ),
                                          border: InputBorder.none

                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(height: 15,),


                          Visibility(
                            visible: isVisible ,
                            child
                                :
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: PinFieldAutoFill(

                                decoration:BoxLooseDecoration(

                                  textStyle: TextStyle(fontSize: 20, color: Colors.black),
                                  gapSpace: 10.0,
                                  strokeColorBuilder: FixedColorBuilder(Colors.black.withOpacity(0.3)),
                                ), // UnderlineDecoration, BoxLooseDecoration or BoxTightDecoration see https://github.com/TinoGuo/pin_input_text_field for more info,
                                currentCode: otp,// prefill with a code
                                onCodeSubmitted: (code){
                                  otp= code;

                                },//code submitted callback
                                onCodeChanged: (code){
                                  otp = code;
                                  //code changed callback
                                },
                                codeLength: 4,//code length, default 6
                              ),
                            ),
                          ) ,


                          SizedBox(height: 15,),


                    isLoder ?    Center(
                      child: CircularProgressIndicator(),
                    )    :  Center(
                              child: Padding(
                              padding: const EdgeInsets.only(top: 30.0),
                              child: Container(
                                height: 45,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.indigo, width: 1),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(12.0))),
                                child: ElevatedButton(

                                  child: Text(
                                    "Continue",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  onPressed: () {
                                    checkAPI();
                                  },
                                ),
                              ),
                          ),
                            )



                        ],
                      ),
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }
  Future<void> checkAPI() async {
    //EasyLoading.show(maskType: EasyLoadingMaskType.clear);
    setState(() {
      isLoder = true;
    });
    Map<String, String> jsonMap = {

      'phone': emailOrPhone.text,
      'otp' : "${isVisible ? otp : ""}",

    };

    try {
      final response = await http.post(
        Uri.parse("https://5taka.com/api/v2/phone/verify"),
        headers: {

          "Accept": "application/json",
        },
        //     encoding: Encoding.getByName("utf-8"),
        body: jsonMap,
      );

      _loginRes = loginResponseFromJson(response.body);


     print("response body....${jsonDecode(response.body)}");

      if (_loginRes.is_verified==true) {

          //     setState(() {
          //   loader=false;
          // });
        MyPrefs.setToken(_loginRes.access_token.toString());
        MyPrefs.setName(_loginRes.user!.name.toString());
        MyPrefs.setId(_loginRes.user!.id.toString());
        Get.offAll(HomeScreen());


      }else if(_loginRes.otpsent==true){

        print("response body....${_loginRes}");
        // ToastComponent.showDialog("Otp Send SuccessFully", context,
        //     gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
        // AuthHelper().setUserData(_loginRes);
        // MyPrefs.setToken(_loginRes.access_token);
        // MyPrefs.setName(_loginRes.user.name);
        setState(() {
          isLoder = false;
          isVisible=true;
        });
        MyPrefs.setToken(_loginRes.access_token.toString());
        MyPrefs.setName(_loginRes.user!.name.toString());
        MyPrefs.setId(_loginRes.user!.id.toString());
      }


      else{


        var error = json.decode(response.body);

        print("ERROR___${error['errors']['phone'][0]}");

        // ToastComponent.showDialog("${error['errors']['phone'][0]}", context,
        //     gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);

        Fluttertoast.showToast(
            msg: "${error['errors']['phone'][0]}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );


        setState(() {
          isLoder = false;
        });
      }


      print(response.body);
      // ignore: nullable_type_in_catch_clause
    } on SocketException {
      //  EasyLoading.dismiss();
    }
  }
}
