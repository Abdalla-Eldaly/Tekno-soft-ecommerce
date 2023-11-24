
import 'package:injectable/injectable.dart';

import '../../domain/model/Category.dart';
import '../DataSouceContract/CategoriesDataSource.dart';
import '../apiManger/ApiManger.dart';

@Injectable(as: CategoriesDataSource)
class CategoriesOnlineDataSource extends CategoriesDataSource {
  ApiManager api_manger;
  @factoryMethod
  CategoriesOnlineDataSource(this.api_manger);
  @override
  Future<List<Category>?> getCategory() async {
    var response = await api_manger.getCategory();
    return response.data?.map((catDio) => catDio.toCategory()).toList();
  }
}
