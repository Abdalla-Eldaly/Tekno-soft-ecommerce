import 'package:injectable/injectable.dart';

import '../model/Category.dart';
import '../repositoryContract/CategoriesRepository.dart';
@injectable
class GetCategoriesUseCase{
  CategoriesRepository respository;
 @factoryMethod
 GetCategoriesUseCase(this.respository);

  Future<List<Category>?> involke(){
    return  respository.getCategories();
  }


}