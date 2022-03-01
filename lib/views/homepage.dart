// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, unnecessary_this, use_key_in_widget_constructors, must_be_immutable, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_mvc_api_getx_sqllite/controllers/product_controller.dart';
import 'package:flutter_mvc_api_getx_sqllite/views/cart.dart';
import 'package:flutter_mvc_api_getx_sqllite/views/product_tile.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Amazon',
          style: TextStyle(
              fontFamily: 'avenir', fontSize: 26, fontWeight: FontWeight.w800),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.favorite,
            ),
            onPressed: () {
              Get.to(Cart());
            },
          )
        ],
      ),
      body: Column(
        children: [
          Flexible(
            child: Obx(() {
              if (productController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: List.generate(
                      productController.productList.length,
                      (index) {
                        return ProductTile(
                            productController.productList[index]);
                      },
                    ));
              }
            }),
          )
        ],
      ),
    );
  }
}
