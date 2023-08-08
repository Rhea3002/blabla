import 'package:ecomm/features/account/screens/account_screen.dart';
import 'package:ecomm/features/admin/screens/add_product_screen.dart';
//import 'package:ecomm/features/admin/screens/add_product_screen.dart';
import 'package:ecomm/features/admin/screens/admin_screen.dart';
import 'package:ecomm/features/auth/screens/auth_screen.dart';
import 'package:ecomm/features/product_details/screens/product_details_screen.dart';
import 'package:ecomm/home/screens/homescreen.dart';
import 'package:ecomm/models/product.dart';
import 'package:flutter/material.dart';

import 'features/search/screens/search_screen.dart';
import 'home/screens/category_deals_screen.dart';

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
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen(),
      );
    case AdminScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AdminScreen(),
      );
      case AddCategory.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AddCategory(),
      );
      // case AddProductScreen.routeName:
      // return MaterialPageRoute(
      //   settings: routeSettings,
      //   builder: (_) => AddProductScreen(category: category,),
      // );
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
    default:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => Scaffold(
                body: Center(child: const Text("Error page")),
              ));
  }
}
