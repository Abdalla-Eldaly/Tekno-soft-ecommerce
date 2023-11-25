import 'dart:convert';
import 'package:esayshop/domain/repositoryContract/ProductRepository.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import '../model/BrandResponies/BrandsResponies.dart';
import '../model/categoryResponies/CategoryRespones.dart';
import '../model/productResponies/ProductResponies.dart';


@singleton
class ApiManager {
  static const urlBase = 'ecommerce.routemisr.com';

  Future<CategoryRespones> getCategory() async {
    var url = Uri.https(urlBase, "api/v1/categories");
    var response = await http.get(url);
    //print (jsonDecode(response.body));
    var categoriesResponse =
    CategoryRespones.fromJson(jsonDecode(response.body));
    return categoriesResponse;
  }

  Future<BrandsResponies> getBrand() async {
    var url = Uri.https(urlBase, "api/v1/brands");
    var response = await http.get(url);
    var brandsResponse =
    BrandsResponies.fromJson(jsonDecode(response.body));
    return brandsResponse;
  }
  Future<ProductResponies> getProduct({productSort? sort}) async {
    var params ={};
    if(sort != null){
      params['sort']=sort.value;
    }
    var url = Uri.https(urlBase, "api/v1/products");
    var response = await http.get(url);
    var brandsResponse =
    ProductResponies.fromJson(jsonDecode(response.body));
    return brandsResponse;
  }

}
