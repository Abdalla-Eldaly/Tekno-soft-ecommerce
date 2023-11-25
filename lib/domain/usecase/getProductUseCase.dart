
import 'package:esayshop/domain/model/Product.dart';
import 'package:esayshop/domain/repositoryContract/ProductRepository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProductUseCase{
  ProductRepository respository;
  @factoryMethod
  GetProductUseCase(this.respository);


  Future<List<Product>?> involke(){
    return  respository.getProduct(bySort: productSort.mostSetling);
  }

}