import 'package:flutter/material.dart';

//connecting android simulator to our ip address
String uri = 'blabla-lx1eswxke-rhea3002.vercel.app';

//class that will have all static values
class GlobalVariables {
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 29, 201, 192),
      Color.fromARGB(255, 125, 221, 216),
    ],
    stops: [0.5, 1.0],
  );

  static const secondaryColor = Color.fromARGB(255, 51, 63, 225);
  static const backgroundColor = Colors.white;
  // static var navyblue = Colors.indigo[900];
  static const Color greyBackgroundCOlor = Color(0xffebecee);
  static var selectedNavBarColor = Colors.cyan[800]!;
  static const unselectedNavBarColor = Colors.black87;

// STATIC IMAGES
  static const List<String> carouselImages = [
    'https://rukminim1.flixcart.com/fk-p-flap/1600/270/image/5f478a106d047aba.jpg?q=20',
    'https://images-eu.ssl-images-amazon.com/images/G/31/img21/Wireless/WLA/TS/D37847648_Accessories_savingdays_Jan22_Cat_PC_1500.jpg',
    'https://images-eu.ssl-images-amazon.com/images/G/31/img2021/Vday/bwl/English.jpg',
    'https://images-eu.ssl-images-amazon.com/images/G/31/img22/Wireless/AdvantagePrime/BAU/14thJan/D37196025_IN_WL_AdvantageJustforPrime_Jan_Mob_ingress-banner_1242x450.jpg',
    'https://images-na.ssl-images-amazon.com/images/G/31/Symbol/2020/00NEW/1242_450Banners/PL31_copy._CB432483346_.jpg',
    'https://images-na.ssl-images-amazon.com/images/G/31/img21/shoes/September/SSW/pc-header._CB641971330_.jpg',
  ];

  static const List<Map<String, String>> categoryImages = [
    {
      'title': 'Mobiles',
      'image': 'assets/images/mobiles.jpeg',
    },
    // {
    //   'title': 'Appliances',
    //   'image': 'assets/images/appliances.jpeg',
    // },
    {
      'title': 'Laptops',
      'image': 'assets/images/electronics.jpeg',
    },
    // {
    //   'title': 'Books',
    //   'image': 'assets/images/books.jpeg',
    // },
    // {
    //   'title': 'Fashion',
    //   'image': 'assets/images/fashion.jpeg',
    // },
  ];
}
