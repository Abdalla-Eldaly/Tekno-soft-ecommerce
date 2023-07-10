import 'package:ecommerce_c8_online/di/di.dart';
import 'package:ecommerce_c8_online/ui/components/GenericErrorWidget.dart';
import 'package:ecommerce_c8_online/ui/components/IniniteLoadingWidget.dart';
import 'package:ecommerce_c8_online/ui/home/tabs/home_tab/category_section/categories_section.dart';
import 'package:ecommerce_c8_online/ui/home/tabs/home_tab/home_tab_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeTab extends StatefulWidget {
  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  HomeTabViewModel viewModel = getIt<HomeTabViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.getAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeTabViewModel, HomeTabViewState>(
      bloc: viewModel,
      builder: (context, state) {
        if(state is LoadingState ){
          return InifiniteLoadingWidget(state.loadingMessage??"");
        } if(state is InitialState ){
          return InifiniteLoadingWidget("");
        }
        else if(state is SuccessState){
          // show categories
          return CategoriesSection(state.categoriesList);
        }
        else if(state is FailState){
          return GenericErrorWidget(
              state.message??state.exception.toString()??"");
        }
        return Container();
      },
      listener: (context, state) {

      },
    );
  }
}
