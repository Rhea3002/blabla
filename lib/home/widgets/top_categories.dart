import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/global_variables.dart';
import '../screens/category_deals_screen.dart';

class TopCategories extends StatelessWidget {
  const TopCategories({Key? key}) : super(key: key);

  void navigateToCategoryPage(BuildContext context, String category) {
    Navigator.pushNamed(context, CategoryDealsScreen.routeName,
        arguments: category);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemExtent: 190,
          itemCount: GlobalVariables.categoryImages.length,
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () => navigateToCategoryPage(
                      context,
                      GlobalVariables.categoryImages[index]['title']!,
                    ),
                child:
                    Container(
                       margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                      // Container(
                      //   color: Colors.black12.withOpacity(0.03),
                      //   child: Row(children: [
                      //     Container(
                      //     padding: EdgeInsets.symmetric(horizontal: 10),
                      //     child: ClipRRect(
                      //       borderRadius: BorderRadius.circular(5),
                      //       child: Image.asset(
                      //         GlobalVariables.categoryImages[index]['image']!,
                      //         fit: BoxFit.cover,
                      //         height: 45,
                      //         width: 45,
                    
                      //       ),
                      //     ),
                      //   ),
                      //   Text(GlobalVariables.categoryImages[index]['title']!,
                      //   style: const TextStyle(
                      //     fontSize: 10,
                      //     fontWeight: FontWeight.w400
                      //   ),
                      //   ),
                      //   ],),
                      // )
                      Expanded(
                                      child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      height: 30,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 15),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.asset(
                              GlobalVariables.categoryImages[index]['image']!,
                              fit: BoxFit.cover,
                              height: 45,
                              width: 45,
                            ),
                          ),
                          const SizedBox(
                              width: 15), // Adjust spacing between image and text
                          Text(
                            GlobalVariables.categoryImages[index]['title']!,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 16),
                          ),
                        ],
                      ),
                                      ),
                                    ),
                                  ],
                                ),
                    ));
          }),
    );
  }
}
