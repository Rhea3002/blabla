import 'package:ecomm/features/account/widgets/hello_name.dart';
import 'package:flutter/material.dart';
import '../widgets/orders.dart';
import '../../../common/widgets/action_button.dart';
import '../../../common/widgets/expandable.dart';
import '../../../constants/global_variables.dart';
import '../../auth/services/auth_service.dart';
import '../widgets/top_buttons.dart';

class AccountScreen extends StatefulWidget {
  static const String routeName = '/acc-screen';
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Column(
      children: [
        //Username(),
        SizedBox(height: 10),
        TopButtons(),
        SizedBox(height: 20),
        // Orders(),
      ],
      // ),
      // floatingActionButton: ExpandableFAB(distance: 120, children: [
      //   ActionButton(
      //     icon: Icon(Icons.shopping_cart_rounded, color: Colors.white),
      //     onPressed: () {}
      //     // => AuthService().logOut(context),
      //   ),
      //   ActionButton(
      //     icon: Icon(Icons.person, color: Colors.white),
      //     onPressed: () {
      //       // Navigator.push(
      //       //     context,
      //       //     MaterialPageRoute(
      //       //         builder: (context) => const AccountScreen()));
      //     },
      //   ),
      //   ActionButton(
      //       icon: Icon(Icons.home, color: Colors.white),
      //       onPressed: () => Navigator.pop(context),
      //       ),
      // ]
    ));
  }
}
