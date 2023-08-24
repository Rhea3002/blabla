import 'dart:convert';
import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:ecomm/constants/error_handling.dart';
import 'package:ecomm/constants/global_variables.dart';
import 'package:ecomm/constants/utils.dart';
import 'package:ecomm/models/order.dart';
import 'package:ecomm/models/product.dart';
import 'package:ecomm/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdfWidgets;

import '../modules/sales.dart';

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
      final cloudinary = CloudinaryPublic('denfgaxvg', 'uszbstnu');
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
          Navigator.pop(context);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> updateProductService({
    required BuildContext context,
    String? id,
    required String updatedProduct,
    required String updatedDesc,
    required double updatedPrice,
    required double updatedRAM,
    required double updatedROM,
    required String updatedScreen,
    required String updatedOS,
    required double updatedQty,
    required String folderId,
    required List<File> updatedImages,
    required List<String> keywordlist,
    required String userId,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      final cloudinary = CloudinaryPublic('dzbnjysjj', 'hxsmg8kf');
      List<String> updatedImageUrls = [];

      for (int i = 0; i < updatedImages.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(updatedImages[i].path, folder: folderId),
        );
        updatedImageUrls.add(res.secureUrl);
      }

      http.Response res = await http.post(
        Uri.parse('$uri/admin/update-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': id,
          'name': updatedProduct,
          'price': updatedPrice,
          'description': updatedDesc,
          'quantity': updatedQty,
          'images': updatedImageUrls,
          'ram': updatedRAM,
          'rom': updatedROM,
          'screentech': updatedScreen,
          'os': updatedOS,
          'keywordlist': keywordlist,
        }),
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Product Updated Successfully!');
          Navigator.pop(context);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //---------------------------------------------------------------------------------------------------------------------

  // get all the products
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

  // Future<List<Order>> fetchAllOrders(BuildContext context) async {
  //   final userProvider = Provider.of<UserProvider>(context, listen: false);
  //   List<Order> orderList = [];
  //   try {
  //     http.Response res =
  //         await http.get(Uri.parse('$uri/admin/get-orders'), headers: {
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       'x-auth-token': userProvider.user.token,
  //     });

  //     //final ordersDataList = jsonDecode(res.body) as List<dynamic>;

  //     httpErrorHandle(
  //       response: res,
  //       context: context,
  //       onSuccess: () {
  //         for (int i = 0; i < jsonDecode(res.body).length; i++) {
  //           orderList.add(
  //             Order.fromJson(
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
  //   return orderList;
  // }

  //NEW------------------------------------------------------
  Future<List<Map<String, dynamic>>> fetchAdminOrders(
      BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Map<String, dynamic>> adminOrdersData = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/admin/get-orders'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          final ordersDataList = jsonDecode(res.body) as List<dynamic>;

          for (int i = 0; i < ordersDataList.length; i++) {
            final orderData = ordersDataList[i] as Map<String, dynamic>;
            final List<dynamic> products = orderData['products'];

            //print('Evaluating Order $i: $orderData');
            final hasMatchingUser = products.any((product) {
              final productUserId = product['product']['userId'];
              //print('Product User ID: $productUserId');
              return productUserId == userProvider.user.email;
            });

            if (hasMatchingUser) {
              adminOrdersData.add(orderData);
            }
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return adminOrdersData;
  }

  //------------------------------------------------------------

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

  Future<Map<String, dynamic>> getEarnings(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Sales> sales = [];
    int totalEarning = 0;
    try {
      final userId = userProvider.user.email;
      http.Response res =
          await http.get(Uri.parse('$uri/admin/analytics?userId=$userId'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          var response = jsonDecode(res.body);
          totalEarning = response['totalEarnings'];
          sales = [
            Sales('Mobiles', response['mobileEarnings']),
            Sales('Laptops', response['LaptopEarnings']),
            // Sales('Books', response['booksEarnings']),
            // Sales('Appliances', response['applianceEarnings']),
            // Sales('Fashion', response['fashionEarnings']),
          ];
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString()); 
    }
    return {
      'sales': sales,
      'totalEarnings': totalEarning,
    };
  }

  //---------------------------------------------------------
  pdfWidgets.Document generateInvoiceDocument(Order order, String userAddress) {
  final pdf = pdfWidgets.Document();

  pdf.addPage(
    pdfWidgets.Page(
      build: (context) {
        return pdfWidgets.Column(
          children: [
            pdfWidgets.Text('Order Details'),
            // Add order details here based on the `order` object
            pdfWidgets.Text('User Address: $userAddress'), // Add user's address
            // Add other order details...
          ],
        );
      },
    ),
  );

  return pdf;
}
}
