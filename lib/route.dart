import 'package:ecomm/features/account/screens/account_screen.dart';
import 'package:ecomm/features/admin/screens/add_product_screen.dart';
//import 'package:ecomm/features/admin/screens/add_product_screen.dart';
import 'package:ecomm/features/admin/screens/admin_screen.dart';
import 'package:ecomm/features/auth/screens/auth_screen.dart';
import 'package:ecomm/features/auth/screens/register.dart';
import 'package:ecomm/features/checkout/screens/address.dart';
import 'package:ecomm/features/product_details/screens/product_details_screen.dart';
import 'package:ecomm/home/screens/homescreen.dart';
import 'package:ecomm/models/product.dart';
import 'package:flutter/material.dart';

import 'common/widgets/bottombar.dart';
import 'features/admin/screens/adminBottomNav.dart';
import 'features/checkout/screens/ordersucess.dart';
import 'features/orderdetails/orderdetails.dart';
import 'features/search/screens/search_screen.dart';
import 'home/screens/category_deals_screen.dart';
import 'models/order.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen(),
      );
    case AccountScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AccountScreen(),
      );
    case HomeScreen.routeName:
    // var product = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen(
          //  product: product,
        ),
      );
    case AdminScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings, 
        builder: (_) => const AdminScreen(), 
      );
      case RegisterScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings, 
        builder: (_) => const RegisterScreen(), 
      );
      case AddCategory.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AddCategory(),
      );
      case BottomBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => BottomBar(),
      );
      case AdminBottomBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AdminBottomBar(),
      );
      case CategoryDealsScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => CategoryDealsScreen(
          category: category,
        ),
      );
      case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SearchScreen(
          searchQuery: searchQuery,
        ),
      );
      case ProductDetailScreen.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ProductDetailScreen(
          product: product,
        ),
      );
         case OrderDetailScreen.routeName:
      var order = routeSettings.arguments as Order;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => OrderDetailScreen(
          order: order,
        ),
      );
      case DelAddressScreen.routeName: 
      var totalAmount = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => DelAddressScreen(
          totalAmount: totalAmount,
        ),
      );
      case OrderSuccess.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const OrderSuccess(),
      );
    default:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => Scaffold(
                body: Center(child: const Text("Error page")),
              ));
  }
}
