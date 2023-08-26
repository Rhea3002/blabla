import 'package:ecomm/features/checkout/screens/payment.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

import '../../../common/widgets/custom_button.dart';
import '../../../constants/global_variables.dart';
import '../../../providers/user_provider.dart';
import '../services/addressservices.dart';

class DelAddressScreen extends StatefulWidget {
  static const String routeName = '/address';
  final String totalAmount;
  const DelAddressScreen({
    Key? key,
    required this.totalAmount,
  }) : super(key: key);

  @override
  State<DelAddressScreen> createState() => _DelAddressScreenState();
}

class _DelAddressScreenState extends State<DelAddressScreen> {
  String address = '';
  double sum = 0;
  List<PaymentItem> paymentItems = [];
  final AddressServices addressServices = AddressServices();

  @override
  void initState() {
    super.initState();
    paymentItems.add(
      PaymentItem(
        amount: widget.totalAmount,
        label: 'Total Amount',
        status: PaymentItemStatus.final_price,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    paymentItems.add(
      PaymentItem(
        amount: widget.totalAmount,
        label: 'Total Amount',
        status: PaymentItemStatus.final_price,
      ),
    );
  }

  void onGooglePayResult(res) {
    //  if (Provider.of<UserProvider>(context, listen: false).user.address.isEmpty)
    addressServices.placeOrder(
      context: context,
      totalSum: double.parse(widget.totalAmount),
    );
  }

  void PayPressed() {
    addressServices.placeOrder(
      context: context,
      totalSum: double.parse(widget.totalAmount),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    address = user.address;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(20),
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30), //border corner radius
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5), //color of shadow
                  spreadRadius: 5, //spread radius
                  blurRadius: 7, // blur radius
                  offset: Offset(0, 2), // changes position of shadow
                  //first paramerter of offset is left-right
                  //second parameter is top to down
                ),
                //you can set more BoxShadow() here
              ],
            ),
            child: Text(
              "$address",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          // GooglePayButton(
          //   width: double.infinity,

          //   // onPressed: () => payPressed(),
          //   paymentConfigurationAsset: 'gpay.json',
          //   onPaymentResult: onGooglePayResult,
          //   paymentItems: paymentItems,
          //   height: 50,
          //   //style: GooglePayButtonStyle.black,
          //   type: GooglePayButtonType.buy,
          //   margin: const EdgeInsets.only(top: 15),
          //   loadingIndicator: const Center(
          //     child: CircularProgressIndicator(),
          //   ),
          // ),
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButton(
              text: 'Cash on Delivery',
              onTap: () => PayPressed(),
              color: Colors.yellow[600],
            ),
          ),
        ],
      ),
    );
  }
}
