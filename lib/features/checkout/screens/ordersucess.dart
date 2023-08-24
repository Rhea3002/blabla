import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../../common/widgets/bottombar.dart';
import '../../../common/widgets/custom_button.dart';
import '../../../constants/global_variables.dart';
import '../../../models/order.dart';
import '../../../providers/user_provider.dart';
import '../../admin/services/admin_services.dart';

import '../../search/screens/search_screen.dart';

class OrderSuccess extends StatefulWidget {
  static const String routeName = '/order-success';
  // final Order order;
  const OrderSuccess({
    Key? key, 
    //  required this.order,
  }) : super(key: key);

  @override
  State<OrderSuccess> createState() => _OrderSuccessState();
}

class _OrderSuccessState extends State<OrderSuccess> {
  //int currentStep = 0;
 // final AdminServices adminServices = AdminServices();

  // void navigateToSearchScreen(String query) {
  //   Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<UserProvider>(context).user;
//  final orderDetails =
//         ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
//     final orderId = orderDetails['orderId'];
//     final totalPrice = orderDetails['totalPrice'];
//     final products = orderDetails['products'];
//     final orderedAt = orderDetails['orderedat'];
    return Scaffold(
     
      body: SafeArea(
        child: Center(
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Order Successful',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30),
                child: Image.asset(
                  'assets/images/success.jpeg',
                  height: 150,
                  width: 150,
                ),
                // Lottie.asset('locked.png'),
              ),
              const SizedBox(height: 10),
              Text('Please check Orders page to view Order details',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black87
              ),)
              ,
                  Align(
                    alignment: AlignmentDirectional.bottomEnd,
                    child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CustomButton(
                                text: "Ready for Round Two? Shop More!",
                                onTap: () {
                                  Navigator.pushNamed(context, BottomBar.routeName );
                                },
                                color: Colors.yellow[600],
                              ),
                            ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
