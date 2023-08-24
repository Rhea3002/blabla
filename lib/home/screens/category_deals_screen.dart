import 'package:ecomm/features/admin/screens/add_product_screen.dart';
import 'package:ecomm/home/services/home_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../common/widgets/loader.dart';
import '../../constants/global_variables.dart';
import '../../features/account/widgets/singleproduct.dart';
import '../../features/product_details/screens/product_details_screen.dart';
import '../../models/product.dart';

class CategoryDealsScreen extends StatefulWidget {
  static const String routeName = '/category-deals';
  final String category;
  const CategoryDealsScreen({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override 
  State<CategoryDealsScreen> createState() => _CategoryDealsScreenState();
}

class _CategoryDealsScreenState extends State<CategoryDealsScreen> {
  List<Product>? productList;
  final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    fetchCategoryProducts();
  }

  fetchCategoryProducts() async {
    productList = await homeServices.fetchCategoryProducts(
      context: context,
      category: widget.category,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Text(
            'Keep shopping for ${widget.category}',
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: productList == null
          ? const Loader()
          :
          // Column(
          //     children: [
          //       Container(
          //         padding:
          //             const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          //         alignment: Alignment.topLeft,
          //         child: Text(
          //           'Keep shopping for ${widget.category}',
          //           style: const TextStyle(
          //             fontSize: 20,
          //           ),
          //         ),
          //       ),])
          // SizedBox(
          //   height: 170,
          //   child: GridView.builder(
          //     scrollDirection: Axis.horizontal,
          //     padding: const EdgeInsets.only(left: 15),
          //     itemCount: productList!.length,
          //     gridDelegate:
          //         const SliverGridDelegateWithFixedCrossAxisCount(
          //       crossAxisCount: 1,
          //       childAspectRatio: 1.4,
          //       mainAxisSpacing: 10,
          //     ),
          //     itemBuilder: (context, index) {
          //       final product = productList![index];
          //       return GestureDetector(
          //         onTap: () {
          //           Navigator.pushNamed(
          //             context,
          //             ProductDetailScreen.routeName,
          //             arguments: product,
          //           );
          //         },
          //         child: Column(
          //           children: [
          //             SizedBox(
          //               height: 130,
          //               child: DecoratedBox(
          //                 decoration: BoxDecoration(
          //                   border: Border.all(
          //                     color: Colors.black12,
          //                     width: 0.5,
          //                   ),
          //                 ),
          //                 child: Padding(
          //                   padding: const EdgeInsets.all(10),
          //                   child: Image.network(
          //                     product.images[0],
          //                   ),
          //                 ),
          //               ),
          //             ),
          //             Container(
          //               alignment: Alignment.topLeft,
          //               padding: const EdgeInsets.only(
          //                 left: 0,
          //                 top: 5,
          //                 right: 15,
          //               ),
          //               child: Text(
          //                 product.name,
          //                 maxLines: 1,
          //                 overflow: TextOverflow.ellipsis,
          //               ),
          //             ),
          //           ],
          //         ),
          //       );
          //     },
          //   ),
          // ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                itemCount: productList!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
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
                    child: Column(
                      children: [
                        SizedBox(
                          height: 140,
                          child: SingleProduct(
                            image: product.images[0],
                          ),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    product.name,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ),
                              Text('\u{20B9}${NumberFormat('#,###').format(product.price.toInt())}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16
                                  )),
                            ])
                      ],
                    ),
                  );
                },
              ),
            ),
      //   ],
    );
  }
}
