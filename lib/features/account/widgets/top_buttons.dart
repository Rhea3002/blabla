import 'package:ecomm/features/account/widgets/orders.dart';
import 'package:ecomm/features/auth/services/auth_service.dart';
import 'package:ecomm/features/seller/screens/seller_screen.dart';
import 'package:flutter/material.dart';

import 'account_button.dart';

class TopButtons extends StatelessWidget {
  const TopButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(
              text: 'Your Orders',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Orders()),
                );
              },
            ),
            AccountButton(
                text: 'Start Selling',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SellerScreen()),
                  );
                }),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            AccountButton(
              text: 'Log Out',
              onTap: () => AuthService().logOut(context, false),
            ),
            // AccountButton(
            //   text: 'Your Wish List',
            //   onTap: () {},
            // ),
          ],
        ),
      ],
    );
  }
}
