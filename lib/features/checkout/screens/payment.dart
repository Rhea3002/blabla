import 'package:ecomm/features/checkout/services/addressservices.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

import '../../../constants/global_variables.dart';
import '../../../providers/user_provider.dart';

class PaymentScreen extends StatefulWidget {
   final String totalAmount;
   const PaymentScreen({
    Key? key,
    required this.totalAmount,
  }) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
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
  }

   void onGooglePayResult(res) {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) 
    addressServices.placeOrder(
      context: context,
    
      totalSum: double.parse(widget.totalAmount),
    );
  }



    
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
      body: Center(child:  GooglePayButton(
                // onPressed: () => payPressed(),
                paymentConfigurationAsset: 'gpay.json',
                onPaymentResult: onGooglePayResult,
                paymentItems: paymentItems,
                height: 50,
               // style: GooglePayButtonStyle.black,
                type: GooglePayButtonType.buy,
                margin: const EdgeInsets.only(top: 15),
                loadingIndicator: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),),
    );
  }
}