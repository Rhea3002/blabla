import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../common/widgets/custom_button.dart';
import '../../constants/global_variables.dart';
import '../../models/order.dart';
import '../../providers/user_provider.dart';
import '../admin/services/admin_services.dart';
import '../search/screens/search_screen.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdfWidgets;
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';

class OrderDetailScreen extends StatefulWidget {
  static const String routeName = '/order-details';
  final Order order;
  const OrderDetailScreen({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  int currentStep = 0;
  final AdminServices adminServices = AdminServices();

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  void initState() {
    super.initState();
    currentStep = widget.order.status;
  }

  //!!! ONLY FOR ADMIN!!!
  void changeOrderStatus(int status) {
    adminServices.changeOrderStatus(
      context: context,
      status: status + 1,
      order: widget.order,
      onSuccess: () {
        setState(() {
          currentStep += 1;
        });
      },
    );
  }

  // Future<pdfWidgets.Widget> buildPDFContent(
  //     Order order, String userAddress) async {
  //   final pdfWidgets.ThemeData theme = pdfWidgets.ThemeData.withFont(
  //     base: pdfWidgets.Font.ttf(
  //         await rootBundle.load('assets/fonts/OpenSans-Regular.ttf')),
  //     bold: pdfWidgets.Font.ttf(
  //         await rootBundle.load('assets/fonts/OpenSans-Bold.ttf')),
  //   );
  //   return pdfWidgets.Column(
  //     crossAxisAlignment: pdfWidgets.CrossAxisAlignment.start,
  //     children: [
  //       // Heading: Invoice
  //       pdfWidgets.Center(
  //         child: pdfWidgets.Text(
  //           'Invoice',
  //           style: pdfWidgets.TextStyle(
  //             fontSize: 26,
  //           ),
  //         ),
  //       ),
  //       pdfWidgets.Divider(),
  //       // Order Date and Order ID
  //       pdfWidgets.Text(
  //           'Order Date: ${DateFormat().format(DateTime.fromMillisecondsSinceEpoch(order.orderedAt))}'),
  //       pdfWidgets.Text('Order ID: ${order.id}'),
  //       // User Address
  //       pdfWidgets.Text('Delivery Address: $userAddress'),
  //       // Purchase Details Heading
  //       pdfWidgets.SizedBox(height: 10),
  //       pdfWidgets.Text(
  //         'Purchase Details',
  //         style: pdfWidgets.TextStyle(
  //           fontSize: 22,
  //           fontWeight: pdfWidgets.FontWeight.bold,
  //         ),
  //       ),
  //       // Create a table for the product details
  //       pdfWidgets.TableHelper.fromTextArray(
  //         // context: pdfWidgets.Context(),
  //         data: <List<String>>[
  //           <String>['Serial No.', 'ProductName', 'Quantity', 'Total Value'],
  //           for (int i = 0; i < order.products.length; i++)
  //             <String>[
  //               (i + 1).toString(),
  //               order.products[i].name,
  //               widget.order.quantity[i].toString(),
  //               'Rupees: ${(widget.order.products[i].price * widget.order.quantity[i]).toStringAsFixed(2)}',
  //             ],
  //         ],
  //         tableWidth: pdfWidgets.TableWidth.max,
  //         cellAlignment: pdfWidgets.Alignment.centerLeft,
  //         headerDecoration: pdfWidgets.BoxDecoration(
  //           color: PdfColors.grey300,
  //         ),
  //         cellAlignments: {
  //           0: pdfWidgets.Alignment.centerLeft,
  //           1: pdfWidgets.Alignment.centerLeft,
  //           2: pdfWidgets.Alignment.centerLeft,
  //           3: pdfWidgets.Alignment.centerLeft,
  //         },
  //       ),
  //       // Total Invoice Amount
  //       pdfWidgets.Align(
  //         alignment: pdfWidgets.Alignment.bottomRight,
  //         child: pdfWidgets.Text(
  //           'Total Invoice Amount: Rupees: ${order.totalPrice.toStringAsFixed(2)}',
  //           style: pdfWidgets.TextStyle(
  //             fontSize: 20,
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

// Create a function to generate and save the PDF
  Future<void> generateAndSavePDF(Order order, String userAddress) async {
    final pdf = pdfWidgets.Document();

    // final customFont = pdfWidgets.Font.ttf(
    //     await rootBundle.load("assets/fonts/Roboto-Regular.ttf"));

    // Define your PDF content here
    final pdfContent = <pdfWidgets.Widget>[
      pdfWidgets.Center(
        child: pdfWidgets.Text(
          'Invoice',
          // style: pdfWidgets.TextStyle(fontSize: 26, font: customFont),
        ),
      ),
      pdfWidgets.Divider(),
      // Order Date and Order ID
      pdfWidgets.Text(
          'Order Date: ${DateFormat().format(DateTime.fromMillisecondsSinceEpoch(order.orderedAt))}'),
      pdfWidgets.Text('Order ID: ${order.id}'),
      // User Address
      pdfWidgets.Text('Delivery Address: $userAddress'),
      // Purchase Details Heading
      pdfWidgets.SizedBox(height: 10),
      pdfWidgets.Text(
        'Purchase Details',
        // style: pdfWidgets.TextStyle(
        //   font: customFont,
        //   fontSize: 22,
        //   fontWeight: pdfWidgets.FontWeight.bold,
        // ),
      ),
      // Create a table for the product details
      pdfWidgets.TableHelper.fromTextArray(
        // context: pdfWidgets.Context(),
        data: <List<String>>[
          <String>['Serial No.', 'ProductName', 'Quantity', 'Total Value'],
          for (int i = 0; i < order.products.length; i++)
            <String>[
              (i + 1).toString(),
              order.products[i].name,
              widget.order.quantity[i].toString(),
              'Rupees: ${(widget.order.products[i].price * widget.order.quantity[i]).toStringAsFixed(2)}',
            ],
        ],
        tableWidth: pdfWidgets.TableWidth.max,
        cellAlignment: pdfWidgets.Alignment.centerLeft,
        headerDecoration: pdfWidgets.BoxDecoration(
          color: PdfColors.grey300,
        ),
        cellAlignments: {
          0: pdfWidgets.Alignment.centerLeft,
          1: pdfWidgets.Alignment.centerLeft,
          2: pdfWidgets.Alignment.centerLeft,
          3: pdfWidgets.Alignment.centerLeft,
        },
      ),
      // Total Invoice Amount
      pdfWidgets.Align(
        alignment: pdfWidgets.Alignment.bottomRight,
        child: pdfWidgets.Text(
          'Total Invoice Amount: Rupees: ${order.totalPrice.toStringAsFixed(2)}',
          //style: pdfWidgets.TextStyle(fontSize: 20, font: customFont),
        ),
      ),
    ];

    pdf.addPage(
      pdfWidgets.Page(
        build: (context) {
          return pdfWidgets.Column(
            children: pdfContent,
          );
        },
      ),
    );

    // Save the PDF to a file
    //final file = File('invoice.pdf');
    final downloadsDirectory = await DownloadsPathProvider.downloadsDirectory;
    print(downloadsDirectory);

    // Check if the directory is not null before proceeding
    if (downloadsDirectory != null) {
      final pdfFile = File('${downloadsDirectory.path}/invoice.pdf');
      print(pdfFile);

      final status = await Permission.storage.request();
      if (status.isGranted) {
        print('Before PDF generation and saving');
        await pdfFile.writeAsBytes(await pdf.save());
        print('After PDF generation and saving');
      } else {
        print('Error while generating or saving PDF');
      }
    } else {
      print('Downloads directory is null');
    }
  }

//   Future<void> downloadInvoice(Order order, String userAddress) async {
//   final pdf = adminServices.generateInvoiceDocument(order, userAddress);
//   final filePath = '/path/to/save/invoice.pdf';
//   final file = File(filePath);
//   await file.writeAsBytes(await pdf.save());
// }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    //final double center = (MediaQuery.of(context).size.width)/2;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'View order details',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order Date:      ${DateFormat().format(
                        DateTime.fromMillisecondsSinceEpoch(
                            widget.order.orderedAt),
                      )}',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'Order ID:          ${widget.order.id}',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Order Total:      \u{20B9}${widget.order.totalPrice}',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Visibility(
                      visible: user.type == 'user',
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                          color: Colors.red,
                        )),
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.save_alt,
                              ),
                              onPressed: () async {
                                await generateAndSavePDF(
                                    widget.order, user.address);
                              },
                              color: Colors.red,
                            ),
                            Text('Download Invoice'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Purchase Details',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for (int i = 0; i < widget.order.products.length; i++)
                      Row(
                        children: [
                          Image.network(
                            widget.order.products[i].images[0],
                            height: 120,
                            width: 120,
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.order.products[i].name,
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  'Qty: ${widget.order.quantity[i]}',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Tracking',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                  ),
                ),
                child: Stepper(
                  currentStep: currentStep,
                  controlsBuilder: (context, details) {
                    if (user.type == 'admin') {
                      return CustomButton(
                        text: 'Done',
                        onTap: () => changeOrderStatus(details.currentStep),
                      );
                    }
                    return const SizedBox();
                  },
                  steps: [
                    Step(
                      title: const Text('Pending'),
                      content: const Text(
                        'Your order is yet to be delivered',
                      ),
                      isActive: currentStep > 0,
                      state: currentStep > 0
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                    Step(
                      title: const Text('Completed'),
                      content: const Text(
                        'Your order has been delivered, you are yet to sign.',
                      ),
                      isActive: currentStep > 1,
                      state: currentStep > 1
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                    Step(
                      title: const Text('Received'),
                      content: const Text(
                        'Your order has been delivered and signed by you.',
                      ),
                      isActive: currentStep > 2,
                      state: currentStep > 2
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                    Step(
                      title: const Text('Delivered'),
                      content: const Text(
                        'Your order has been delivered and signed by you!',
                      ),
                      isActive: currentStep >= 3,
                      state: currentStep >= 3
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
