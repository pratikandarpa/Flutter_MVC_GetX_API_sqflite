// ignore_for_file: deprecated_member_use, unnecessary_this, avoid_print

import 'package:flutter_mvc_api_getx_sqllite/db/product_database.dart';
import 'package:flutter_mvc_api_getx_sqllite/models/product.dart';
import 'package:flutter_mvc_api_getx_sqllite/services/remote_services.dart';
import 'package:get/state_manager.dart';

class ProductController extends GetxController {
  List<Welcome> productList = <Welcome>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      var products = await RemoteServices.fetchProducts();
      if (products != null) {
        productList.addAll(products);
      }
    } finally {
      isLoading(false);
    }
  }
}
