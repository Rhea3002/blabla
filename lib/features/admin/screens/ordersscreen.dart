import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../common/widgets/loader.dart';
import '../../../models/order.dart';
import '../../account/widgets/singleproduct.dart';
import '../../auth/services/auth_service.dart';
import '../../orderdetails/orderdetails.dart';
import '../services/admin_services.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<Order>? orders;
  final AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    final adminOrdersData = await adminServices.fetchAdminOrders(context);
    orders = adminOrdersData
        .map((orderData) => Order.fromJson(jsonEncode(orderData)))
        .toList();
    print('Orders Length: ${orders?.length}');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: orders == null
          ? Center(
              child: Container(
                  child: Column(
                children: [
                  Image.asset('assets/images/noOrders.png'),
                  Text("No Orders Yet!!",
                      style: TextStyle(fontSize: 15, color: Colors.grey))
                ],
              )),
            )
          // const Loader()
          : GridView.builder(
              itemCount: orders!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                    height: 190,
                    child: SingleProduct2(
                      image: orderData.products[0].images[0],
                      date: DateFormat().format(
                        DateTime.fromMillisecondsSinceEpoch(
                            orderData.orderedAt),
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => AuthService().logOut(context, false),
        backgroundColor: Color.fromARGB(255, 86, 221, 210),
        child: const Icon(Icons.logout),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
