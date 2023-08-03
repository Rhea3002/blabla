import 'package:flutter/material.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({super.key});

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 10, top: 15),
          child: const Text(
            "Deal of the day",
            style: TextStyle(fontSize: 20),
          ),
        ),
        Image.network("https://images.unsplash.com/photo-1690141001405-456018efb3f9?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwzMnx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
          fit: BoxFit.fitHeight 
        ),
        Container(
          padding: const EdgeInsets.only(left:15),
          alignment: Alignment.topLeft,
          child: const Text("\u{20B9} 999", style: TextStyle(fontSize: 18)),
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left:15, top:5, right: 40),
          child: const Text("Space", maxLines: 1, overflow: TextOverflow.ellipsis),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: [
            Image.network("https://images.unsplash.com/photo-1690695585525-8610507695de?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=870&q=80", fit: BoxFit.fitWidth, width: 100, height: 100),
            Image.network("https://images.unsplash.com/photo-1690695585525-8610507695de?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=870&q=80", fit: BoxFit.fitWidth, width: 100, height: 100),
            Image.network("https://images.unsplash.com/photo-1690695585525-8610507695de?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=870&q=80", fit: BoxFit.fitWidth, width: 100, height: 100),
            Image.network("https://images.unsplash.com/photo-1690695585525-8610507695de?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=870&q=80", fit: BoxFit.fitWidth, width: 100, height: 100),
            Image.network("https://images.unsplash.com/photo-1690695585525-8610507695de?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=870&q=80", fit: BoxFit.fitWidth, width: 100, height: 100),
            Image.network("https://images.unsplash.com/photo-1690695585525-8610507695de?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=870&q=80", fit: BoxFit.fitWidth, width: 100, height: 100),
          ]),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 15,
          ).copyWith(left: 15),
          alignment: Alignment.topLeft,
          child: Text(
            'See all deals',
            style: TextStyle(
              color: Colors.cyan[800],
            ),
          ),
        ),
      ],
    );
  }
}
