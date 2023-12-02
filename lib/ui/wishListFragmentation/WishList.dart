import 'package:esayshop/di/di.dart';
import 'package:esayshop/ui/common/loginRequired/LoginRequired.dart';
import 'package:esayshop/ui/wishListFragmentation/WishListViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../auth/login/Login.dart';

class WishListTab extends StatelessWidget {

var viewModel = getIt<WishListViewModel>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishListViewModel,WishListViewState>(
      bloc: viewModel,
        builder: (context, state) {
          switch(state){
            case UnuthetecateUserState():{
              return LoginRequired('Login', () {Navigator.pushReplacementNamed(context, Login.routeName);});
            }
          }
        },);
  }
}
//