
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart' as charts;
import '../modules/sales.dart';
import '../services/admin_services.dart';

class AnalysisScreen extends StatefulWidget {
  const AnalysisScreen({super.key});

  @override
  State<AnalysisScreen> createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {

  final AdminServices adminServices = AdminServices();
  int? totalSales;
  List<Sales>? earnings;

  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  getEarnings() async {
    var earningData = await adminServices.getEarnings(context);
    totalSales = earningData['totalEarnings'];
    earnings = earningData['sales'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return earnings == null || totalSales == 0
        ? Center(
              child: Container(
                  child: Column(
                children: [
                  Image.asset('assets/images/noOrders.png'),
                  Text("No Sales Yet!!",
                      style: TextStyle(fontSize: 15, color: Colors.black))
                ],
              )),
            )
        : Column(
            children: [
              const SizedBox(height: 10,),
              Text(
                'Total Sales: \u{20B9}${NumberFormat('#,###').format(totalSales!.toInt())}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10,),
              SizedBox(
                height: 250,
                child: 
                charts.SfCartesianChart(
      series: <charts.ChartSeries<Sales, String>>[
        charts.BarSeries<Sales, String>(
          name: 'Sales',
          dataSource: earnings!,
          xValueMapper: (Sales sales, _) => sales.label,
          yValueMapper: (Sales sales, _) => sales.earning,
          // dataLabelSettings: charts.DataLabelSettings(isVisible: true),
        ),
      ],
      primaryXAxis: charts.CategoryAxis(),
      primaryYAxis: charts.NumericAxis(),
      tooltipBehavior: charts.TooltipBehavior(enable: true),
    )
                // CategoryProductsChart(seriesList: [
                //   charts.BarSeries(
                //     name: 'Sales',
                //     dataSource: earnings!,
                //     xValueMapper: (Sales sales, _) => sales.label,
                //     yValueMapper: (Sales sales, _) => sales.earning,
                //     animationDuration: 1000,
                //   ),
                // ]
                // ),
              )
            ],
          );
          
  // @override
  // Widget build(BuildContext context) {
  //   return const Scaffold(
  //     body: Center(
  //       child: Text("Analysis Page"),
  //     ),
  //   );
  }
}