import 'dart:convert';

import 'package:xfit_admin/models/product.dart';
import 'package:xfit_admin/providers/base_provider.dart';

class ProductProvider extends BaseProvider<Product>{
    ProductProvider(): super("Proizvod");

   @override
  Product fromJson(data) {
    // TODO: implement fromJson
    return Product.fromJson(data);
  }
}