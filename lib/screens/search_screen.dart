import 'package:flutter/material.dart';
import 'package:food_app/controller/search_controller.dart';
import 'package:food_app/utils/colors.dart';
import 'package:get/get.dart';

import '../controller/cart_controller.dart';
import '../database/database_helper.dart';
import '../model/cart_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final DBHelper dbHelper = DBHelper();
  final SearchController _searchController = Get.put(SearchController());


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
  final CartProvider cart = Get.put(CartProvider());

  @override
  void initState() {


    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Search"),
        backgroundColor: BG_COLOR,
      ),
      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.all(18.0),
            child: TextField(

              onChanged: (value){
                setState(() {

                  _searchController.getData(value);
                });

              },

              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Search your product ...."
              ),
            ),
          ),
          Expanded(

            child: Obx((){
              if(_searchController.searhList.value.data!=null){
                if(_searchController.loader.value){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }else{
                  return
                    _searchController.searhList.value.data!.isNotEmpty ?
                    GridView.builder(
                        itemCount: _searchController.searhList.value.data!.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 3 / 4,
                        ),
                        itemBuilder: (_, index) {
                          var data = _searchController.searhList.value.data![index];
                          _counter.add(0);


                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              elevation: 3,
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
                                        data.image!.thumbnail.toString(),
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
                                            fontSize: 15, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15, top: 10),
                                      child: Text(
                                        "BDT ${data.price.toString()}",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontSize: 15, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(left: 8.0, right: 9),
                                          child: InkWell(
                                            onTap: () {
                                              decrement(index);
                                              dbHelper
                                                  .insert(Cart(
                                                productId: data.id.toString(),
                                                productName: data.name,
                                                initialPrice: data.price,
                                                productPrice: data.price!,
                                                quantity:
                                                cart.getCartProductQuantity(data.id!) - 1,
                                                image: data.image!.thumbnail,
                                                unit: data.unit,
                                              ))
                                                  .then((valuedddd) {

                                                cart.addTotalPrice(
                                                    data.price!.toDouble());
                                                cart.addCounter();
                                                setState(() {

                                                });
                                              }).onError((error, stackTrace) {
                                                print("Error=========");
                                                print("Error ${error.toString()}");
                                              });

                                              setState(() {

                                              });
                                            },
                                            child: Container(
                                                padding: EdgeInsets.all(6),
                                                //  height: 35,
                                                // width: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: Colors.indigo,
                                                  borderRadius:
                                                  BorderRadius.circular(10.0),
                                                ),
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsets.only(bottom: 8.0),
                                                  child: Icon(
                                                    Icons.minimize,
                                                    color: Colors.white,
                                                  ),
                                                )),
                                          ),
                                        ),
                                        Text(
                                          "${cart.getCartProductQuantity(data!.id!)}",

                                          style: TextStyle(
                                              fontSize: 18, color: Colors.black),
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(left: 18.0, right: 9),
                                          child: InkWell(
                                            onTap: () {
                                              increment(index);
                                              dbHelper
                                                  .insert(Cart(
                                                productId: data.id.toString(),
                                                productName: data.name,
                                                initialPrice: data.price,
                                                productPrice: data.price!,
                                                quantity:
                                                cart.getCartProductQuantity(data.id!) + 1,
                                                image: data.image!.thumbnail,
                                                unit: data.unit,
                                              ))
                                                  .then((valuedddd) {

                                                cart.addTotalPrice(
                                                    data.price!.toDouble());
                                                cart.addCounter();
                                                setState(() {

                                                });
                                              }).onError((error, stackTrace) {
                                                print("Error=========");
                                                print("Error ${error.toString()}");
                                              });

                                              setState(() {

                                              });
                                            },
                                            child: Container(
                                                padding: EdgeInsets.all(6),
                                                //  height: 35,
                                                // width: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: Colors.indigo,
                                                  borderRadius:
                                                  BorderRadius.circular(10.0),
                                                ),
                                                child: Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                )),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );



                        }) : Padding(
                      padding: const EdgeInsets.only(top: 118.0),
                      child: Center(
                        child: Text("No Product Found",style: TextStyle(
                            fontSize: 25,
                            color: Colors.black
                        ),),
                      ),
                    );
                }
              }else{
                return Center(
                  child: Text("Please seach product",style: TextStyle(
                      fontSize: 25,
                      color: Colors.black
                  ),),
                );
              }

            }),
          ),
        ],
      ),
    );
  }
}
