import 'package:injectable/injectable.dart';

import '../../domain/model/Brands.dart';
import '../../domain/model/Category.dart';
import '../DataSouceContract/BrandsDataSource.dart';
import '../DataSouceContract/CategoriesDataSource.dart';
import '../apiManger/ApiManger.dart';

@Injectable(as: BrandsDataSource)
class BrandsOnlineDataSource extends BrandsDataSource {
  ApiManager api_manger;
  @factoryMethod
  BrandsOnlineDataSource(this.api_manger);

  @override
  Future<List<Brand>?> getBrands() async {
    var response = await api_manger.getBrand();
    return response.data?.map((brandDto) => brandDto.toBrand()).toList();
  }
}
