import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class WishListViewModel extends Cubit<WishListViewState> {
  @factoryMethod
  WishListViewModel() : super(UnuthetecateUserState());
}

sealed class WishListViewState {}

class UnuthetecateUserState extends WishListViewState {}
