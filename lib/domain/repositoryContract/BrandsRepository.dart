
import '../model/Brands.dart';
// interface
abstract class BrandsRepository {
  Future<List<Brand>?> getBrands();
}
