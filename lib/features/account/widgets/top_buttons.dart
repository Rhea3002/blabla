import 'package:ecomm/features/auth/services/auth_service.dart';
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
              onTap: () {},
            ),
            AccountButton(
              text: 'Start Selling',
              onTap: () {},
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            AccountButton(
              text: 'Log Out',
              onTap: () => AuthService().logOut(context),
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