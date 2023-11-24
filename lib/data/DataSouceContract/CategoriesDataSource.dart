

import 'package:injectable/injectable.dart';

import '../../domain/model/Category.dart';

abstract class CategoriesDataSource{

  Future<List<Category>?> getCategory();
}