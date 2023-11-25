import 'package:esayshop/domain/model/Product.dart';

import '../../domain/repositoryContract/ProductRepository.dart';

abstract class ProductDataSource {
  Future<List<Product>?> getProduct({productSort? Sort});
}

