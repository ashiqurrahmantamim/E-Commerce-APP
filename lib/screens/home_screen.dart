import 'package:flutter/material.dart';
import 'package:food_app/controller/cart_controller.dart';
import 'package:food_app/controller/product_controller.dart';
import 'package:food_app/controller/search_controller.dart';
import 'package:food_app/database/database_helper.dart';
import 'package:food_app/local/shared_data.dart';
import 'package:food_app/model/cart_model.dart';
import 'package:food_app/screens/cart_screen.dart';
import 'package:food_app/screens/search_screen.dart';
import 'package:food_app/screens/splash_screen.dart';
import 'package:food_app/session/key_text.dart';
import 'package:food_app/utils/colors.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProductController _controller = Get.put(ProductController());
  final DBHelper dbHelper = DBHelper();
 // final SearchController _searchController = Get.put(SearchController());

  List<int> _counter = [];

  increment(int index) {
    setState(() {
      _counter[index]++;
    });
  }

  decrement(int index) {
    setState(() {
      if (_counter[index] > 0) {
        _counter[index]--;
      }
    });
  }

  String? searchValue;

  final CartProvider cart = Get.put(CartProvider());

  @override
  Widget build(BuildContext context) {
    dbHelper.getCartList();
    return Scaffold(
      bottomNavigationBar:
     FutureBuilder(
       future: cart.getCounter(),
       builder: (_,snap){
         if(snap.hasData){
           if(snap.data==0){
             return Container(height: 1,);
           }else
           return  InkWell(
             onTap: () {
               Navigator.push(
                   context, MaterialPageRoute(builder: (_) => CartScreen()));
             },
             child: Padding(
               padding: const EdgeInsets.all(12.0),
               child: Container(
                 decoration: BoxDecoration(
                   color: BG_COLOR,
                   borderRadius: BorderRadius.circular(20.0),
                 ),
                 height: 50,
                 width: double.infinity,
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Padding(
                       padding: const EdgeInsets.only(left: 18.0),
                       child: Text(
                         "Total Price  : ",
                         style: TextStyle(
                             fontSize: 20,
                             fontWeight: FontWeight.bold,
                             color: Colors.white),
                       ),
                     ),
                     FutureBuilder<double>(
                       future: cart.getTotalPrice(),
                       builder: (_, snapshot) {
                         if (snapshot.hasData) {
                           return Padding(
                             padding: const EdgeInsets.only(right: 18.0),
                             child: Text(
                               "BDT ${snapshot.data.toString()}",
                               style: TextStyle(
                                   fontSize: 20,
                                   fontWeight: FontWeight.bold,
                                   color: Colors.white),
                             ),
                           );
                         } else {
                           return Container();
                         }
                       },
                     ),
                   ],
                 ),
               ),
             ),
           );
         }else{
           return Container();
         }
       },
     ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: () async {
          var result = await    Navigator.push(
                  context, MaterialPageRoute(builder: (_) => CartScreen()));

          if(result!=null){
            if(result==true){
              dbHelper.getCartList();
              setState(() {

              });
            }
          }
            },
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 23.0, top: 16),
                  child: Icon(
                    Icons.shopping_cart,
                    size: 30,
                  ),
                ),
                FutureBuilder(
                  future: cart.getCounter(),
                  builder: (_, snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        "${snapshot.data.toString()}",
                        style: TextStyle(
                            fontSize: 19,
                            color: Colors.red,
                            fontWeight: FontWeight.w800),
                      );
                    }
                    return Container();
                  },
                ),
              ],
            ),
          ),
          IconButton(onPressed: () async{
            SharedPreferences preferences = await SharedPreferences.getInstance();
            await preferences.remove(TOKEN);
            Get.offAll(SpalashScreen());
            setState(() {

            });

          }, icon: Icon(Icons.logout),),


        ],
        backgroundColor: BG_COLOR,
        title: Text("Product"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 25, bottom: 10),
            child: Container(
              width: 370,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(
                  color: BG_COLOR, //                   <--- border color
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: TextField(
                  onTap: () {
                    Get.to(SearchScreen());
                  },
                  decoration: InputDecoration(
                      suffixIcon: Icon(Icons.search, color: BG_COLOR),
                      border: InputBorder.none,
                      hintText: "Search your product ...."),
                ),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (_controller.loader.value) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.indigo,
                  ),
                );
              } else {
                return GridView.builder(
                    itemCount: _controller.productlist.value.data!.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3 / 4,
                    ),
                    itemBuilder: (_, index) {
                      var data = _controller.productlist.value.data![index];
                      _counter.add(0);

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          color: Colors.indigo.shade50,
                          elevation: 2,
                          child: InkWell(
                            onTap: () {},
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: 8),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(13),
                                  child: Image.network(
                                    // height: MediaQuery.of(context).size.height*0.2,
                                   "https://tajabajar.s3.ap-south-1.amazonaws.com/${data.thumbnailImage.toString()}",
                                    fit: BoxFit.fill,
                                    height: 100,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Text(
                                    data.name.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.only(left: 15, top: 10),
                                  child: Text(
                                    "BDT ${data.mainPriceWu.toString()}",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                                  decrement(index);
                                                  dbHelper
                                                      .insert(Cart(
                                                    productId:
                                                    data.id.toString(),
                                                    productName: data.name,
                                                    initialPrice: data.mainPriceWu,
                                                    productPrice: data.mainPriceWu!,
                                                    quantity:
                                                    cart.getCartProductQuantity(
                                                        data.id!) -
                                                        1,
                                                    image:
                                                    data.thumbnailImage,
                                                    unit: "1"
                                                  ))
                                                      .then((valuedddd) {
                                                    cart.addTotalPrice(
                                                        data.mainPriceWu!.toDouble());
                                                    cart.addCounter();
                                                    setState(() {});
                                                  }).onError(
                                                          (error, stackTrace) {
                                                        print("Error=========");
                                                        print(
                                                            "Error ${error.toString()}");
                                                      });

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
                                              "${cart.getCartProductQuantity(data!.id!)}",
                                              style: TextStyle(
                                                  fontSize: 21,
                                                  color: Colors.blueAccent),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                increment(index);
                                                dbHelper
                                                    .insert(Cart(
                                                  productId: data.id.toString(),
                                                  productName: data.name,
                                                  initialPrice: data.mainPriceWu,
                                                  productPrice: data.mainPriceWu!,
                                                  quantity:
                                                  cart.getCartProductQuantity(
                                                      data.id!) +
                                                      1,
                                                  image: data.thumbnailImage,
                                                  unit: "",
                                                ))
                                                    .then((valuedddd) {
                                                  cart.addTotalPrice(
                                                      data.mainPriceWu!.toDouble());
                                                  cart.addCounter();
                                                  setState(() {});
                                                }).onError((error, stackTrace) {
                                                  print("Error=========");
                                                  print(
                                                      "Error ${error.toString()}");
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
                        ),
                      );
                    });
              }
            }),
          ),
        ],
      ),
    );
  }
}
