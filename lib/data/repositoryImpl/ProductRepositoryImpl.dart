
import 'package:esayshop/data/DataSouceContract/ProductDataSource.dart';
import 'package:esayshop/domain/model/Product.dart';
import 'package:esayshop/domain/repositoryContract/ProductRepository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProductRepository)
class ProductRepositoryImpl extends ProductRepository{
  ProductDataSource OnlineDateSource;
  @factoryMethod
  ProductRepositoryImpl(this.OnlineDateSource);

  @override
  Future<List<Product>?> getProduct({productSort? bySort}) {
return OnlineDateSource.getProduct(Sort: bySort);
  }


}