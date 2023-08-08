import 'package:ecomm/features/admin/screens/add_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/widgets/loader.dart';
import '../../../constants/global_variables.dart';
import '../../../models/product.dart';
import '../../../providers/user_provider.dart';
import '../../account/widgets/singleproduct.dart';
import '../../auth/services/auth_service.dart';
import '../services/admin_services.dart';

class AdminScreen extends StatefulWidget {
  static const String routeName = '/admin';
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  List<Product>? products;
  final AdminServices adminServices = AdminServices();
  String useremail = '';

  @override
  void initState() {
    super.initState();
    fetchAllProducts();

  }

  // fetchAllProducts() async {
  //   products = await adminServices.fetchAllProducts(context);
  //   setState(() {});
  // }

  //NEWLY ADDED____________________________________________________________________________
  fetchAllProducts() async {
    products = await adminServices.fetchProducts(context, useremail);
    setState(() {});
  }
  //--------------------------------------------------------------------------------------

  void deleteProduct(Product product, int index) {
    adminServices.deleteProduct(
      context: context,
      product: product,
      onSuccess: () {
        products!.removeAt(index);
        setState(() {});
      },
    );
  }

  void navigateToAddProduct() {
    Navigator.pushNamed(context, AddCategory.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    useremail = user.email;

    // return Scaffold(
    //   body: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       Center(child: Text(user.toJson())),
    //       const Text("AdminScreen Page"),
    //     ],
    //   ),

    return products == null
        ? const Loader()
        : Scaffold(
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
                    const Text(
                      'Admin',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ),
            body: GridView.builder(
              itemCount: products!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                final productData = products![index];
                return Column(
                  children: [
                    SizedBox(
                      height: 140,
                      child: SingleProduct(
                        image: productData.images[0],
                      ),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Text(
                              productData.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                          IconButton(
                            onPressed: () => deleteProduct(productData, index),
                            icon: const Icon(
                              Icons.delete_outline,
                            ),
                          ),
                        ])
                    //     SizedBox(height: 10),
                    //     ElevatedButton(
                    //   child: Text(
                    //     'LOGOUT',
                    //   ),
                    //   onPressed: () {
                    //     AuthService().logOut(context);
                    //   },
                    //   style: ElevatedButton.styleFrom(
                    //     minimumSize: const Size(double.infinity, 50),
                    //   ),
                    // )
                  ],
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => navigateToAddProduct(),
              backgroundColor: Colors.green,
              child: const Icon(Icons.add),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
