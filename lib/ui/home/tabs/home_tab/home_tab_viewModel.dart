
import 'package:ecommerce_c8_online/api/ApiManager.dart';
import 'package:ecommerce_c8_online/api/response/register/ServerErrorEntity.dart';
import 'package:ecommerce_c8_online/data/dataSource/CategoriesOnlineDataSourceImpl.dart';
import 'package:ecommerce_c8_online/data/repository/CateogoriesRepository.dart';
import 'package:ecommerce_c8_online/di/di.dart';
import 'package:ecommerce_c8_online/domain/customException/NetworkException.dart';
import 'package:ecommerce_c8_online/domain/customException/ServerErrorException.dart';
import 'package:ecommerce_c8_online/domain/dataSource/CategoriesOnlineDataSource.dart';
import 'package:ecommerce_c8_online/domain/model/CategoryDto.dart';
import 'package:ecommerce_c8_online/domain/model/CateogryResultDto.dart';
import 'package:ecommerce_c8_online/domain/repository/CateogoriesRepository.dart';
import 'package:ecommerce_c8_online/domain/usecase/GetCategoriesUseCase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeTabViewModel extends Cubit<HomeTabViewState>{
  GetCategoriesUseCase getCategoriesUseCase;

  HomeTabViewModel(this.getCategoriesUseCase) : super(InitialState());

  CategoryResultDto? _categoryResult;

  void getAllCategories() async {
    emit(LoadingState());
    try {
      var result = await getCategoriesUseCase.invoke();
      _categoryResult = result;
      emit(SuccessState(result.categoriesList!));
    } on ServerErrorException catch (ex) {
      emit(FailState(message: ex.errorMessage, exception: ex));
    }on NetworkException catch (ex) {
      emit(FailState(message: "please check your internet connection",exception: ex));
    }
  }
}
abstract class HomeTabViewState{}
class InitialState extends HomeTabViewState{

}
class LoadingState extends HomeTabViewState{
  String? loadingMessage;
  LoadingState({this.loadingMessage});
}
class SuccessState extends HomeTabViewState{
  List<CategoryDto> categoriesList;
  SuccessState(this.categoriesList);
}
class FailState extends HomeTabViewState{
  String? message;
  Exception? exception;
  FailState({this.message,this.exception});
}