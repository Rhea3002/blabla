import 'package:ecomm/features/account/widgets/hello_name.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: GlobalVariables.appBarGradient,
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: Container(
                    // Image.asset(
                    //   'assets/images/amazon_in.png',
                    height: 35,
                    // color: Colors.black,
                    // Image.asset(
                    //   'assets/images/amazon_in.png',
                    child: const Text(
                      "Ecomm",
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: Icon(Icons.notifications_outlined),
                      ),
                      Icon(
                        Icons.search,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        body: const Column(
          children: [
            Username(),
            SizedBox(height: 10),
            TopButtons(),
            SizedBox(height: 20),
            //Orders(),
          ],
        ),
        floatingActionButton: ExpandableFAB(distance: 120, children: [
          ActionButton(
            icon: Icon(Icons.shopping_cart_rounded, color: Colors.white),
            onPressed: () {}
            // => AuthService().logOut(context),
          ),
          ActionButton(
            icon: Icon(Icons.person, color: Colors.white),
            onPressed: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => const AccountScreen()));
            },
          ),
          ActionButton(
              icon: Icon(Icons.home, color: Colors.white),
              onPressed: () => Navigator.pop(context),
              ),
        ]));
  }
}
