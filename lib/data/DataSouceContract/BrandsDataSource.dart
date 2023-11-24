import 'package:injectable/injectable.dart';

import '../../domain/model/Brands.dart';
abstract class BrandsDataSource {
  Future<List<Brand>?> getBrands();
}
