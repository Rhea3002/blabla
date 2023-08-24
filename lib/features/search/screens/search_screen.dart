import 'package:ecomm/common/widgets/bottombar.dart';
import 'package:ecomm/features/search/widgets/searched_product.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/widgets/loader.dart';
import '../../../models/product.dart';
import '../../product_details/screens/product_details_screen.dart';
import '../services/search_services.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/search-screen';
  final String searchQuery;
  const SearchScreen({
    Key? key,
    required this.searchQuery,
  }) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Product>? products;
  final SearchServices searchServices = SearchServices();

  @override
  void initState() {
    super.initState();
    fetchSearchedProduct();
  }

  fetchSearchedProduct() async {
    products = await searchServices.fetchSearchedProduct(
        context: context, searchQuery: widget.searchQuery);
    setState(() {});
  }

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  double _minPrice = 0;
  double _maxPrice = 50000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: products == null
          ? const Loader()
          : Column(
              children: [
                Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26)),
                    height: 50,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          ),
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Column(
                                  children: [
                                    Text('Filter',
                                        style: GoogleFonts.dmSerifDisplay(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 28,
                                        )),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      child: Column(children: [
                                        Text(
                                          'Price Range',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        RangeSlider(
                                          values:
                                              RangeValues(_minPrice, _maxPrice),
                                         
                                          onChanged: (values) {
                                            setState(() {
                                              _minPrice = values.start;
                                              _maxPrice = values.end;
                                            });
                                          },
                                          min: 0,
                                          max: 50000,
                                        ),
                                        Text('Min Price: $_minPrice'),
                                        Text('Max Price: $_maxPrice'),
                                        SizedBox(
                                          height: 30,
                                        ),
                                      ]),
                                    ),
                                    //   ElevatedButton(
                                    //   onPressed: applyFilters,
                                    //   child: Text('Apply Filters'),
                                    // ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Text(
                            "Filter",
                            style: TextStyle(
                              color: Colors.blue[500],
                              fontSize: 25,
                            ),
                          )),
                    )),

                // const AddressBox(),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: products!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            ProductDetailScreen.routeName,
                            arguments: products![index],
                          );
                        },
                        child: SearchedProduct(
                          product: products![index],
                        ),
                      );
                      // return SearchedProduct(product: products![index]);
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
