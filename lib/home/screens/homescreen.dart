// import 'package:ecomm/features/account/screens/account_screen.dart';
// import 'package:ecomm/features/admin/screens/add_product_screen.dart';
// import 'package:ecomm/features/auth/services/auth_service.dart';
import 'package:ecomm/home/widgets/carousel_image.dart';
import 'package:ecomm/home/widgets/deal_of_the_day.dart';
import 'package:ecomm/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import '../../common/widgets/action_button.dart';
// import '../../common/widgets/expandable.dart';
// import '../../features/search/screens/search_screen.dart';
import '../../features/product_details/screens/product_details_screen.dart';
import '../../models/product.dart';
import '../services/home_services.dart';
import '../widgets/DealTIle.dart';
import '../widgets/top_categories.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product>? productList;
  final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    fetchRecommendation();
  }

  fetchRecommendation() async {
    productList = await homeServices.fetchRecommendation(
      context: context,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    //  final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      // body: Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     Center(child: Text(user.toJson())),
      //     const Text("HomeScreen Page"),
      //     SizedBox(height: 10),
      //   ],
      // ),
      //---------------------BODY--------------------------------
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          TopCategories(), //widget
          const SizedBox(height: 10),
          CarouselImg(), //widgeta
          const SizedBox(height: 10),
          Text(
            "Top Deals",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: productList!.length,
                itemBuilder: (context, index) {
                  final product = productList![index];
                  return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          ProductDetailScreen.routeName,
                          arguments: product,
                        );
                      },
                      child: DealTile(product: product));
                }),
          ),
        ],
      ),

      //------------------BODY--------------------------------------

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => AuthService().logOut(context),
      //   backgroundColor: Colors.green,
      //   child: const Icon(Icons.logout),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      // floatingActionButton: ExpandableFAB(distance: 120, children: [
      //   ActionButton(
      //     icon: Icon(Icons.logout_outlined, color: Colors.white),
      //     onPressed: () => AuthService().logOut(context),
      //   ),
      //   ActionButton(
      //     icon: Icon(Icons.person, color: Colors.white),
      //     onPressed: () {
      //       Navigator.push(
      //           context,
      //           MaterialPageRoute(
      //               builder: (context) => const AccountScreen()));
      //     },
      //   ),
      //   ActionButton(
      //       icon: Icon(Icons.home, color: Colors.white),
      //       onPressed: () {
      //         Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //                 builder: (context) => const AddCategory()));
      //       }),
    );
  }
}
