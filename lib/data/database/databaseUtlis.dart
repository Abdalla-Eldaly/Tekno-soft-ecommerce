import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esayshop/domain/model/Product.dart';

class DatabaseUtils {
  // Get the collection reference for the "Products" collection
  static CollectionReference<Product> getProductsCollection() {
    return FirebaseFirestore.instance.collection("Products").withConverter<Product>(
      // Specify how to convert Firestore data to a Product object
      fromFirestore: (snapshot, options) => Product.fromJson(snapshot.data()!),
      // Specify how to convert a Product object to Firestore data
      toFirestore: (value, options) => value.toJson(),
    );
  }

  // Add a product to Firebase
  static Future<void> addProductToFirebase(Product product) async {
    // Get the collection reference
    var collection = getProductsCollection();

    // Create a new document reference
    var docRef = collection.doc();

    // Set the product ID to the document ID
    product.id = docRef.id;

    // Set the product data in the Firestore document
    await docRef.set(product);
  }

  // Read all products from Firebase as a stream
  static Stream<QuerySnapshot<Product>> readProductsFromFirebase() {
    return getProductsCollection().snapshots();
  }

  // Read a specific product from Firebase by ID
  static Future<QuerySnapshot<Product>> readProductFromFirebase(String id) async {
    return getProductsCollection().where('id', isEqualTo: id).get();
  }

  // Delete a product from Firebase by ID
  static Future<void> deleteProduct(String id) async {
    await getProductsCollection().doc(id).delete();
  }

  static Future<Product?> readMovieFormFirebase(String id) async {
    try {
      var snapshot = await getProductsCollection().doc(id).get();
      if (snapshot.exists) {
        return snapshot.data();
      } else {
        return null; // Product not found
      }
    } catch (e) {
      // Handle any errors that occur during the Firebase operation
      print("Error reading product from Firestore: $e");
      return null;
    }
  }}
