import 'package:flutter/material.dart';
import 'package:food_app/model/address_model.dart';
import 'package:food_app/screens/address_screen.dart';
import 'package:food_app/screens/splash_screen.dart';
import 'package:food_app/utils/colors.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../controller/cart_controller.dart';
import '../local/shared_data.dart';
import 'order_success_page.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({Key? key}) : super(key: key);

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  AddressModel? addressModel;
  bool loader = false;

  final CartProvider cart = Get.put(CartProvider());

  String ? bkash;
  String ? Nagad;
  String ? CahsoNDelivery;

  int selectedId = 0;

  onAddressSwitch() async{
    getAddress();
    setState(() {

    });

  }

  Future<AddressModel?> getAddress() async {
    setState(() {
      loader = true;
    });
    String ? token;


    await MyPrefs.getToken().then((value) {
      setState(() {
        token = value;
      });
    });
    var response = await http
        .get(Uri.parse("https://5taka.com/api/v2/user/shipping/address"),
    headers: {
          "Authorization" : "Bearer $token"
    },
    );
    if (response.statusCode == 200) {
      setState(() {
        addressModel = addressModelFromJson(response.body);
        loader = false;
      });
    } else {
      setState(() {
        loader = false;
      });
    }
    return addressModel;
  }


  void deleteAddress(int id) async {
    String ? token;
    await MyPrefs.getToken().then((value) {
      setState(() {
        token = value;
      });
    });
    var headers = {
      'Authorization': 'Bearer $token',
    };
    var request = http.Request(
        'GET', Uri.parse('https://5taka.com/api/v2/user/shipping/delete/$id'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }



  @override
  void initState() {
    getAddress();
    super.initState();
  }

  // Future<NewAddressResponse> getAdress() async {
  //   String token;
  //   await MyPrefs.getToken().then((value) {
  //     setState(() {
  //       token = value;
  //     });
  //   });
  //   setState(() {
  //     isAdressLoader = true;
  //   });
  //   var response = await http.get(
  //     Uri.parse("https://5taka.com/api/v2/user/shipping/address"),
  //     headers: {"Authorization": "Bearer $token"},
  //   );
  //   if (response.statusCode == 200) {
  //     setState(() {
  //       _newAddressResponse = newAddressResponseFromJson(response.body);
  //       isAdressLoader = false;
  //     });
  //   } else {
  //     setState(() {
  //       isAdressLoader = false;
  //     });
  //   }
  //   return _newAddressResponse;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:   Container(
        height: 50,
          child: ElevatedButton(onPressed: (){
            dbHelper.deleteAfterCompleteOrder().then((value) => print("DELETED"));
            Get.offAll(OrderSuccessPage());
            
          }, child: Text("Submit"))),
      appBar: AppBar(
        backgroundColor: BG_COLOR,
        title: Text("Checkout page"),
      ),
      body: ListView(
        shrinkWrap: true,
        primary: false,
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Shipping Address",
                  style: TextStyle(fontSize: 18),
                ),
                InkWell(
                  onTap: () async {

                  var result = await   Get.to(NewAddAdressScreen());
                  if(result!=null){
                    if(result==true){
                      setState(() {
                        getAddress();
                      });
                    }
                  }

                  },
                  child: Text(
                    "Add Address",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          loader
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
            shrinkWrap: true,
                  primary: false,
                  itemCount: addressModel!.data!.length,
                  itemBuilder: (_, index) {
              var data = addressModel!.data![index];
                    return GestureDetector(
                      onTap: (){
                        setState(() {
                          selectedId = data.id!;
                          onAddressSwitch();
                        });

                      },
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Card(
                          color: selectedId==data.id ? Colors.red : Colors.white ,
                          elevation: 10,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 18.0,top: 10,bottom: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Row(
                                  children: [
                                    Text("  Address : ${data.address}",style: TextStyle(
                                      fontSize: 17,color: Colors.black
                                    ),),
                                    Spacer(),
                                    IconButton(onPressed: (){
                                      deleteAddress(data.id!);
                                      addressModel!.data!.removeAt(index);
                                      setState(() {

                                      });

                                    }, icon: Icon(Icons.delete)),
                                  ],
                                ),
                                SizedBox(height: 5,),
                                Text("  City : ${data.cityName}",style: TextStyle(
                                    fontSize: 17,color: Colors.black
                                ),),
                                SizedBox(height: 5,),

                                Text("  Floor No : ${data.floorNo}",style: TextStyle(
                                    fontSize: 17,color: Colors.black
                                ),),
                                SizedBox(height: 5,),


                                Text(" Name  : ${data.name}",style: TextStyle(
                                    fontSize: 17,color: Colors.black
                                ),),


                                SizedBox(height: 5,),


                                Text(" Phone Number  : ${data.phone}",style: TextStyle(
                                    fontSize: 17,color: Colors.black
                                ),),
                                SizedBox(height: 5,),

                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),


          SizedBox(height: 40,),


          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Card(
              elevation: 10,
              child: FutureBuilder(
                future: cart.getTotalPrice(),
                builder: (_,snapshoot){
                  if(snapshoot.hasData){
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Text(" Subtotal    :         ${snapshoot.data.toString()}",style: TextStyle(
                              fontSize: 20,color: Colors.black
                            ),),
                          ),
                        ),


                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Text(" Delivery Charge    :         ${30}",style: TextStyle(
                                fontSize: 20,color: Colors.black
                            ),),
                          ),
                        ),


                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Text(" Total    :         ${snapshoot.data! +30}",style: TextStyle(
                                fontSize: 20,color: Colors.black
                            ),),
                          ),
                        ),

                      ],
                    );
                  }else{
                    return Text("someting is wrong");
                  }
                },
              ),
            ),
          ),



          Column(
            children: [
              RadioListTile(
                controlAffinity: ListTileControlAffinity.leading,
                  title: Text("BKASH"),
                  value: "bkash",
                  groupValue: bkash,
                  onChanged: (val){
                    setState(() {
                      bkash = val;

                    });

                  },
              ),
              RadioListTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: Text("NAGAD"),
                value: "nagad",
                groupValue: Nagad,
                onChanged: (val){
                  setState(() {
                    Nagad = val;


                  });

                },
              ),
              RadioListTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: Text("Cash On Delivery"),
                value: "cash on delivery",
                groupValue: CahsoNDelivery,
                onChanged: (val){
                  setState(() {
                    CahsoNDelivery = val;

                  });

                },
              )
            ],
          )





        ],
      ),
    );
  }
}
