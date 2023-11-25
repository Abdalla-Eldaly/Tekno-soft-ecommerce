

import 'package:esayshop/data/DataSouceContract/ProductDataSource.dart';
import 'package:esayshop/domain/model/Product.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repositoryContract/ProductRepository.dart';
import '../apiManger/ApiManger.dart';

@Injectable(as: ProductDataSource)
class ProductOnlineDataSource extends ProductDataSource {
  ApiManager api_manger;
  @factoryMethod
  ProductOnlineDataSource(this.api_manger);

  @override
  Future<List<Product>?> getProduct({productSort? Sort})async {
    var response =await api_manger.getProduct();
    return response.data?.map((proDio) => proDio.toproduct()).toList();
  }





}
