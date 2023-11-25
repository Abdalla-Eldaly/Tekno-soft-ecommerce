import 'package:carousel_slider/carousel_slider.dart';
import 'package:esayshop/domain/model/Brands.dart';
import 'package:esayshop/domain/model/Product.dart';
import 'package:esayshop/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../di/di.dart';
import '../../../common/product/ProductWidget.dart';
import '../HomeTab/HomeTabViewModel.dart';

class ViewAll extends StatefulWidget {
  static String routeName = 'viewall';
  const ViewAll({Key? key}) : super(key: key);

  @override
  State<ViewAll> createState() => _ViewAllState();
}

class _ViewAllState extends State<ViewAll> {
  HomeTabViewModel viewModel = getIt<HomeTabViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.intipage();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeTabViewModel, HomeTabState>(
      buildWhen: (previous, current) {
        if (current is Loading) return false;
        if (current is Error) return false;
        if (current is Success) return true;
        return true;
      },
      listenWhen: (previous, current) {
        if (current is Loading) return true;
        if (current is Error) return true;
        return false;
      },
      bloc: viewModel,
      builder: (context, state) {
        if (state is Success) {
          return buildSuccessWidget(state.products);
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
      listener: (context, state) {
        if (state is Loading) {}
        if (state is Error) {}
      },
    );
  }

  Widget buildSuccessWidget(List<Product>? products) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: (products?.length ?? 0) ~/ 2, // Use integer division to get pairs
            itemBuilder: (context, index) {
              int firstIndex = index * 2;
              int secondIndex = firstIndex + 1;

              return Row(
                children: [
                  Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.45,
                      child: ProductWidget(products![firstIndex],),
                    ),
                  ),
                  const SizedBox(width: 8), // Adjust spacing as needed
                  Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.45,
                      child: ProductWidget(products![secondIndex]),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
