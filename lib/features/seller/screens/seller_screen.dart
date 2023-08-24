import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:provider/provider.dart';

import '../../../constants/global_variables.dart';
import '../../../providers/user_provider.dart';
import '../../auth/services/auth_service.dart';
import '../../search/screens/search_screen.dart';

class SellerScreen extends StatefulWidget {
  static const String routeName = '/sellerscreen';
  const SellerScreen({super.key});

  @override
  State<SellerScreen> createState() => _SellerScreenState();
}

class _SellerScreenState extends State<SellerScreen> {
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
//final userCartLen = context.watch<UserProvider>().user.cart.length;

    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.cyan[300],
            title: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 254, 254),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextFormField(
                      onFieldSubmitted: navigateToSearchScreen,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 8),
                        isDense: true,
                        border: InputBorder.none,
                        prefixIcon: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 3), // add padding to adjust icon
                          child: Icon(
                            Icons.search,
                            size: 25,
                            color: Color.fromARGB(255, 23, 24, 24),
                          ),
                        ),
                        hintText: ' Search?',
                      ),
                    ),
                  ),
                ),
              ],
            )),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  // elevation: 8.0,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Color.fromRGBO(255, 153, 0, 1)),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width *
                        0.9, // Adjust width based on the screen size
                    height: 80,
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                    color: Colors.white,
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Click Here -->',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        AnimatedButton(
                          height: 70,
                          width: 170,
                          text: 'Start Selling',
                          isReverse: true,
                          selectedTextColor: Color.fromRGBO(255, 153, 0, 1),
                          transitionType: TransitionType.TOP_CENTER_ROUNDER,
                          // textStyle: submitTextStyle,
                          backgroundColor: Color.fromRGBO(255, 153, 0, 1),
                          // borderColor: Colors.white,
                          borderRadius: 50,
                          borderWidth: 2,
                          onPress: () => AuthService().logOut(context, true),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(18.0),
                alignment: Alignment.topLeft,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: Color.fromRGBO(255, 153, 0, 1),
                    width: 2.0,
                  ),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Steps to follow',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      '1. Click on the above button',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 7.0),
                    Text(
                        '2. Create a New Seller account by choosing "Seller" option.',
                        style: TextStyle(fontSize: 18)),
                    SizedBox(height: 7.0),
                    Text('3. Fill other details',
                        style: TextStyle(fontSize: 18)),
                    SizedBox(height: 7.0),
                    Text('4. Login again using the same credentials.',
                        style: TextStyle(fontSize: 18)),
                    SizedBox(height: 7.0),
                    Text(
                        '5. Use the \'+\' at the bottom of the screen to add product details.',
                        style: TextStyle(fontSize: 18)),
                    SizedBox(height: 7.0),
                    Text('6. Fill the details and click the "SELL" button.',
                        style: TextStyle(fontSize: 18)),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
