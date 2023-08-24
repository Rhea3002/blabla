import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SingleProduct extends StatelessWidget {
  final String image;
  const SingleProduct({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black12,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        child: Container(
          width: 180,
          padding: const EdgeInsets.all(10),
          child: Image.network(
            image,
            fit: BoxFit.fitHeight,
            width: 180,
          ),
        ),
      ),
    );
  }
}

class SingleProduct2 extends StatelessWidget {
  final String image;
  final String date;
  const SingleProduct2({
    Key? key,
    required this.image,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black12,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Container(
              width: 180,
              height: 145,
              padding: const EdgeInsets.all(10),
              child: Image.network(
                image,
                fit: BoxFit.fitHeight,
                width: 150,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              child: Text('Order Placed: '+ date),
            )
          ],
        ),
      ),
    );
  }
}
