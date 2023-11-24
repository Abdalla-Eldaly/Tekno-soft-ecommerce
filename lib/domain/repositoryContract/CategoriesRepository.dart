
import '../model/Category.dart';

abstract class CategoriesRepository {
  Future<List<Category>?>getCategories();
}