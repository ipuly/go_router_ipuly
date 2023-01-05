// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_go_router/models/product_model.dart';
import 'package:go_router/go_router.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({
    Key? key,
    required this.category,
    required this.asc,
    required this.quantity,
  }) : super(key: key);

  final String category;
  final bool asc;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    List<Product> products = Product.products
        .where(((product) => product.category == category))
        .where(((product) => product.quantity > quantity))
        .toList();

    products.sort(
      (a, b) => a.name.compareTo(b.name),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(category),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              String sort = asc ? 'asc' : 'asc';
              return context.goNamed(
                'product_list',
                params: <String, String>{'category': category},
                queryParams: <String, String>{'sort': sort},
              );
            },
            icon: const Icon(
              Icons.sort,
              size: 24.0,
            ),
          ),
          IconButton(
            onPressed: () {
              String sort = asc ? 'asc' : 'asc';
              return context.goNamed(
                'product_list',
                params: <String, String>{'category': category},
                queryParams: <String, String>{'filter': '10'},
              );
            },
            icon: const Icon(
              Icons.filter_alt,
              size: 24.0,
            ),
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          for (final Product product in asc ? products : products.reversed)
            ListTile(
              title: Text(product.name),
            )
        ],
      ),
    );
  }
}
