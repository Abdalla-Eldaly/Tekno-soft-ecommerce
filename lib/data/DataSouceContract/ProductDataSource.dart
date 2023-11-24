import 'package:ecommerce_c8_online/domain/model/Product.dart';

import '../../domain/repositoryContract/ProductRepository.dart';

abstract class ProductDataSource {
  Future<List<Product>?> getProduct({productSort? Sort});
}

