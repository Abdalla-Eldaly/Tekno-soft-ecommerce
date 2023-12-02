import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esayshop/domain/model/Product.dart';

class DatabaseUtils {
  static CollectionReference<Product> getProductsCollection() {
    return FirebaseFirestore.instance
        .collection("Products")
        .withConverter<Product>(
          fromFirestore: (snapshot, options) =>
              Product.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );
  }

  static Future<void> addProductToFirebase(Product product) async {
    var collection = getProductsCollection();

    var docRef = collection.doc();

    product.id = docRef.id;

    await docRef.set(product);
  }

  static Stream<QuerySnapshot<Product>> readProductsFromFirebase() {
    return getProductsCollection().snapshots();
  }

  static Future<QuerySnapshot<Product>> readProductFromFirebase(
      String id) async {
    return getProductsCollection().where('id', isEqualTo: id).get();
  }

  static Future<void> deleteProduct(String id) async {
    await getProductsCollection().doc(id).delete();
  }

  static Future<Product?> readMovieFormFirebase(String id) async {
    try {
      var snapshot = await getProductsCollection().doc(id).get();
      if (snapshot.exists) {
        return snapshot.data();
      } else {
        return null;
      }
    } catch (e) {
      print("Error reading product from Firestore: $e");
      return null;
    }
  }
}
