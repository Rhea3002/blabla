import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../features/account/widgets/singleproduct.dart';
import '../../features/product_details/screens/product_details_screen.dart';
import '../../models/product.dart';
import '../services/home_services.dart';
import 'DealTIle.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({super.key});

  // const DealOfDay({super.key, required this.product});

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  List<Product>? productList;
  final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    fetchRecommendation();
  }

  fetchRecommendation() async {
    productList = await homeServices.fetchRecommendation(
      context: context,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 10, top: 15),
          child: const Text(
            "Deal of the day",
            style: TextStyle(fontSize: 20),
          ),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: productList!.length,
              itemBuilder: (context, index) {
                final product = productList![index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      ProductDetailScreen.routeName,
                      arguments: product,
                    );
                  },
                  child:DealTile(product: product)
    );
              }
          ),
        ),
    
      ],
    );
    //             );
    //           }),
    //     ),
    //   ],
    // );
  }
}
