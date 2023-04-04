import 'package:flutter/material.dart';
import 'package:todo_app/data/list_product.dart';
import 'package:todo_app/screen/product_details_screen.dart';

class ProductsHome extends StatelessWidget {
  const ProductsHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: ((context, index) {
          final product = products[index];

          return Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 15,
            ),
            color: Colors.amber,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProductDetails(
                          product: product,
                        ),
                      ),
                    );
                  },
                  child: Image(
                    image: NetworkImage(
                      product['image'].toString(),
                    ),
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(product['name'].toString()),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
