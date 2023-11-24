
import 'package:injectable/injectable.dart';

import '../../domain/model/Brands.dart';
import '../../domain/repositoryContract/BrandsRepository.dart';
import '../DataSouceContract/BrandsDataSource.dart';
@Injectable(as: BrandsRepository)
class BrandsRepositoryImpl extends BrandsRepository {

  BrandsDataSource OnlineDateSource;
  @factoryMethod
  BrandsRepositoryImpl(this.OnlineDateSource);

  @override
  Future<List<Brand>?> getBrands() {
    return OnlineDateSource.getBrands();
  }
}
