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
import '../widgets/top_categories.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

    
  
  @override
  Widget build(BuildContext context) {
  //  final user = Provider.of<UserProvider>(context).user;

    return const Scaffold(

        
        // body: Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Center(child: Text(user.toJson())),
        //     const Text("HomeScreen Page"),
        //     SizedBox(height: 10),
        //   ],
        // ),
        //---------------------BODY--------------------------------
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              TopCategories(), //widget
              SizedBox(height: 10),
              CarouselImg(), //widget
              DealOfDay(),
              SizedBox(height: 10),
              // Center(child: Text(user.toJson())),
              //Text("HomeScreen Page"),
            ],
          ),
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
