import 'package:flutter/material.dart';

import '../../models/product.dart';

class DealTile extends StatelessWidget {
  final Product product;

  const DealTile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   margin: EdgeInsets.only(left: 25),
    //   width: 200,
    //   decoration: BoxDecoration(
    //     color: Colors.black26,
    //     borderRadius: BorderRadius.circular(12),
    //   ),
    //   child: Column(
    //     children: [
    //       ClipRRect(
    //         borderRadius: BorderRadius.circular(12),
    //         //Image
    //         child: Image.network(
    //             product.images[0],
    //             fit: BoxFit.contain,
    //             height: 135,
    //             width: 135,
    //           ),
    //       ),
    //       Row(
    //         children: [
    //           Text( product.name),
    //           Text( '${product.price}'),
    //           Column(),
    //         ],
    //       ),

    //     ],
    //   ),
    // );

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Row(
            children: [
              Image.network(
                product.images[0],
                fit: BoxFit.contain,
                height: 135,
                width: 135,
              ),
              Column(
                children: [
                  Container(
                    width: 235,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: Text(
                      '\u{20B9} ${product.price}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10),
                    child: const Text('Eligible for FREE Shipping'),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: const Text(
                      'In Stock',
                      style: TextStyle(
                        color: Colors.teal,
                      ),
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
