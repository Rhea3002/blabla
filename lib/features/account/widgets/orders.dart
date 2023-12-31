import 'package:ecomm/features/account/widgets/singleproduct.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../common/widgets/loader.dart';
import '../../../constants/global_variables.dart';
import '../../../models/order.dart';
import '../../orderdetails/orderdetails.dart';
import '../accountservices.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<Order>? orders;
  final AccountServices accountServices = AccountServices();

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orders = await accountServices.fetchMyOrders(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Text(
            "Orders",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: orders!.length == 0
          ? Center(
              child: Container(
                  child: Column(
                children: [
                  Image.asset('assets/images/noOrders.png'),
                  Text("No Orders Yet!!",
                      style: TextStyle(fontSize: 15, color: Colors.black))
                ],
              )),
            )
          // const Loader()
          : Column(
              children: [
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                        left: 15,
                      ),
                      child: const Text(
                        'Your Orders',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // Container(
                    //   padding: const EdgeInsets.only(
                    //     right: 15,
                    //   ),
                    //   child: Text(
                    //     'See all',
                    //     style: TextStyle(
                    //       color: GlobalVariables.selectedNavBarColor,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                // display orders
                Container(
                  height: 700,
                  // padding: const EdgeInsets.only(
                  //   left: 10,
                  //   top: 20,
                  //   right: 0,
                  // ),
                  child: GridView.builder(
                    itemCount: orders!.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      final orderData = orders![index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            OrderDetailScreen.routeName,
                            arguments: orderData,
                          );
                        },
                        child: SizedBox(
                          height: 200,
                          child: SingleProduct2(
                            image: orderData.products[0].images[0],
                            date: DateFormat().format(
                              DateTime.fromMillisecondsSinceEpoch(
                                  orderData.orderedAt),
                            ),
                          ),
                        ),
                      );
                      // ListView.builder(
                      //   scrollDirection: Axis.vertical,
                      //   itemCount: orders!.length,
                      //   itemBuilder: (context, index) {
                      //     return GestureDetector(
                      //       onTap: () {
                      //         Navigator.pushNamed(
                      //           context,
                      //           OrderDetailScreen.routeName,
                      //           arguments: orders![index],
                      //         );
                      //       },
                      //       child: SingleProduct(
                      //         image: orders![index].products[0].images[0],
                      //       ),
                      //     );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
