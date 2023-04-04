import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
  final product;
  const ProductDetails({super.key, this.product});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(widget.product['name']),
            Image(
              image: NetworkImage(widget.product['image']),
            )
          ],
        ),
      ),
    );
  }
}
