// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison, use_key_in_widget_constructors, must_be_immutable, override_on_non_overriding_member, prefer_const_constructors_in_immutables, avoid_print, unnecessary_this

import 'package:flutter/material.dart';
import 'package:flutter_mvc_api_getx_sqllite/db/product_database.dart';
import 'package:flutter_mvc_api_getx_sqllite/models/product.dart';

class Cart extends StatefulWidget {
  Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  List<Welcome> notes = <Welcome>[];

  @override
  void initState() {
    // getNotes();
    super.initState();
  }

  Future getNotes() async {
    notes.clear();
    return await ProductDatabase.instance.readAllNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<dynamic>(
        future: getNotes(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print("GridView");
            return GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: List.generate(
                  snapshot.data.length,
                  (index) {
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
                                        snapshot.data[index].image,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                        right: 0,
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          child: IconButton(
                                            icon: Icon(Icons.favorite_rounded),
                                            onPressed: () {
                                              ProductDatabase.instance.delete(
                                                  snapshot.data[index].id);
                                              setState(() {});
                                            },
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                snapshot.data[index].title,
                                maxLines: 2,
                                style: TextStyle(
                                    fontFamily: 'avenir',
                                    fontWeight: FontWeight.w800),
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 4),
                              Text('\$${snapshot.data[index].price}',
                                  style: TextStyle(
                                      fontSize: 22, fontFamily: 'avenir')),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ));
          } else if (snapshot.hasError) {
            print("No Data Found...");
            return Text("No Data Found...");
          }
          print("Loading");
          return Text("Loading...");
        },
      ),
    );
  }
}
