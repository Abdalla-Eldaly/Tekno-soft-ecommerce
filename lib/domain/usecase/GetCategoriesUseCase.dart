import 'package:ecommerce_c8_online/domain/model/CateogryResultDto.dart';
import 'package:ecommerce_c8_online/domain/repository/CateogoriesRepository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCategoriesUseCase{
  CategoriesRepository repository;

  GetCategoriesUseCase(this.repository);

  Future<CategoryResultDto> invoke({String? keyWord,int limit=20,int page=1}){
    return repository.getCategories();
  }
}