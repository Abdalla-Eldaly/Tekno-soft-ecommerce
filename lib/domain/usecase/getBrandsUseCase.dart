
import 'package:injectable/injectable.dart';

import '../model/Brands.dart';
import '../model/Category.dart';
import '../repositoryContract/BrandsRepository.dart';
import '../repositoryContract/CategoriesRepository.dart';

@injectable
class GetBrandsUseCase {
  BrandsRepository respository;
  @factoryMethod
  GetBrandsUseCase(this.respository);

  Future<List<Brand>?> involke() {
    return respository.getBrands();
  }
}
