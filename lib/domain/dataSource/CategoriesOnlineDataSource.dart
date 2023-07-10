import 'package:ecommerce_c8_online/domain/model/CateogryResultDto.dart';

abstract class CategoriesOnlineDataSource{
  Future<CategoryResultDto> getCategories({String? categorySlug,int limit = 20,int page = 1});
}