import 'package:ecommerce_c8_online/domain/model/Product.dart';

abstract class ProductRepository {
  Future<List<Product>?> getProduct({productSort? bySort});
}

enum productSort {
  LowestPrice('price'),
  highestPrice('-price'),
  mostSetling("-sold");

  final String value;
  const productSort(this.value);
}
