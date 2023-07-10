import 'package:ecommerce_c8_online/domain/dataSource/CategoriesOnlineDataSource.dart';
import 'package:ecommerce_c8_online/domain/model/CateogryResultDto.dart';
import 'package:ecommerce_c8_online/domain/repository/CateogoriesRepository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CategoriesRepository)
class CategoriesRepositoryImpl implements CategoriesRepository{
  CategoriesOnlineDataSource dataSource;

  CategoriesRepositoryImpl(this.dataSource);

  @override
  Future<CategoryResultDto> getCategories({String? categorySlug, int limit = 20, int page = 1}) {
    return dataSource.getCategories(categorySlug: categorySlug,
        limit: limit,page: page);
  }
}