import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../di/di.dart';
import 'CategoryTabViewModel.dart';

@injectable
class CategoryTab extends StatefulWidget {
  const CategoryTab({Key? key}) : super(key: key);

  @override
  State<CategoryTab> createState() => _CategoryTabState();
}

class _CategoryTabState extends State<CategoryTab> {
  late CategoryTabViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = getIt<CategoryTabViewModel>();
    viewModel.intipage();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: BlocBuilder<CategoryTabViewModel, CategoryTabState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case Loading:
              return Center(child: CircularProgressIndicator());
            case Success:
              return buildSuccessUI();
            case Error:
              return buildErrorUI((state as Error).message);
            default:
              return Container();
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    viewModel.close();
    super.dispose();
  }

  Widget buildSuccessUI() {
    return Text('data');
  }

  Widget buildErrorUI(String? message) {
    return Center(
      child: Text("Error: $message"),
    );
  }
}
