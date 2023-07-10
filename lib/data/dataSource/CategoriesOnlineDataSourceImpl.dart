import 'package:ecommerce_c8_online/api/ApiManager.dart';
import 'package:ecommerce_c8_online/domain/dataSource/CategoriesOnlineDataSource.dart';
import 'package:ecommerce_c8_online/domain/model/CateogryResultDto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CategoriesOnlineDataSource)
class CategoriesOnlineDataSourceImpl implements CategoriesOnlineDataSource{
  ApiManager apiManager;

  CategoriesOnlineDataSourceImpl(this.apiManager);

  @override
  Future<CategoryResultDto> getCategories({String? categorySlug,int limit = 20,int page = 1})async {
    var data = await apiManager.getCateogories(categorySlug: categorySlug,
        limit: limit,page: page);
    return CategoryResultDto(
        categoriesList: data.data?.map((entity) => entity.toCategoryDto()).toList(),
        paginationDto: data.pagination?.toPaginationDto()
    );
  }
}