import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:food_app/local/shared_data.dart';
import 'package:food_app/session/key_text.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;

import '../controller/cart_controller.dart';
import '../model/country_model.dart';
import '../utils/colors.dart';


class NewAddAdressScreen extends StatefulWidget {

  @override
  _NewAddAdressScreenState createState() => _NewAddAdressScreenState();
}

class _NewAddAdressScreenState extends State<NewAddAdressScreen> {

  TextEditingController _addressController = TextEditingController();
  // TextEditingController _postalCodeController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  // TextEditingController _cityController = TextEditingController();
  // TextEditingController _stateController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController apertmentController = TextEditingController();
  TextEditingController nameController = TextEditingController();


  var  selectedArea;
  CountryResponse  ?_countryResponse;


  bool isAdressLoader = false;

  Future<CountryResponse?> getArea() async {
    String ? token;


     await  MyPrefs.getToken().then((value) {
        setState(() {
          token = value;
        });
      });


    setState(() {
      isAdressLoader = true;
    });
    var response = await http.get(
      Uri.parse("https://5taka.com/api/v2/states"),
      headers: {"Authorization": "Bearer $token"},
    );
    if (response.statusCode == 200) {
      setState(() {
        _countryResponse = countryResponseFromJson(response.body);
        isAdressLoader = false;
      });
    } else {
      setState(() {
        isAdressLoader = false;
      });
    }
    return _countryResponse;
  }
  bool isLoader = false;
  addAddress ()async{

    String ? token;
    String ? id;


   await MyPrefs.getToken().then((value) {
      setState(() {
        token = value;
      });
    });
    await MyPrefs.getId().then((value) {
      setState(() {
        id = value;
      });
    });

    print("ID===== __${id}");
    print("TOken __${token}");
    setState(() {
      isLoader=true;
    });
    var headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",


    };
    var request = http.Request('POST', Uri.parse('https://5taka.com/api/v2/user/shipping/create'));
    request.body = json.encode({
      "user_id": "${id}",
      "address": "${_addressController.text}",
      "area": selectedArea,
      "floor_no": "${floorController.text}",
      "apartment": "${apertmentController.text}",
      "name": "${nameController.text}",
      "phone": "${_phoneController.text}"
    });
    request.headers.addAll(headers);
    print("body__${request.body}");
    print("body__$token");
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      Navigator.pop(context,true);
      isLoader=false;


    }
    else {
      setState(() {
        isLoader= false;
      });
      print(response.reasonPhrase);
    }

  }

  @override
  void initState() {
    getArea();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: BG_COLOR,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Add Address",style: TextStyle(fontSize: 16,color: Colors.white),),
      ),
      body:       Padding(
        padding: const EdgeInsets.all(28.0),
        child: Container(
          //    width: 400,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                      "Address",
),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Container(
                    height: 55,
                    child: TextField(
                      controller: _addressController,
                      autofocus: false,
                      keyboardType: TextInputType.multiline,


                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                      "Area",

                  ),
                ),
                SizedBox(height: 10,),

                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Container(
                    height: 50,
                    child:
                    _countryResponse==null ? Container() :    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(color: Colors.grey,)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 6.0),
                        child: Container(
                            height: 85,
                            child:
                            DropdownButtonHideUnderline(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: DropdownButton(
                                  hint: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text("Select your Area"),
                                  ),
                                  isExpanded: true,
                                  onChanged: (val){
                                    setState(() {
                                      selectedArea=val;
                                    });
                                  },
                                  value: selectedArea,
                                  items:  _countryResponse!.data!.map((e) {

                                    return DropdownMenuItem(
                                      value: e.id,

                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 18.0),
                                        child: Text(e.name.toString()),
                                      ),

                                    );

                                  }).toList() ,
                                ),
                              ),
                            )



                        ),
                      ),
                    ),
                  ),
                ),

SizedBox(height: 10,),

                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                      "Floor No",
),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Container(
                    height: 55,
                    child: TextField(
                      controller:floorController ,
                      autofocus: false,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,

                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                      "Apartment",
                      ),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Container(
                    height: 55,
                    child: TextField(
                      controller: apertmentController,
                      autofocus: false,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,

                    ),
                  ),
                ),



                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                      "Name",
             ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Container(
                    height: 40,
                    child: TextField(
                      controller:nameController,
                      autofocus: false,

                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                   "Phone"),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Container(
                    height: 40,
                    child: TextField(
                      controller: _phoneController,
                      autofocus: false,

                    ),
                  ),
                ),

                SizedBox(height: 20,),
                isLoader ? Center(child: CircularProgressIndicator(color:Colors.indigo),)   :   Center(
                  child: ElevatedButton(

                    child: Text(
                      "OK",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    onPressed: () {
                      addAddress();




                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
