import 'package:sqflite/sqflite.dart';

import '../../model/cart_product_model.dart';

class DBHelper {
  static late Database database;
  static String name = "CartProducts";

  static Future<void> init() async {
// Get a location using getDatabasesPath
    String path = "${await getDatabasesPath()}CartProducts.db";

// open the database
    database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        // When creating the db, create the table
        await db
            .execute('CREATE TABLE $name '
                '(id INTEGER PRIMARY KEY,'
                'name STRING,'
                'productId STRING,'
                'image STRING,'
                'price STRING,'
                'quantity INTEGER)')
            .then((value) {
          print('DataBase Created Successfully');
        });
      },
      onOpen: (db) {
        print('Database Opened Successfully');
      },
    );
  }

  static Future<void> addProduct(CartProductModel model) async {
    // Insert some records in a transaction
    await database.insert(
      name,
      model.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getAllProducts() async {
    // Insert some records in a transaction
    List<Map<String, dynamic>> list =
        await database.rawQuery('SELECT * FROM $name');
    return list;
  }

  static Future<void> deleteProduct({required int id}) async {
    await database.rawDelete('DELETE FROM $name WHERE id = ?', [id]);
  }

  static Future<void> deleteCart() async {
    await database.rawDelete('DELETE FROM $name');
    print("Data base Deleted");
  }
}
