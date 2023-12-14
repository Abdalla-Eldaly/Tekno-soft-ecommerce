
import 'package:esayshop/domain/model/Brands.dart';
import 'package:esayshop/domain/usecase/getProductUseCase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/model/Category.dart';
import '../../../../domain/model/Product.dart';
import '../../../../domain/usecase/getBrandsUseCase.dart';
import '../../../../domain/usecase/getCategoriesUseCase.dart';



@injectable
class CategoryTabViewModel extends Cubit<CategoryTabState> {
  GetCategoriesUseCase getCategoryUseCase;
  GetBrandsUseCase getBrandsUseCase;
  GetProductUseCase getProductUseCase;
  @factoryMethod
  CategoryTabViewModel(this.getCategoryUseCase,this.getBrandsUseCase,this.getProductUseCase)
      : super(Loading());

  void intipage() async {
    emit(Loading());

    try {
      var categories = await getCategoryUseCase.involke();

      print("API Response: $categories"); // Print the response
      if (categories != null && categories.isNotEmpty) {
        emit(Success(categories));
      } else {
        emit(Error("Empty response or null data")); // Handle empty response
      }
    } catch (e) {
      print("API Error: $e"); // Print the error
      emit(Error(e.toString()));
    }
  }
}

abstract class CategoryTabState {}

class Loading extends CategoryTabState {}

class Success extends CategoryTabState {
  List<Category>? categories;
  //List<Brand>? brands;
  Success(this.categories);
}

class Error extends CategoryTabState {
  String? message;
  Error([this.message]);
}
