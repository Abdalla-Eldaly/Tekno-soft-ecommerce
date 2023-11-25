
import 'package:esayshop/domain/model/Brands.dart';
import 'package:esayshop/domain/usecase/getProductUseCase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/model/Category.dart';
import '../../../../domain/model/Product.dart';
import '../../../../domain/usecase/getBrandsUseCase.dart';
import '../../../../domain/usecase/getCategoriesUseCase.dart';



@injectable
class HomeTabViewModel extends Cubit<HomeTabState> {
  GetCategoriesUseCase getCategoryUseCase;
  GetBrandsUseCase getBrandsUseCase;
  GetProductUseCase getProductUseCase;
  @factoryMethod
  HomeTabViewModel(this.getCategoryUseCase,this.getBrandsUseCase,this.getProductUseCase)
      : super(Loading());

  void intipage() async {
    emit(Loading());

    try {
      var categories = await getCategoryUseCase.involke();
      var brands = await getBrandsUseCase.involke();
      var products =await getProductUseCase.involke();
     // var brands = await getBrandsUseCase.involke();
      print("API Response: $categories"); // Print the response
      if (categories != null && categories.isNotEmpty) {
        emit(Success(categories,brands,products));
      } else {
        emit(Error("Empty response or null data")); // Handle empty response
      }
    } catch (e) {
      print("API Error: $e"); // Print the error
      emit(Error(e.toString()));
    }
  }
}

abstract class HomeTabState {}

class Loading extends HomeTabState {}

class Success extends HomeTabState {
  List<Category>? categories;
  List<Brand>? brands;
  List<Product>? products;
  //List<Brand>? brands;
  Success(this.categories,this.brands,this.products);
}

class Error extends HomeTabState {
  String? message;
  Error([this.message]);
}
