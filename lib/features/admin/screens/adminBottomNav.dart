import 'package:ecomm/features/admin/screens/admin_screen.dart';
import 'package:ecomm/features/admin/screens/analysisscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/global_variables.dart';
import '../../../providers/user_provider.dart';
import '../../account/screens/account_screen.dart';
import 'ordersscreen.dart';

class AdminBottomBar extends StatefulWidget {
  static const String routeName = '/admin-home';
  const AdminBottomBar({Key? key}) : super(key: key);

  @override
  State<AdminBottomBar> createState() => _AdminBottomBarState();
}

class _AdminBottomBarState extends State<AdminBottomBar> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;
  String username = '';

  void navigateToCartTab() {
    setState(() {
      _page = 0; // Set the active tab index to 2 (Cart)
    });
  }

  List<Widget> pages = [
    const AdminScreen(),
    const AnalysisScreen(),
    const OrdersScreen(),
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    username = user.name;
    //final userCartLen = context.watch<UserProvider>().user.cart.length;
    // final args = ModalRoute.of(context)!.settings.arguments;
    // if (args != null) {
    //   _page = args as int;
    // }

    return Scaffold(
      //-----------------------APPBAR--------------------------
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
              // Container(
              //   alignment: Alignment.topLeft,
              //   child: Text()
              // ),
              Text(
                "Hello $username",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
      //------------------------APPBAR OVER-----------------
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        onTap: updatePage,
        items: [
          // HOME
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 0
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: const Icon(
                Icons.home_outlined,
              ),
            ),
            label: '',
          ),
          // ACCOUNT
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 1
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: const Icon(
                Icons.analytics,
              ),
            ),
            label: '',
          ),
          // CART
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 2
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: const Icon(
                Icons.person_3_rounded,
              ),
            ),
            label: '',
          ),
        ],
      ),
    );
    //           ));
    // });
  }
}
