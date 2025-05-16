import 'dart:convert';

import 'package:xfit_mobilna/models/product.dart';
import 'package:xfit_mobilna/providers/base_provider.dart';

class ProductProvider extends BaseProvider<Product>{
    ProductProvider(): super("Proizvod");

   @override
  Product fromJson(data) {
    // TODO: implement fromJson
    return Product.fromJson(data);
  }
}