// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

// ignore_for_file: unnecessary_null_comparison, prefer_conditional_assignment, unnecessary_new, prefer_const_declarations

import 'dart:convert';

import 'package:get/get.dart';

List<Welcome> welcomeFromJson(String str) =>
    List<Welcome>.from(json.decode(str).map((x) => Welcome.fromJson(x)));

String welcomeToJson(List<Welcome> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Welcome {
  Welcome({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
  });

  int id;
  String title;
  double price;
  String image;

  var isFavorite = false.obs;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        id: json["id"],
        title: json["title"],
        price: json["price"].toDouble(),
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "image": image,
      };
}

class Rating {
  Rating({
    required this.rate,
    required this.count,
  });

  double rate;
  int count;

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        rate: json["rate"].toDouble(),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "rate": rate,
        "count": count,
      };
}

final String amazonCart = 'amazonCart';

class ProductFields {
  static final List<String> values = [
    /// Add all fields
    id, title, price, image
  ];

  static final String id = 'id';
  static final String title = 'title';
  static final String price = 'price';
  static final String image = 'image';
}
