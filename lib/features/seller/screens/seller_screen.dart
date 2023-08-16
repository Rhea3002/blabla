import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';

import '../../../constants/global_variables.dart';

class SellerScreen extends StatefulWidget {
  static const String routeName = '/sellerscreen';
  const SellerScreen({super.key});

  @override
  State<SellerScreen> createState() => _SellerScreenState();
}

class _SellerScreenState extends State<SellerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          titleSpacing: -6,
          title:Transform.translate(
            offset: Offset(0, 6.5), // Adjust the vertical offset as needed to move the title down
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Expanded(
                child: Container(
                  height: 42,
                  margin: const EdgeInsets.only(left: 15),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      //onFieldSubmitted: navigateToSearchScreen,
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.only(
                              left: 6,
                            ),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 23,
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(top: 10),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black38,
                            width: 1,
                          ),
                        ),
                        hintText: 'Search Ecomm.in',
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Container(
              //   color: Colors.transparent,
              //   height: 42,
              //   margin: const EdgeInsets.symmetric(horizontal: 10),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
                    // const Icon(Icons.shopping_cart, color: Colors.black, size: 25),
                    // const Icon(Icons.menu, color: Colors.black, size: 25),
            //       ],
            //     ),
            //   ),
            ],
          ),

        ),
        actions: [
          IconButton(
      icon: Icon(Icons.shopping_cart),
      onPressed: () {
        // Code to handle search icon press
      },
    ),
    IconButton(
      icon: Icon(Icons.menu),
      onPressed: () {
        // Code to handle settings icon press
      },
    ),
        ],
      ),
      ),
      body:SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Card(
              // elevation: 8.0,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Color.fromRGBO(255, 153, 0, 1)),
                borderRadius: BorderRadius.circular(50.0),
              ),
              child: Container(
                    width: MediaQuery.of(context).size.width * 0.9, // Adjust width based on the screen size
                    height: 80,
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 40.0),
                    color: Colors.white,
                    child:  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
              'Sell here',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
                        ),
                        // SizedBox(
                        //   height: 80,
                        //   width: 140,
                        //   child: ElevatedButton(
                        //     style: ElevatedButton.styleFrom(
                        //       shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.all(Radius.circular(50))),
                        //     ),
                        //     onPressed: (){} , child: Text("Start Selling", 
                        //     style: const TextStyle(
                        //         // color: Colors.indigo,
                        //         // fontWeight: FontWeight.w600,
                        //         fontSize: 20,
                        //     )
                          
                        //   ),),
                        // ),

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
              onPress: () {
                
              },
            ),
                      ],
                    ),
                  ),),
            ),
          ],
        ),)
    );
  }
}
