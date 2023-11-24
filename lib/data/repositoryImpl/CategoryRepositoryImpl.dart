import 'package:injectable/injectable.dart';

import '../../domain/model/Category.dart';
import '../../domain/repositoryContract/CategoriesRepository.dart';
import '../DataSouceContract/CategoriesDataSource.dart';
@Injectable(as: CategoriesRepository)
class CategoryRepositoryImpl extends CategoriesRepository{
  CategoriesDataSource OnlineDateSource;
  @factoryMethod
  CategoryRepositoryImpl(this.OnlineDateSource);

  @override
  Future<List<Category>?> getCategories() {
    return OnlineDateSource.getCategory();
  }

}