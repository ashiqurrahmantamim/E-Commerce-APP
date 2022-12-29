import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../main.dart';
import '../model/cart_model.dart';
import '../screens/home_screen.dart';
import '../screens/splash_screen.dart';


class DBHelper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db!;
    }

    _db = await initDatabase();
    return _db;
  }

  initDatabase() async {

    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'cart.db');
    var db = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
    return db;
  }

  _onCreate (Database db , int version )async{
    await db.execute(
        'CREATE TABLE cart (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL , productId VARCHAR UNIQUE,productName TEXT,initialPrice INTEGER, productPrice INTEGER , quantity INTEGER , image TEXT,unit TEXT,deliveryTime TEXT,possibleMin INTEGER )');
  }


  Future<Cart> insert(Cart cart) async {
    print(cart.toMap());
    if (cart.quantity! <= 0) {
      await delete(cart.productId!);
      await getCartList();
      return cart;
    } else {
      var dbClient = await db;

      try {
        await dbClient!.insert('cart', cart.toMap());
      } catch (e) {

        updateQuantity(cart);
      }
      await getCartList();
      return cart;
    }
  }

  Future<bool> isCardProduct(String? productid)async{
    var dbClient = await db ;
    final List<Map<String , Object?>> queryResult =  await dbClient!.query('cart',columns: ["productId"],where: 'productId=?', whereArgs: [productid!]);
    return queryResult.length>0;
  }

  Future<bool> deleteAfterCompleteOrder() async {
    int? res = 0;
    var dbClient = await db;
    res = await dbClient?.delete("cart");
    return res! > 0;
  }

  Future<List<Cart>> getCartList() async {
    var dbClient = await db;
    final List<Map<String, Object?>> queryResult =
    await dbClient!.query('cart');

    availabeCart =   queryResult.map((e) => Cart.fromMap(e)).toList();
    return availabeCart;

    // availableCart = queryResult.map((e) => Cart.fromMap(e)).toList();
    // return availableCart;
  }

  Future<int> delete(String id) async {
    var dbClient = await db;
    return await dbClient!
        .delete('cart', where: 'productId = ?', whereArgs: [id]);
  }


  Future<int> updateQuantity(Cart cart) async {
    var dbClient = await db;
    return await dbClient!.update('cart', cart.toMap(),
        where: 'productId = ?', whereArgs: [cart.productId]);
  }


  closeDB() async {
    final db = await _db;
    await db!.close();
  }

  Future<void> _deleteCacheDir() async {
    var tempDir = await getTemporaryDirectory();

    if (tempDir.existsSync()) {
      tempDir.deleteSync(recursive: true);
    }
  }

  Future<void> deleteAppDir() async {
    var appDocDir = await getApplicationDocumentsDirectory();

    if (appDocDir.existsSync()) {
      appDocDir.deleteSync(recursive: true);
    }
  }
}
