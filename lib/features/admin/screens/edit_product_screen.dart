import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/widgets/custom_textfield.dart';
import '../../../constants/global_variables.dart';
import '../../../constants/utils.dart';
import '../../../models/product.dart';
import '../../../providers/user_provider.dart';
import '../services/admin_services.dart';

class EditProductScreen extends StatefulWidget {
  final Product product;

  EditProductScreen({required this.product});
  // const EditProductScreen({super.key});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
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
  String name = '';
  final _addProductFormKey1 = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    name = widget.product.name;
    product_controller.text = widget.product.name;
    description_controller.text = widget.product.description;
    price_controller.text = widget.product.price.toString();
    quantity_controller.text = widget.product.quantity.toString();
    ram_controller.text = widget.product.ram.toString();
    rom_controller.text = widget.product.rom.toString();
    screentech_controller.text = widget.product.screentech;
    os_controller.text = widget.product.os;
    keywordlist = widget.product.keywordlist;
  }

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  void updateProduct() async {
    String updatedProduct = product_controller.text;
    String updatedDesc = description_controller.text;
    double updatedPrice = double.parse(price_controller.text);
    double updatedQty = double.parse(quantity_controller.text);
    double updatedRAM = double.parse(ram_controller.text);
    double updatedROM = double.parse(rom_controller.text);
    String updatedScreen = screentech_controller.text;
    String updatedOS = os_controller.text;
    String folderId = name;

    if (_addProductFormKey1.currentState!.validate() && images.isNotEmpty) {
      await adminServices.updateProductService(
        context: context,
        id: widget.product.id,
        updatedProduct: updatedProduct,
        updatedDesc: updatedDesc,
        updatedPrice: updatedPrice,
        updatedRAM: updatedRAM,
        updatedROM: updatedROM,
        updatedScreen: updatedScreen,
        updatedOS: updatedOS,
        updatedQty: updatedQty,
        folderId: folderId,
        updatedImages: images,
        keywordlist: keywordlist,
        userId: useremail,
      );
    } else {
      showSnackBar(context, "Please choose product images");
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    useremail = user.email;

    return Scaffold(
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
                  "Edit Product",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
              key: _addProductFormKey1,
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
                                    'Add New Product Image',
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
                          showSnackBar2(context,
                              "Updating Product Details...Please wait!");
                          updateProduct();
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
                              'UPDATE',
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
