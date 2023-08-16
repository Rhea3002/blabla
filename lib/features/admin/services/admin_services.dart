import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:ecomm/features/admin/screens/admin_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../../constants/error_handling.dart';
import '../../../constants/global_variables.dart';
import '../../../constants/utils.dart';
import '../../../models/order.dart';
import '../../../models/product.dart';
import '../../../providers/user_provider.dart';

class AdminServices {
  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double ram,
    required double rom,
    required String screentech,
    required String os,
    required double quantity,
    required String category,
    required List<File> images,
    required List<String> keywordlist,
    required String userId,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      final cloudinary = CloudinaryPublic('dzbnjysjj', 'hxsmg8kf');
      List<String> imageUrls = [];

      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: name),
        );
        imageUrls.add(res.secureUrl);
      }

      Product product = Product(
        name: name,
        description: description,
        quantity: quantity,
        images: imageUrls,
        category: category,
        price: price,
        ram: ram,
        rom: rom,
        screentech: screentech,
        os: os,
        keywordlist: keywordlist,
        userId: userId,
      );

      http.Response res = await http.post(
        Uri.parse('$uri/admin/add-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: product.toJson(),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Product Added Successfully!');
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AdminScreen()));
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // get all the products
  // Future<List<Product>> fetchAllProducts(BuildContext context) async {
  //   final userProvider = Provider.of<UserProvider>(context, listen: false);
  //   List<Product> productList = [];
  //   try {
  //     http.Response res =
  //         await http.get(Uri.parse('$uri/admin/get-products'), headers: {
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       'x-auth-token': userProvider.user.token,
  //     });

  //     httpErrorHandle(
  //       response: res,
  //       context: context,
  //       onSuccess: () {
  //         for (int i = 0; i < jsonDecode(res.body).length; i++) {
  //           productList.add(
  //             Product.fromJson(
  //               jsonEncode(
  //                 jsonDecode(res.body)[i],
  //               ),
  //             ),
  //           );
  //         }
  //       },
  //     );
  //   } catch (e) {
  //     showSnackBar(context, e.toString());
  //   }
  //   return productList;
  // }

  //NEWLY ADDED______________________________________________________________________________________________________
  Future<List<Product>> fetchAllProducts(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];

    try {
      http.Response res =
          await http.get(Uri.parse('$uri/admin/get-products'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          final productsDataList = jsonDecode(res.body) as List<dynamic>;

          for (int i = 0; i < productsDataList.length; i++) {
            final productData = productsDataList[i] as Map<String, dynamic>;
            if (productData['userId'] == userProvider.user.email) {
              final productJson =
                  jsonEncode(productData); // Convert Map to JSON string
              productList.add(Product.fromJson(
                  productJson)); // Pass JSON string to fromJson
            }
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }

    return productList;
  }

//______________________________________________________________________________________________________________________

  void deleteProduct({
    required BuildContext context,
    required Product product,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/admin/delete-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id,
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          onSuccess();
          showSnackBar(context, 'Product Deleted Successfully!');
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}

Future<List<Order>> fetchAllOrders(BuildContext context) async {
  final userProvider = Provider.of<UserProvider>(context, listen: false);
  List<Order> orderList = [];
  try {
    http.Response res =
        await http.get(Uri.parse('$uri/admin/get-orders'), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'x-auth-token': userProvider.user.token,
    });

    httpErrorHandle(
      response: res,
      context: context,
      onSuccess: () {
        for (int i = 0; i < jsonDecode(res.body).length; i++) {
          orderList.add(
            Order.fromJson(
              jsonEncode(
                jsonDecode(res.body)[i],
              ),
            ),
          );
        }
      },
    );
  } catch (e) {
    showSnackBar(context, e.toString());
  }
  return orderList;
}
//--------------------------

void changeOrderStatus({
  required BuildContext context,
  required int status,
  required Order order,
  required VoidCallback onSuccess,
}) async {
  final userProvider = Provider.of<UserProvider>(context, listen: false);

  try {
    http.Response res = await http.post(
      Uri.parse('$uri/admin/change-order-status'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      },
      body: jsonEncode({
        'id': order.id,
        'status': status,
      }),
    );

    httpErrorHandle(
      response: res,
      context: context,
      onSuccess: onSuccess,
    );
  } catch (e) {
    showSnackBar(context, e.toString());
  }
}

//   Future<Map<String, dynamic>> getEarnings(BuildContext context) async {
//     final userProvider = Provider.of<UserProvider>(context, listen: false);
//     List<Sales> sales = [];
//     int totalEarning = 0;
//     try {
//       http.Response res =
//           await http.get(Uri.parse('$uri/admin/analytics'), headers: {
//         'Content-Type': 'application/json; charset=UTF-8',
//         'x-auth-token': userProvider.user.token,
//       });

//       httpErrorHandle(
//         response: res,
//         context: context,
//         onSuccess: () {
//           var response = jsonDecode(res.body);
//           totalEarning = response['totalEarnings'];
//           sales = [
//             Sales('Mobiles', response['mobileEarnings']),
//             Sales('Essentials', response['essentialEarnings']),
//             Sales('Books', response['booksEarnings']),
//             Sales('Appliances', response['applianceEarnings']),
//             Sales('Fashion', response['fashionEarnings']),
//           ];
//         },
//       );
//     } catch (e) {
//       showSnackBar(context, e.toString());
//     }
//     return {
//       'sales': sales,
//       'totalEarnings': totalEarning,
//     };
//   }
// }
