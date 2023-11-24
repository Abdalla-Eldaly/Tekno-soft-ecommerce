
import '../model/Brands.dart';

abstract class BrandsRepository {
  Future<List<Brand>?> getBrands();
}
