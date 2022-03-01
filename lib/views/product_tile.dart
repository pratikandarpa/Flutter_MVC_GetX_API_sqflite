// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison, use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_mvc_api_getx_sqllite/db/product_database.dart';
import 'package:flutter_mvc_api_getx_sqllite/models/product.dart';
import 'package:get/get.dart';

class ProductTile extends StatelessWidget {
  final Welcome product;
  ProductTile(this.product);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Expanded(
                      child: Image.network(
                        product.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: Obx(() => CircleAvatar(
                            backgroundColor: Colors.white,
                            child: IconButton(
                              icon: product.isFavorite.value
                                  ? Icon(Icons.favorite_rounded)
                                  : Icon(Icons.favorite_border),
                              onPressed: () {
                                product.isFavorite.toggle();
                                if (product.isFavorite == true) {
                                  ProductDatabase.instance.create(product);
                                } else {
                                  ProductDatabase.instance.delete(product.id);
                                }
                              },
                            ),
                          )),
                    )
                  ],
                ),
              ),
              SizedBox(height: 8),
              Text(
                product.title,
                maxLines: 2,
                style: TextStyle(
                    fontFamily: 'avenir', fontWeight: FontWeight.w800),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 4),
              Text('\$${product.price}',
                  style: TextStyle(fontSize: 22, fontFamily: 'avenir')),
            ],
          ),
        ),
      ),
    );
  }
}
