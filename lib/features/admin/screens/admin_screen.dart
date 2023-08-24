import 'package:ecomm/features/admin/screens/add_product_screen.dart';
import 'package:ecomm/features/admin/screens/edit_product_screen.dart';
import 'package:flutter/material.dart';
import '../../../common/widgets/loader.dart';
import '../../../models/product.dart';
import '../../account/widgets/singleproduct.dart';
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


  @override
void initState() {
  super.initState();
  fetchAllProducts();
}

fetchAllProducts() async {
  final updatedProducts = await adminServices.fetchAllProducts(context);
  setState(() {
    products = updatedProducts;
  });
}

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

    return products == null
        ? const Scaffold(body: Loader())
        : Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
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
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  productData.name,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context, MaterialPageRoute(builder: (context) => EditProductScreen(product: products![index],)));
                              },
                              icon: const Icon(
                                Icons.edit,
                              ),
                            ),
                            IconButton(
                              onPressed: () => deleteProduct(productData, index), 
                              icon: const Icon(
                                Icons.delete_outline,
                              ),
                            ),
                          ])
                    ],
                  );
                },
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => navigateToAddProduct(),
              backgroundColor: Color.fromARGB(255, 86, 221, 210),
              child: const Icon(Icons.add),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
