import 'package:ecommerce_c8_online/domain/model/CategoryDto.dart';
import 'package:ecommerce_c8_online/domain/model/PaginationDto.dart';

class CategoryResultDto{
  PaginationDto? paginationDto;
  List<CategoryDto>? categoriesList;
  CategoryResultDto({this.categoriesList,this.paginationDto});
}
