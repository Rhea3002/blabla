import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecomm/features/admin/services/admin_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/widgets/custom_textfield.dart';
import '../../../constants/global_variables.dart';
import '../../../constants/utils.dart';
import '../../../providers/user_provider.dart';
import '../../auth/services/auth_service.dart';

//-----------------------------------------------------------ADD PRODUCT SCREEN CLASS-----------------------------------------
class AddProductScreen extends StatefulWidget {
  static const String routeName = '/add-product';
  final String category;
  const AddProductScreen({required this.category, super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  //all the form fields accepting inputs declarations
  final TextEditingController product_controller = TextEditingController();
  final TextEditingController description_controller = TextEditingController();
  final TextEditingController quantity_controller = TextEditingController();
  final TextEditingController price_controller = TextEditingController();
  final TextEditingController ram_controller = TextEditingController();
  final TextEditingController rom_controller = TextEditingController();
  final TextEditingController screentech_controller = TextEditingController();
  final TextEditingController os_controller = TextEditingController();
  final AdminServices adminServices = AdminServices();
  List<File> images = [];
  List<String> keywordlist = []; //KEYWORD
  String userInput = '';
  String useremail = '';
  final _addProductFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    product_controller.dispose();
    description_controller.dispose();
    price_controller.dispose();
    quantity_controller.dispose();
    ram_controller.dispose();
    rom_controller.dispose();
    screentech_controller.dispose();
    os_controller.dispose();
  }

  //Product Image Picker
  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  //sell button
  void sellProduct() {
    if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {
      adminServices.sellProduct(
        context: context,
        name: product_controller.text,
        description: description_controller.text,
        price: double.parse(price_controller.text),
        quantity: double.parse(quantity_controller.text),
        category: widget.category,
        images: images,
        keywordlist: [userInput],
        os: os_controller.text,
        ram: double.parse(ram_controller.text),
        rom: double.parse(rom_controller.text),
        screentech: screentech_controller.text,
        userId: useremail,
      );
    }
  }

  //KEYWORD FUNCTION____________________________________
  void addInputToList(String input) {
    setState(() {
      keywordlist.add(input);
    });
  }

  Widget displayUserInputs() {
    return ListView.builder(
      itemCount: keywordlist.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(keywordlist[index]),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    useremail = user.email;

    return Scaffold(
        //-----------------------APPBAR--------------------------
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
                Text(
                  "Add New Product",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        ),
        //------------------------APPBAR OVER-----------------
        body: SingleChildScrollView(
          child: Form(
              key: _addProductFormKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    //ADD Product Image

                    images.isNotEmpty
                        ? CarouselSlider(
                            items: images.map((i) {
                              return Builder(
                                  builder: (BuildContext context) => Image.file(
                                        i,
                                        fit: BoxFit.cover,
                                        height: 200,
                                      ));
                            }).toList(),
                            options: CarouselOptions(
                              viewportFraction: 1,
                              height: 200,
                            ),
                          )
                        : GestureDetector(
                            onTap: selectImages,
                            child: Container(
                              width: double.infinity,
                              height: 150,
                              decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Column(
                                children: [
                                  SizedBox(height: 30),
                                  Icon(Icons.folder_copy_rounded),
                                  SizedBox(height: 10),
                                  Text(
                                    'Add Product Image',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                    //PRoduct Image------
                    const SizedBox(height: 20),
                    CustomTextField(
                        controller: product_controller,
                        hintText: 'Product Name'),
                    SizedBox(height: 10),
                    CustomTextField(
                      controller: description_controller,
                      hintText: 'Description Name',
                      maxLines: 7,
                    ),
                    SizedBox(height: 10),
                    CustomTextField(
                      controller: price_controller,
                      hintText: 'Price',
                      keyboardType: TextInputType.number,
                    ),

                    //-----------------------------------------------------------------------
                    SizedBox(height: 10),
                    CustomTextField(
                        controller: ram_controller, hintText: 'RAM'),

                    SizedBox(height: 10),
                    CustomTextField(
                        controller: rom_controller, hintText: 'Storage'),

                    SizedBox(height: 10),
                    CustomTextField(
                        controller: screentech_controller,
                        hintText: 'Screen Technology'),

                    SizedBox(height: 10),
                    CustomTextField(controller: os_controller, hintText: 'OS'),
                    SizedBox(height: 10),
                    CustomTextField(
                      controller: quantity_controller,
                      hintText: 'Quantity',
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 10),
                    //KeyWORD FOR SEARCHES
                    TextFormField(
                      decoration: const InputDecoration(
                          hintText: 'Keywords',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.black38,
                          )),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.black38,
                          ))),
                      onChanged: (value) {
                        userInput = value;
                      },
                    ),

                    SizedBox(height: 10),
                    Container(
                      child: Text("Email:  $useremail "),
                    ),

                    //----------------------------------------------------

                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.0),
                      child: GestureDetector(
                        onTap: () {
                          sellProduct();
                        },
                        child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(255, 86, 221, 210),
                                Color.fromARGB(255, 51, 63, 225),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'SELL',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    )
                  ],
                ),
              )),
        ));
  }
}

//--------------------------------------ADD CATEGORY SCREEN-------------------------------------------------------------
class AddCategory extends StatefulWidget {
  static const String routeName = '/add-category';
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  String category = 'Mobiles';
  @override
  //Product Categories
  List<String> productCategories = ['Mobiles', 'Laptops'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //-----------------------APPBAR--------------------------
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
              Text(
                "Select Category",
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
      //------------------------APPBAR OVER-----------------
      body: Center(
        child:

            ///DROPDOWN ------------>
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
              // child: DropdownButton(
              //     value: category,
              //     icon: Icon(Icons.arrow_drop_down_circle_outlined),
              //     items: productCategories.map((String item) {
              //       return DropdownMenuItem(value: item, child: Text(item));
              //     }).toList(),
              //     onChanged: (String? newVal) {
              //       setState(() {
              //         category = newVal!; ////CATEGORY VALUEEE FOR DB
              //       });
              //     }),

              child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[200],
            ),
            child: DropdownButton<String>(
              value: category,
              icon: Icon(Icons.arrow_drop_down, color: Colors.deepPurple),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
              underline: SizedBox(), // Remove the underline
              onChanged: (String? newVal) {
                setState(() {
                  category = newVal!; ////CATEGORY VALUE FOR DB
                });
              },
              items: productCategories.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item, style: TextStyle(fontSize: 20)),
                );
              }).toList(),
            ),
          )),
          //DROPDOWN=--------->,
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddProductScreen(
                            category: category,
                          )),
                );
              },
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                color: GlobalVariables.secondaryColor,
                ),
                child: Center(
                  child: Text(
                    'NEXT',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // ElevatedButton(
          //   child: Text(
          //     'Next',
          //   ),
          //   onPressed: () {
          //     //AddProductScreen category1 = AddProductScreen(category: category,);
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //           builder: (context) => AddProductScreen(
          //                 category: category,
          //               )),
          //     );
          //   },
          //   style: ElevatedButton.styleFrom(
          //     minimumSize: const Size(double.infinity, 50),
          //   ),
          // )
        ]),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => AuthService().logOut(context),
      //   backgroundColor: Color.fromARGB(255, 86, 221, 210),
      //   child: const Icon(Icons.logout),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
