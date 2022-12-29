import 'package:flutter/material.dart';
import 'package:food_app/controller/cart_controller.dart';
import 'package:food_app/database/database_helper.dart';
import 'package:food_app/model/cart_model.dart';
import 'package:food_app/screens/checkout_screen.dart';
import 'package:food_app/utils/colors.dart';
import 'package:get/get.dart';

import '../controller/product_controller.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartProvider cartdata = Get.put(CartProvider());
  final ProductController _controller = Get.put(ProductController());
  final CartProvider cart = Get.put(CartProvider());
  DBHelper _dbHelper = DBHelper();
  List<Cart> ?dataval;
  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    cartdata.getData().then((value) {
      dataval = value;
    });
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context,true);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text("Cart Screen"),
        backgroundColor: BG_COLOR,
      ),



      body: Column(
        children: [
          Expanded(
            child:
            FutureBuilder(
              future: cartdata.getData(),
              builder: (_, snapshot) {
                return Container(
                  child: snapshot.data!.isNotEmpty ?  ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) {
                      var data = snapshot.data![index];
                      return Stack(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                            decoration: BoxDecoration(
                                color: BG_COLOR,
                                borderRadius: BorderRadius.all(Radius.circular(16))),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(
                                      right: 8, left: 8, top: 8, bottom: 8),
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(14)),
                                    color: Colors.blue.shade200,
                                    image: DecorationImage(
                                      image: NetworkImage("https://tajabajar.s3.ap-south-1.amazonaws.com/${data.image.toString()}"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.only(right: 8, top: 4),
                                          child: Text(
                                            "${data.productName}",
                                            maxLines: 2,
                                            softWrap: true,
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Text(
                                          "${data.unit}",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          ),
                                        ),
                                        Text(
                                          "BDT : ${data.productPrice}",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(top: 10),
                                              child: Container(
                                                width: 125,
                                                height: 35,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors
                                                        .blueAccent, //                   <--- border color
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                  BorderRadius.circular(10.0),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(
                                                          bottom: 9),
                                                      child: InkWell(
                                                        onTap: () {





                                                          if(snapshot.data![index].quantity! > 1){


                                                            int quantity = snapshot.data![index].quantity!;
                                                            quantity--;
                                                            _dbHelper.updateQuantity(Cart(
                                                              productId: snapshot.data![index].productId,
                                                              productName: snapshot.data![index].productName,
                                                              initialPrice: snapshot.data![index].productPrice,
                                                              productPrice: snapshot.data![index].productPrice,
                                                              quantity: quantity,
                                                              image: snapshot.data![index].image,
                                                              unit: snapshot.data![index].unit,
                                                            )).then((value) {
                                                              cart.addTotalPrice(snapshot.data![index].productPrice.toDouble());

                                                            });
                                                          }else{

                                                              _dbHelper.delete(data.productId!);

                                                              cart.removerCounter();
                                                              cart.removeTotalPrice(data.productPrice!.toDouble());
                                                              setState(() {

                                                              });


                                                          }





                                                          setState(() {});
                                                        },
                                                        child: Icon(
                                                          Icons.minimize,
                                                          size: 22,
                                                          color: Colors.blueAccent,
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      "${snapshot.data![index].quantity}",
                                                      style: TextStyle(
                                                          fontSize: 21,
                                                          color: Colors.blueAccent),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        int quantity = snapshot.data![index].quantity!;
                                                        quantity++;
                                                        _dbHelper.updateQuantity(Cart(
                                                            productId: snapshot.data![index].productId,
                                                            productName: snapshot.data![index].productName,
                                                            initialPrice: snapshot.data![index].productPrice,
                                                            productPrice: snapshot.data![index].productPrice,
                                                            quantity: quantity,
                                                            image: snapshot.data![index].image,
                                                            unit: snapshot.data![index].unit,
                                                        )).then((value) {
                                                          cart.addTotalPrice(snapshot.data![index].productPrice.toDouble());

                                                        });

                                                        setState(() {});
                                                      },
                                                      child: Icon(
                                                        Icons.add,
                                                        size: 20,
                                                        color: Colors.blueAccent,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  flex: 100,
                                )
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: (){
                             _dbHelper.delete(data.productId!);

                             cart.removerCounter();
                             cart.removeTotalPrice(data.productPrice!.toDouble());
                             setState(() {

                             });
                            },
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                width: 24,
                                height: 24,
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(right: 10, top: 8),
                                child: Icon(
                                  Icons.delete,
                                  color: Color.fromARGB(255, 247, 25, 25),
                                  size: 20,
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(4)),
                                    color: Color.fromARGB(255, 246, 244, 244)),
                              ),
                            ),
                          ),






                        ],
                      );
                    },
                  )
                  :Center(
                    child: Text("cart is empty"),
                  )
                  ,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 38.0),
            child: InkWell(
              onTap: (){

              },
              child: FutureBuilder<double>(
                future: cart.getTotalPrice(),
                builder: (_,snapshot){
                  if(snapshot.hasData){
                    return  Container(
                      // height: 50,
                      // width: double.infinity,

                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 30),
                                child: Text(
                                  "Total",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 30),
                                child: Text(
                                  "${snapshot.data.toString()}",
                                  style: TextStyle(
                                    fontSize: 22,fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          dataval!.isNotEmpty ?    ElevatedButton(
                            onPressed: () {

                              Get.to(CheckOutPage());

                            },
                            child: Text(
                              "Checkout",
                              style: TextStyle(),
                            ),
                          ) : Container(),
                          SizedBox(height: 8),
                        ],
                      ),
                      margin: EdgeInsets.only(top: 16),
                    );
                  }else{
                    return Container();
                  }
                },
              ),
            ),
          ),
        ],
      ),

    );
  }


}
