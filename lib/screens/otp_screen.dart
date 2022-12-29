import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app/screens/login_screen.dart';
import 'package:food_app/utils/colors.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:http/http.dart' as http;

class OTPScreen extends StatefulWidget {
  final int? userId;
  const OTPScreen({Key? key, this.userId}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  String? otp;
  bool loader = false;

  @override
  Widget build(BuildContext context) {

    print("userID__${widget.userId}");
    return Scaffold(
      appBar: AppBar(
        title: Text("OTP"),
        backgroundColor: BG_COLOR,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Your Code Sent to: ******************",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 20,
            ),
        Padding(
              padding: const EdgeInsets.all(18.0),
              child: PinFieldAutoFill(
                decoration: BoxLooseDecoration(
                    strokeColorBuilder: FixedColorBuilder(Colors.black)),
                onCodeSubmitted: (code) {},
                onCodeChanged: (code) {
                  otp = code;
                  if (code!.length == 6) {
                    FocusScope.of(context).requestFocus(FocusNode());
                  }
                },
              ),
            ),
            SizedBox(
              height: 30,
            ),
          loader ? Center(
            child: CircularProgressIndicator(),
          )  : InkWell(
              onTap: () {
                veriufication();
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 28.0, right: 28),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: 45,
                  width: double.infinity,
                  child: Text(
                    "Submit",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future veriufication() async {
    setState(() {
      loader = true;
    });
    var response = await http.post(
      Uri.parse("https://bdraj.com/api/v2/auth/confirm_code"),
      // headers: {
      //   "Accept" : "application/json"
      // },
      body: {
        "user_id": "${widget.userId}",
        "verification_code": "${otp}",
      },
    );
    if (response.statusCode == 200) {

      var message = jsonDecode(response.body);
      Fluttertoast.showToast(
          msg: "${message["message"]}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );

      setState(() {
        loader = false;

      });
      print("Success __${response.body}");

      Get.offAll(LoginScreen());
    }else{
      loader = false;
    }
  }
}
